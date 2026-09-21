import 'package:flutter/material.dart';
import 'package:myhomepage/l10n/l10n.dart';
import 'package:myhomepage/widgets/custom_app_bar.dart';
import 'package:myhomepage/widgets/custom_drawer.dart';
import 'package:myhomepage/widgets/custom_min_app_bar.dart';
import 'package:myhomepage/widgets/decorated_page_title.dart';
import 'package:myhomepage/widgets/work_card.dart';

List<WorkItem> getWorks(L10n l10n) => [
  WorkItem(
    title: l10n.workRabbitTitle,
    imageAsset: "assets/images/works_thumbnail_01.webp",
    description: l10n.workRabbitDesc,
    techStack: const ["Unity", "C#", "Blender"],
    externalUrl: "https://kis-kawa.github.io/myhomepage/unity/",
    isComingSoon: false,
  ),
  WorkItem(
    title: l10n.workTimerTitle,
    imageAsset: "assets/images/works_thumbnail_02.webp",
    description: l10n.workTimerDesc,
    techStack: const ["Flutter", "Dart", "Riverpod", "GoRouter"],
    githubUrl: "https://github.com/Kis-kawa/future-workshop",
    externalUrl: "https://kis-kawa.github.io/myhomepage/judo-timer/",
    isComingSoon: false,
  ),
  WorkItem(
    title: l10n.workEtcTitle,
    imageAsset: "assets/images/works_thumbnail_03.webp",
    description: l10n.workEtcDesc,
    techStack: const ["JavaScript", "Canvas API", "Python"],
    externalUrl: "https://kis-kawa.github.io/myhomepage/etc/",
    isComingSoon: false,
  ),
];

class WorksGridSection extends StatelessWidget {
  const WorksGridSection({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final l10n = L10n.of(context)!;
    final works = getWorks(l10n);

    return Container(
      width: size.width,
      constraints: BoxConstraints(
        minHeight: size.height,
      ),
      alignment: Alignment.topCenter,
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
                itemCount: works.length,
                itemBuilder: (context, index) {
                  return WorkCard(item: works[index]);
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
