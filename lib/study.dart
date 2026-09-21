import 'package:flutter/material.dart';
import 'package:myhomepage/l10n/l10n.dart';
import 'package:myhomepage/widgets/custom_app_bar.dart';
import 'package:myhomepage/widgets/custom_drawer.dart';
import 'package:myhomepage/widgets/custom_min_app_bar.dart';
import 'package:myhomepage/widgets/decorated_page_title.dart';

class StudyContentSection extends StatelessWidget {
  const StudyContentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return Container(
      width: size.width,
      constraints: BoxConstraints(
        minHeight: size.height,
      ),
      color: theme.scaffoldBackgroundColor, // 白背景（ダークモード時はダーク背景）
      padding: EdgeInsets.symmetric(
        vertical: 48,
        horizontal: size.width < 600 ? 20 : 40,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 840),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. 見出し
              Text(
                "圧縮可能な動画暗号化を用いたVision Transformerによる行動認識",
                style: TextStyle(
                  fontSize: size.width < 600 ? 22 : 28,
                  fontWeight: FontWeight.bold,
                  height: 1.4,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "H.264/AVC動画圧縮とVision Transformerに対応した暗号化してから圧縮する（Encryption-then-Compression,EtC）システムの提案",
                style: TextStyle(
                  fontSize: 16,
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              Divider(
                color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
                thickness: 1,
              ),
              const SizedBox(height: 32),

              // 2. 画像1
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    "assets/images/study_etc_01.webp",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  "図1: 提案するEtCシステムの全体構成",
                  style: TextStyle(
                    fontSize: 13,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ),
              const SizedBox(height: 28),

              // 3. 本文1
              Text(
                "近年、クラウドコンピューティングと機械学習の普及に伴い、動画を対象としたコンピュータビジョンや行動認識サービスがクラウド上で提供される機会が急速に増加しています。しかし、分析対象の映像データをクラウドサーバへ送信する際、悪意ある第三者による通信の傍受やサーバからのデータ漏洩、さらには学習済みモデルの出力から元映像や個人情報が再構築されるプライバシー侵害のリスクが存在します。\n\n動画データは静止画に比べてファイルサイズが極めて大きいため、クラウドのストレージ費用や通信コストの削減、通信帯域の制約の観点からH.264などの圧縮規格によるデータ圧縮が不可欠です。しかし、AESやRSAなどの標準的な暗号化方式では、非可逆圧縮によって生じるわずかな誤差が暗号の拡散性によって全体に致命的な誤りとして波及するため、暗号化後に圧縮を行う「Encryption-then-Compression（EtC）」が原理的に困難でした。\n\nそこで本研究では、静止画向けに提案されていたブロックベースのEtC技術を発展させ、動画圧縮規格であるH.264/AVCに適応し、かつVision Transformer（ViT）による高精度な行動認識を可能とする動画EtCシステムを提案しました。クライアント側でのみ秘密鍵を管理し、暗号化された動画データと暗号化ViTモデルをクラウドへ送信することで、クラウド側は復号鍵を持たない（元映像を一切復元できない）安全な状態のまま、クラウド上で高精度に行動認識を実行できます。",
                style: TextStyle(
                  fontSize: 15,
                  height: 1.85,
                  letterSpacing: 0.3,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 48),

              // 4. 画像2
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    "assets/images/study_etc_02.webp",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  "図2: 提案する動画EtC暗号化処理のフロー",
                  style: TextStyle(
                    fontSize: 13,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ),
              const SizedBox(height: 28),

              // 5. 本文2
              Text(
                "従来の動画暗号化手法（LCVE等）はピクセルをシャッフルするため、H.264の空間的・時間的な相関構造を破壊し、圧縮効率が著しく低下するという課題がありました。本提案手法では、H.264の予測符号化とViTモデルの入力単位（チューブレット）の双方に配慮した多段階のキューブベース暗号化を設計しました。\n\n具体的には、まず動画をH.264のマクロブロックサイズ（16×16）とViTのチューブレット時間長（t=2）に合わせた六面体（キューブ: 16×16×2）に分割し、さらに8×8×2のサブキューブに細分化します。局所的な空間相関を維持してフレーム内予測の破綻を防ぐため、シャッフルや幾何変換（回転・反転）はキューブ単位で適用します。一方、各画素の視覚的情報を秘匿するためのネガポジ変換やRGBチャネルの入れ替えはサブキューブ単位で行い、各チャネルの統計的性質を保持することで圧縮効率への悪影響を最小限に抑えています。\n\nさらに、H.264のフレーム間予測（Pフレーム・Bフレーム）がキューブ境界をまたいで失敗することを防ぐため、GoP（Group of Pictures）のIフレーム配置間隔をキューブ長に合わせて偶数間隔（GoP=2）に最適化しました。実験の結果、暗号化を施していない元動画でのTop-1分類精度（87.66%）に対し、提案手法で暗号化した動画とモデルによる推論でも87.66%という完全に一致した分類精度を達成しました。また、H.264圧縮下においても実測0.5bpp前後の実用的な低ビットレート領域で高い分類精度を維持できることを確認し、プライバシー保護・高圧縮率・高精度認識の3つの両立を実証しました。",
                style: TextStyle(
                  fontSize: 15,
                  height: 1.85,
                  letterSpacing: 0.3,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}

class PcStudyLayout extends StatelessWidget {
  const PcStudyLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final l10n = L10n.of(context)!;

    final stack = Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: SizedBox(
            height: 270,
            child: Image.asset(
              "assets/images/home_background_01.webp",
              fit: BoxFit.cover,
            ),
          ),
        ),
        SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: size.width,
                  height: 270,
                  color: Colors.transparent,
                  child: Center(
                    child: DecoratedPageTitle(title: l10n.titleB),
                  ),
                ),
                const StudyContentSection(),
              ],
            ),
          ),
        ),
      ],
    );

    final body = Column(
      children: [
        const CustomAppBar(),
        Expanded(child: stack),
      ],
    );

    return Scaffold(
      body: body,
    );
  }
}

class PcMinStudyLayout extends StatelessWidget {
  const PcMinStudyLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final l10n = L10n.of(context)!;
    final double headerHeight = -0.36 * size.width + 630;

    final stack = Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: SizedBox(
            height: headerHeight,
            child: Image.asset(
              "assets/images/home_background_01.webp",
              fit: BoxFit.cover,
            ),
          ),
        ),
        SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: size.width,
                  height: headerHeight,
                  color: Colors.transparent,
                  child: Center(
                    child: DecoratedPageTitle(title: l10n.titleB),
                  ),
                ),
                const StudyContentSection(),
              ],
            ),
          ),
        ),
      ],
    );

    final body = Column(
      children: [
        const CustomMinAppBar(),
        Expanded(child: stack),
      ],
    );

    return Scaffold(
      endDrawer: const CustomDrawer(),
      body: body,
    );
  }
}
