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

    final l10n = L10n.of(context)!;

    return Container(
      width: size.width,
      constraints: BoxConstraints(
        minHeight: size.height,
      ),
      alignment: Alignment.topCenter,
      color: theme.scaffoldBackgroundColor,
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
                l10n.studyTitle,
                style: TextStyle(
                  fontSize: size.width < 600 ? 22 : 28,
                  fontWeight: FontWeight.bold,
                  height: 1.4,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                l10n.studySubtitle,
                style: TextStyle(
                  fontSize: 16,
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              Divider(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.15),
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
                  l10n.studyFig1Caption,
                  style: TextStyle(
                    fontSize: 13,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ),
              const SizedBox(height: 28),

              // 3. 本文1
              Text(
                l10n.studyBody1,
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
                  l10n.studyFig2Caption,
                  style: TextStyle(
                    fontSize: 13,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ),
              const SizedBox(height: 28),

              // 5. 本文2
              Text(
                l10n.studyBody2,
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
