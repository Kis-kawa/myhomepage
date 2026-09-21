import 'package:flutter/material.dart';
import 'package:myhomepage/l10n/l10n.dart';
import 'package:myhomepage/widgets/custom_app_bar.dart';
import 'package:myhomepage/widgets/custom_drawer.dart';
import 'package:myhomepage/widgets/custom_min_app_bar.dart';
import 'package:myhomepage/widgets/decorated_page_title.dart';
import 'package:myhomepage/widgets/work_card.dart';

final List<WorkItem> sampleWorks = [
  const WorkItem(
    title: "うさぎと狩犬",
    imageAsset: "assets/images/works_thumbnail_01.webp",
    description: "UnityとC#を用いて開発したボードゲーム。初めてのunity作品。有名なボードゲームである「うさぎと狩犬」の作成を通して、基礎的なゲーム制作を学んだ。",
    techStack: ["Unity", "C#", "Blender"],
    externalUrl: "https://kis-kawa.github.io/myhomepage/unity/",
    isComingSoon: false,
  ),
  const WorkItem(
    title: "柔道用タイマー",
    imageAsset: "assets/images/works_thumbnail_02.webp",
    description: "柔道の練習・試合用のタイマーアプリ。有効は未対応。乱取りには使えます。",
    techStack: ["Flutter", "Dart", "Riverpod", "GoRouter"],
    githubUrl: "https://github.com/Kis-kawa/future-workshop",
    isComingSoon: false,
  ),
  const WorkItem(
    title: "画像用EtC（暗号化し圧縮する）システム",
    imageAsset: "assets/images/works_thumbnail_03.webp",
    description: "JPEG画像に対する基本的なEtCシステムを体験できる。",
    techStack: ["Python", "OpenCV", "NumPy","FFmpeg"],
    // githubUrl: "https://github.com/Kis-kawa",
    isComingSoon: true,
  ),
];

class WorksGridSection extends StatelessWidget {
  const WorksGridSection({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      color: Theme.of(context).colorScheme.surfaceContainer,
      padding: EdgeInsets.symmetric(
        vertical: 40,
        horizontal: size.width < 600 ? 16 : 32,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: LayoutBuilder(
            builder: (context, constraints) {
              // カード1枚の最小幅（300px未満には縮まない）
              const double minCardWidth = 300;
              const double spacing = 24;

              // スペーシングを含めて最小幅を満たせる列数を計算
              final int crossAxisCount =
                  ((constraints.maxWidth + spacing) / (minCardWidth + spacing))
                      .floor()
                      .clamp(1, 4);

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: spacing,
                  mainAxisSpacing: spacing,
                  childAspectRatio: 16 / 9,
                ),
                itemCount: sampleWorks.length,
                itemBuilder: (context, index) {
                  return WorkCard(item: sampleWorks[index]);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class PcWorksLayout extends StatelessWidget {
  const PcWorksLayout({super.key});

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
                    child: DecoratedPageTitle(title: l10n.titleC),
                  ),
                ),
                const WorksGridSection(),
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

class PcMinWorksLayout extends StatelessWidget {
  const PcMinWorksLayout({super.key});

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
                    child: DecoratedPageTitle(title: l10n.titleC),
                  ),
                ),
                const WorksGridSection(),
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
