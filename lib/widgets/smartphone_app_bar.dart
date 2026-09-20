import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:myhomepage/utils/language_button.dart';
import 'package:myhomepage/widgets/theme_mode_button.dart';

class SmartphoneAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SmartphoneAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final appbar = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: InkWell(
            onTap: () {
              final currentPath = GoRouterState.of(context).uri.path;
              if (currentPath == '/home') return;
              context.push('/home');
            },
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 18,
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
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const LanguageButton(),
            const SizedBox(width: 2),
            const ThemeModeButton(),
            const SizedBox(width: 2),
            Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.menu, color: Theme.of(context).colorScheme.onSurface),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
                iconSize: 28.0,
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
      ],
    );

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      width: size.width,
      height: 60,
      child: appbar,
    );
  }
}
