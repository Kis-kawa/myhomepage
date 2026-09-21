# サブブロックを導入したEtCで暗号化された画像を復号する。

import cv2
import numpy as np
import os
import argparse

class ImageDecryptor: # 画像の復号
    def __init__(self, key_seed): # イニシャライズ
        if key_seed is None:
            raise ValueError("復号には暗号化時と同じシード値(key_seed)が必要です。")
        self.seed = key_seed # 共通鍵シード
        self.rng = None # ランダム値生成器

        # RGBの順列: 0:RGB, 1:RBG, 2:GBR, 3:GRB, 4:BRG, 5:BGR (暗号化時と共通)
        self.rgb_perms = [
            [0, 1, 2], [0, 2, 1], [1, 2, 0], [1, 0, 2], [2, 0, 1], [2, 1, 0]
        ]

    def _get_rng(self, seed_offset=0): # ランダムの値を引数のシードに応じて出力する関数
        return np.random.default_rng(self.seed + seed_offset) # 再現性を持った乱数生成を行う。同じseedで同じランダムの値を返す。

    def decrypt_image(self, encrypted_image):
        """
        暗号化画像（NumPy配列: H, W, 3）に対してサブブロックEtC復号を適用し、復号画像を返す。
        """
        H, W, C = encrypted_image.shape # 画像の高さ(H)、幅(W)、チャネル数(C=3)

        # 16の倍数にクロップ (暗号化画像であれば通常すでに16の倍数)
        new_H = (H // 16) * 16
        new_W = (W // 16) * 16
        image = encrypted_image[:new_H, :new_W, :]
        H, W = new_H, new_W

        # 1. ブロック分割パラメータの計算 (16x16)
        num_blocks_h = H // 16 # 縦方向のブロック数
        num_blocks_w = W // 16 # 横方向のブロック数
        num_blocks = num_blocks_h * num_blocks_w # 全ブロック数

        # 2. 乱数生成器から暗号化時と全く同じ共通鍵と順列を生成
        rng = self._get_rng()
        perm = rng.permutation(num_blocks) # ブロックシャッフル順列
        shared_rot_keys = rng.integers(0, 4, size=4)
        shared_flip_keys = rng.integers(0, 4, size=4)
        shared_neg_keys = rng.integers(0, 2, size=4)
        shared_rgb_keys = rng.integers(0, 6, size=4)

        # 3. 暗号化画像をブロック分割 (16x16)
        # (num_blocks_h, 16, num_blocks_w, 16, 3) に変形
        blocks = image.reshape(num_blocks_h, 16, num_blocks_w, 16, 3)
        # (num_blocks_h, num_blocks_w, 16, 16, 3) に並び替え
        blocks = blocks.transpose(0, 2, 1, 3, 4)
        # (num_blocks, 16, 16, 3) に1次元のブロック列にまとめる
        blocks = blocks.reshape(num_blocks, 16, 16, 3)

        # 4. サブブロック分割 (8x8)
        # 16x16ブロックを4つの8x8サブブロックに分割する
        # (num_blocks, H_split(2), H_sub(8), W_split(2), W_sub(8), 3) に変形
        sub_blocks_view = blocks.reshape(num_blocks, 2, 8, 2, 8, 3)
        # (num_blocks, H_split, W_split, H_sub, W_sub, 3) に置換
        sub_blocks_view = sub_blocks_view.transpose(0, 1, 3, 2, 4, 5)
        # 4つのサブブロックとしてまとめる: (num_blocks, 4, 8, 8, 3)
        sub_blocks_view = sub_blocks_view.reshape(num_blocks, 4, 8, 8, 3)

        # 5. 各サブブロックの逆変換
        # 暗号化の順序 (回転 -> 反転 -> ネガポジ -> RGB) の逆順で復号を実行
        processed_sub_blocks = np.zeros_like(sub_blocks_view)

        for i in range(4):
            # サブブロック位置 i の全ブロック分を取り出す: shape (num_blocks, 8, 8, 3)
            sub_block_group = sub_blocks_view[:, i].copy()

            # 測光逆変換: RGB成分の入れ替えの逆変換
            p_idx = shared_rgb_keys[i]
            perm_order = self.rgb_perms[p_idx]
            inv_perm_order = np.argsort(perm_order)
            sub_block_group = sub_block_group[..., inv_perm_order]

            # 測光逆変換: ネガポジ反転 (255 - (255 - x) = x)
            if shared_neg_keys[i] == 1:
                sub_block_group = 255 - sub_block_group

            # 幾何逆変換: 反転 (反転の逆変換は同一の反転)
            f = shared_flip_keys[i]
            if f == 1: # 水平反転 (W方向 = axis 2)
                sub_block_group = np.flip(sub_block_group, axis=2)
            elif f == 2: # 垂直反転 (H方向 = axis 1)
                sub_block_group = np.flip(sub_block_group, axis=1)
            elif f == 3: # 水平・垂直両方の反転
                sub_block_group = np.flip(sub_block_group, axis=(1, 2))

            # 幾何逆変換: 回転 (反時計回りに k*90度 回転していたので、反時計回りに (4 - k)*90度 回転)
            k = shared_rot_keys[i]
            inv_k = (4 - k) % 4
            if inv_k > 0:
                sub_block_group = np.rot90(sub_block_group, inv_k, axes=(1, 2))

            # 復号後のサブブロックを格納
            processed_sub_blocks[:, i] = sub_block_group

        # 6. サブブロックを16x16ブロックの形に戻す
        # (num_blocks, 4, 8, 8, 3) -> (num_blocks, 2, 2, 8, 8, 3)
        restored = processed_sub_blocks.reshape(num_blocks, 2, 2, 8, 8, 3)
        # (num_blocks, H_split, H_sub, W_split, W_sub, 3) に戻す
        blocks_reconstructed = restored.transpose(0, 1, 3, 2, 4, 5)
        # 16x16のブロック (num_blocks, 16, 16, 3) に変形
        blocks_reconstructed = blocks_reconstructed.reshape(num_blocks, 16, 16, 3)

        # 7. ブロックシャッフルの逆変換 (元の位置へ再配置)
        unshuffled_blocks = np.empty_like(blocks_reconstructed)
        unshuffled_blocks[perm] = blocks_reconstructed

        # 8. 画像データに戻す
        # (num_blocks_h, num_blocks_w, 16, 16, 3) に変形
        final_blocks = unshuffled_blocks.reshape(num_blocks_h, num_blocks_w, 16, 16, 3)
        # (num_blocks_h, 16, num_blocks_w, 16, 3) に並び替え
        final_blocks = final_blocks.transpose(0, 2, 1, 3, 4)
        # (H, W, 3) の画像形式に変形
        decrypted_image = final_blocks.reshape(H, W, 3)

        return decrypted_image

    def process_image(self, input_path, output_path): # 画像を復号して保存する関数
        if not os.path.exists(input_path):
            print(f"Error: 暗号化画像が見つかりません: {input_path}")
            return False

        # OpenCVで画像読み込み (BGR形式)
        image = cv2.imread(input_path)
        if image is None:
            print(f"Error: 画像の読み込みに失敗しました: {input_path}")
            return False

        # 復号処理の実行
        decrypted_image = self.decrypt_image(image)

        # 出力先ディレクトリの作成
        output_dir = os.path.dirname(output_path)
        if output_dir and not os.path.exists(output_dir):
            os.makedirs(output_dir)

        # 画像ファイルの保存
        cv2.imwrite(output_path, decrypted_image)
        H, W = decrypted_image.shape[:2]
        print(f"復号が完了しました: {output_path} (解像度: {W}x{H})")
        return True


def main():
    """
    指定された暗号化画像を1枚読み込み、サブブロックEtC復号を実行するメイン関数
    例: uv run python3 EtC_sub_image_decryption.py -i encrypted.png -o decrypted.png -s 123
    """
    parser = argparse.ArgumentParser(description="サブブロックを導入したEtC画像復号スクリプト")
    parser.add_argument("input_pos", nargs="?", default=None, help="暗号化画像のパス (位置引数)")
    parser.add_argument("output_pos", nargs="?", default=None, help="復号画像の出力パス (位置引数)")
    parser.add_argument("-i", "--input", dest="input_opt", default=None, help="暗号化画像のパス")
    parser.add_argument("-o", "--output", dest="output_opt", default=None, help="復号画像の出力パス")
    parser.add_argument("-s", "--seed", type=int, default=None, help="復号シード値 (暗号化時と同じシード値)")

    args = parser.parse_args()

    # 位置引数またはオプション引数からパスを取得
    input_path = args.input_opt or args.input_pos
    output_path = args.output_opt or args.output_pos
    seed = args.seed

    # 入力パスが未指定の場合は対話的に入力
    if not input_path:
        input_path = input("復号する暗号化画像のパスを入力してください: ").strip()
        if not input_path:
            print("入力パスが指定されませんでした。終了します。")
            return

    # シード値の確認 (復号には必須)
    if seed is None:
        seed_input = input("暗号化時に使用したシード値を入力してください: ").strip()
        if not seed_input:
            print("シード値が指定されませんでした。復号にはシード値が必要です。終了します。")
            return
        try:
            seed = int(seed_input)
        except ValueError:
            print(f"無効なシード値です: {seed_input}。整数を指定してください。")
            return

    # 出力パスが未指定の場合は自動生成 (例: input_decrypted.png)
    if not output_path:
        base_name, ext = os.path.splitext(input_path)
        ext = ext if ext else ".png"
        if "_encrypted" in base_name:
            output_path = f"{base_name.replace('_encrypted', '_decrypted')}{ext}"
        else:
            output_path = f"{base_name}_decrypted{ext}"
        print(f"出力パスが未指定のため、次のように設定しました: {output_path}")

    print("=" * 50)
    print(" EtC サブブロック画像復号")
    print("=" * 50)
    print(f"暗号化画像: {input_path}")
    print(f"出力先    : {output_path}")
    print(f"シード値  : {seed}")

    # クラスのインスタンス化と復号の実行
    decryptor = ImageDecryptor(key_seed=seed)
    decryptor.process_image(input_path, output_path)

if __name__ == "__main__":
    main()
