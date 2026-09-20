import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myhomepage/utils/language_button.dart';

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
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 16),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const LanguageButton(),
            const SizedBox(width: 4),
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu, color: Colors.black),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
                iconSize: 28.0,
              ),
            ),
            const SizedBox(width: 12),
          ],
        ),
      ],
    );

    return SizedBox(
      width: size.width,
      height: 60,
      child: appbar,
    );
  }
}
