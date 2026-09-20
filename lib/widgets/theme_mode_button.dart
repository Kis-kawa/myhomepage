import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myhomepage/providers/theme_provider.dart';

class ThemeModeButton extends ConsumerWidget {
  const ThemeModeButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final isDark = themeMode == ThemeMode.dark ||
        (themeMode == ThemeMode.system &&
            MediaQuery.platformBrightnessOf(context) == Brightness.dark);

    return IconButton(
      tooltip: isDark ? 'ライトモードに切り替え' : 'ダークモードに切り替え',
      icon: Icon(
        isDark ? Icons.light_mode : Icons.dark_mode_outlined,
        color: isDark ? Colors.amber : Colors.black87,
        size: 22,
      ),
      onPressed: () {
        ref.read(themeModeProvider.notifier).toggle(context);
      },
    );
  }
}
