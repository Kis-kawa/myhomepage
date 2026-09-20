import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myhomepage/l10n/l10n.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myhomepage/utils/language_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(70.0);

  /// ナビゲーションメニューのボタン
  Widget navItem(BuildContext context, String title, String path) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: GestureDetector(
        onTap: () {
          final currentPath = GoRouterState.of(context).uri.path;
          if (currentPath == path) return;
          context.push(path);
        },
        child: Text(title, style: const TextStyle(fontSize: 20)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final l10n = L10n.of(context)!;

    final appbar = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(width: size.width * 0.14),
        CircleAvatar(
          radius: 20,
          backgroundColor: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: SvgPicture.asset(
              'assets/images/common_icon_01.svg',
              fit: BoxFit.contain,
            ),
          ),
        ),
        const SizedBox(width: 8),
        const Text(
          "Kishi",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: size.width * 0.06),
        navItem(context, l10n.titleA, "/home"),
        const SizedBox(width: 8),
        navItem(context, l10n.titleB, "/study"),
        const SizedBox(width: 8),
        navItem(context, l10n.titleC, "/works"),
        const SizedBox(width: 8),
        navItem(context, l10n.titleD, "/others"),
        const Spacer(),
        const LanguageButton(),
        const SizedBox(width: 120),
      ],
    );

    return SizedBox(
      width: size.width,
      height: 70,
      child: appbar,
    );
  }
}
