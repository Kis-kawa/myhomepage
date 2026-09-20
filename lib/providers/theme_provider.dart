import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// ダークモードを管理する
class ThemeModeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    return ThemeMode.system; //初期はブラウザに従う
  }

  /// ライトモードとダークモードをトグル切り替え
  void toggle(BuildContext context) {
    final isDark = state == ThemeMode.dark ||
        (state == ThemeMode.system &&
            MediaQuery.platformBrightnessOf(context) == Brightness.dark);
    state = isDark ? ThemeMode.light : ThemeMode.dark;
  }

  /// テーマモードを直接指定
  void setThemeMode(ThemeMode mode) {
    state = mode;
  }
}

/// ダークモードを提供するプロバイダー
final themeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(
  ThemeModeNotifier.new,
);
