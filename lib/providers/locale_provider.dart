import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 表示言語を管理する
class LocaleNotifier extends Notifier<Locale?> {
  @override
  Locale? build() {
    return null; //はじめは端末設定に従う
  }

  void setLocale(String language) {
    if (language == 'jp' || language == 'en') {
      state = Locale(language);
    }
  }
}

// 言語状態を提供するプロバイダー
final localeProvider = NotifierProvider<LocaleNotifier, Locale?>(
  LocaleNotifier.new,
);
