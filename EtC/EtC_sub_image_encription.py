# 画像をサブブロックを導入したEtCで変換する。

import cv2
import numpy as np
import os
import secrets
import argparse

class ImageEncryptor: # 画像の暗号化
    def __init__(self, key_seed=None): # イニシャライズ
        self.seed = key_seed if key_seed is not None else secrets.randbits(32) # シードを引数で与えられたものにする。ないなら、32bit（約43億）でランダムで作る。
        self.rng = None # ランダム値生成器

        # RGBの順列: 0:RGB, 1:RBG, 2:GBR, 3:GRB, 4:BRG, 5:BGR
        self.rgb_perms = [
            [0, 1, 2], [0, 2, 1], [1, 2, 0], [1, 0, 2], [2, 0, 1], [2, 1, 0]
        ]

    def _get_rng(self, seed_offset=0): # ランダムの値を引数のシードに応じて出力する関数
        return np.random.default_rng(self.seed + seed_offset) # 再現性を持った乱数生成を行う。同じseedで同じランダムの値を返す。

    def encrypt_image(self, image):
        """
        画像（NumPy配列: H, W, 3）に対してサブブロックEtC暗号化を適用し、暗号化画像を返す。
        """
        H, W, C = image.shape # 画像の高さ(H)、幅(W)、チャネル数(C=3)

        # 16の倍数にクロップ (余りを切り捨て)
        new_H = (H // 16) * 16 # 切り捨て、最大の16の倍数にする
        new_W = (W // 16) * 16 # 切り捨て、最大の16の倍数にする
        image = image[:new_H, :new_W, :]
        H, W = new_H, new_W

        # 1. ブロック分割 (16x16)
        num_blocks_h = H // 16 # 縦方向のブロック数
        num_blocks_w = W // 16 # 横方向のブロック数
        num_blocks = num_blocks_h * num_blocks_w # 全ブロック数

        # (num_blocks_h, 16, num_blocks_w, 16, 3) に変形
        blocks = image.reshape(num_blocks_h, 16, num_blocks_w, 16, 3)
        # (num_blocks_h, num_blocks_w, 16, 16, 3) に並び替え
        blocks = blocks.transpose(0, 2, 1, 3, 4)
        # (num_blocks, 16, 16, 3) に1次元のブロック列にまとめる
        blocks = blocks.reshape(num_blocks, 16, 16, 3)

        rng = self._get_rng() # 乱数ジェネレータを取得

        # 2. ブロックシャッフル
        perm = rng.permutation(num_blocks) # ランダムな順列を作成
        blocks = blocks[perm]              # 順列に従ってブロックをシャッフル

        # 3. サブブロック分割 (8x8)
        # 16x16ブロックを4つの8x8サブブロックに分割する
        # (num_blocks, H_split(2), H_sub(8), W_split(2), W_sub(8), 3) に変形
        sub_blocks_view = blocks.reshape(num_blocks, 2, 8, 2, 8, 3)
        # (num_blocks, H_split, W_split, H_sub, W_sub, 3) に置換
        sub_blocks_view = sub_blocks_view.transpose(0, 1, 3, 2, 4, 5)
        # 4つのサブブロックとしてまとめる: (num_blocks, 4, 8, 8, 3)
        sub_blocks_view = sub_blocks_view.reshape(num_blocks, 4, 8, 8, 3)

        # 4. rngからそれぞれの暗号化で使う共通鍵を生成
        # サブブロックの位置4つ（左上、右上、左下、右下）に対応してそれぞれ生成
        # 回転: 0..3 (0°, 90°, 180°, 270°), 反転: 0..3, ネガポジ: 0..1, RGB: 0..5
        shared_rot_keys = rng.integers(0, 4, size=4)
        shared_flip_keys = rng.integers(0, 4, size=4)
        shared_neg_keys = rng.integers(0, 2, size=4)
        shared_rgb_keys = rng.integers(0, 6, size=4)

        # 5. 回転・反転・ネガポジ・RGB入れ替え
        processed_sub_blocks = np.zeros_like(sub_blocks_view)

        for i in range(4):
            # サブブロック位置 i の全ブロック分を取り出す: shape (num_blocks, 8, 8, 3)
            sub_block_group = sub_blocks_view[:, i].copy()

            # 幾何変換: 回転 (H: axis 1, W: axis 2)
            k = shared_rot_keys[i]
            if k > 0:
                sub_block_group = np.rot90(sub_block_group, k, axes=(1, 2))

            # 幾何変換: 反転
            f = shared_flip_keys[i]
            if f == 1: # 水平反転 (W方向 = axis 2)
                sub_block_group = np.flip(sub_block_group, axis=2)
            elif f == 2: # 垂直反転 (H方向 = axis 1)
                sub_block_group = np.flip(sub_block_group, axis=1)
            elif f == 3: # 水平・垂直両方の反転
                sub_block_group = np.flip(sub_block_group, axis=(1, 2))

            # 測光変換: ネガポジ反転
            if shared_neg_keys[i] == 1:
                sub_block_group = 255 - sub_block_group

            # 測光変換: RGB成分の入れ替え
            p_idx = shared_rgb_keys[i]
            perm_order = self.rgb_perms[p_idx]
            sub_block_group = sub_block_group[..., perm_order]

            # 処理後のサブブロックを格納
            processed_sub_blocks[:, i] = sub_block_group

        # 6. サブブロックを16x16ブロックの形に戻す
        # (num_blocks, 4, 8, 8, 3) -> (num_blocks, 2, 2, 8, 8, 3)
        restored = processed_sub_blocks.reshape(num_blocks, 2, 2, 8, 8, 3)
        # (num_blocks, H_split, H_sub, W_split, W_sub, 3) に戻す
        blocks_reconstructed = restored.transpose(0, 1, 3, 2, 4, 5)
        # 16x16のブロック (num_blocks, 16, 16, 3) に変形
        blocks_reconstructed = blocks_reconstructed.reshape(num_blocks, 16, 16, 3)

        # 7. 画像データに戻す
        # (num_blocks_h, num_blocks_w, 16, 16, 3) に変形
        final_blocks = blocks_reconstructed.reshape(num_blocks_h, num_blocks_w, 16, 16, 3)
        # (num_blocks_h, 16, num_blocks_w, 16, 3) に並び替え
        final_blocks = final_blocks.transpose(0, 2, 1, 3, 4)
        # (H, W, 3) の画像形式に変形
        final_image = final_blocks.reshape(H, W, 3)

        return final_image

    def process_image(self, input_path, output_path): # 画像を暗号化して保存する関数
        if not os.path.exists(input_path):
            print(f"Error: 入力画像が見つかりません: {input_path}")
            return False

        # OpenCVで画像読み込み (BGR形式)
        image = cv2.imread(input_path)
        if image is None:
            print(f"Error: 画像の読み込みに失敗しました: {input_path}")
            return False

        # 暗号化処理の実行
        encrypted_image = self.encrypt_image(image)

        # 出力先ディレクトリの作成
        output_dir = os.path.dirname(output_path)
        if output_dir and not os.path.exists(output_dir):
            os.makedirs(output_dir)

        # 画像ファイルの保存
        cv2.imwrite(output_path, encrypted_image)
        H, W = encrypted_image.shape[:2]
        print(f"暗号化が完了しました: {output_path} (解像度: {W}x{H})")
        return True




def main():
    """
    指定された画像を1枚読み込み、サブブロックEtC暗号化を実行するメイン関数
    例: uv run python3 EtC_sub_image_encription.py -i input.png -o encrypted.png -s 123
    """
    parser = argparse.ArgumentParser(description="サブブロックを導入したEtC画像暗号化スクリプト")
    parser.add_argument("input_pos", nargs="?", default=None, help="入力画像のパス (位置引数)")
    parser.add_argument("output_pos", nargs="?", default=None, help="暗号化画像の出力パス (位置引数)")
    parser.add_argument("-i", "--input", dest="input_opt", default=None, help="入力画像のパス")
    parser.add_argument("-o", "--output", dest="output_opt", default=None, help="暗号化画像の出力パス")
    parser.add_argument("-s", "--seed", type=int, default=None, help="暗号化シード値 (指定しない場合はランダム)")

    args = parser.parse_args()

    # 位置引数またはオプション引数からパスを取得
    input_path = args.input_opt or args.input_pos
    output_path = args.output_opt or args.output_pos

    # 入力パスが未指定の場合は対話的に入力
    if not input_path:
        input_path = input("暗号化する入力画像のパスを入力してください: ").strip()
        if not input_path:
            print("入力パスが指定されませんでした。終了します。")
            return

    # 出力パスが未指定の場合は自動生成 (例: input_encrypted.png)
    if not output_path:
        base_name, ext = os.path.splitext(input_path)
        ext = ext if ext else ".png"
        output_path = f"{base_name}_encrypted{ext}"
        print(f"出力パスが未指定のため、次のように設定しました: {output_path}")

    print("=" * 50)
    print(" EtC サブブロック画像暗号化")
    print("=" * 50)
    print(f"入力画像: {input_path}")
    print(f"出力先  : {output_path}")
    if args.seed is not None:
        print(f"シード値: {args.seed}")
    else:
        print("シード値: ランダム (自動生成)")

    # クラスのインスタンス化と暗号化の実行
    encryptor = ImageEncryptor(key_seed=args.seed)
    print(f"適用シード: {encryptor.seed}")
    encryptor.process_image(input_path, output_path)

if __name__ == "__main__":
    main()
