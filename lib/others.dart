import 'package:flutter/material.dart';
import 'package:myhomepage/l10n/l10n.dart';
import 'package:myhomepage/widgets/custom_app_bar.dart';
import 'package:myhomepage/widgets/custom_drawer.dart';
import 'package:myhomepage/widgets/custom_min_app_bar.dart';
import 'package:myhomepage/widgets/decorated_page_title.dart';
import 'package:web/web.dart' as web;

class OthersContentSection extends StatelessWidget {
  const OthersContentSection({super.key});

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
              // 見出し
              Text(
                l10n.othersTitle,
                style: TextStyle(
                  fontSize: size.width < 600 ? 22 : 28,
                  fontWeight: FontWeight.bold,
                  height: 1.4,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 16),
              Divider(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.15),
                thickness: 1,
              ),
              const SizedBox(height: 32),

              // 本文
              Text(
                l10n.othersBody,
                style: TextStyle(
                  fontSize: 15,
                  height: 1.85,
                  letterSpacing: 0.3,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 48),

              // 連絡先
              Text(
                l10n.othersContactTitle,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () {
                  web.window.open('mailto:${l10n.renrakuMail}', '_self');
                },
                borderRadius: BorderRadius.circular(6),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                  child: Text(
                    "${l10n.emailLabel}: ${l10n.renrakuMail}",
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.85,
                      letterSpacing: 0.3,
                      color: theme.colorScheme.primary,
                      decoration: TextDecoration.underline,
                    ),
                  ),
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

class PcOthersLayout extends StatelessWidget {
  const PcOthersLayout({super.key});

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
                    child: DecoratedPageTitle(title: l10n.titleD),
                  ),
                ),
                const OthersContentSection(),
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

class PcMinOthersLayout extends StatelessWidget {
  const PcMinOthersLayout({super.key});

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
                    child: DecoratedPageTitle(title: l10n.titleD),
                  ),
                ),
                const OthersContentSection(),
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
