import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:myhomepage/home.dart';
import 'package:myhomepage/news.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:myhomepage/l10n/l10n.dart';


/// 汎用的なレスポンシブレイアウトウィジェット
class ResponsiveLayout<T extends Widget, Bool> extends StatelessWidget {
  final T Function() pcLayout;
  final T Function() pcMinLayout;
  final T Function() smartphoneLayout;
  final bool deviceType;

  const ResponsiveLayout({
    super.key,
    required this.pcLayout,
    required this.pcMinLayout,
    required this.smartphoneLayout,
    required this.deviceType,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (deviceType == true){
          return smartphoneLayout();
        }else {
          if (constraints.maxWidth < 1000) {
          return pcMinLayout();
          } else {
            return pcLayout();
          }
        }
      },
    );
  }
}


void main() {
  setUrlStrategy(PathUrlStrategy()); //パスの/#/をなくす

  //スマホか確認
  bool isMobile = html.window.navigator.userAgent.toLowerCase().contains('iphone') || (html.window.navigator.userAgent.toLowerCase().contains('android') && html.window.navigator.userAgent.toLowerCase().contains('mobile'));

  final router = GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(
        path: '/home',
        builder: (context, state) => ResponsiveLayout(
          pcLayout: PcHomeLayout.new,
          pcMinLayout: PcMinHomeLayout.new,
          smartphoneLayout: SmartphoneNewsLayout.new,
          deviceType: isMobile,
        ),
      ),
      GoRoute(
        path: '/news',
        builder: (context, state) => ResponsiveLayout(
          pcLayout: PcNewsLayout.new,
          pcMinLayout: PcMinNewsLayout.new,
          smartphoneLayout: SmartphoneNewsLayout.new,
          deviceType: isMobile,
        ),
      ),
    ],
  );

  runApp(MaterialApp.router(
    routeInformationParser: router.routeInformationParser,
    routerDelegate: router.routerDelegate,
    routeInformationProvider: router.routeInformationProvider,
    localizationsDelegates: L10n.localizationsDelegates,
    supportedLocales: L10n.supportedLocales,
    localeResolutionCallback: (locale, supportedLocales) {
        if (locale != null) {
          final _locale = Locale(locale.languageCode);
          if (supportedLocales.contains(_locale)) {
            return _locale;
          }
        }
        return supportedLocales.first;
    },
    theme: ThemeData(
      primarySwatch: Colors.indigo, // デフォルトのメインカラー
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.indigo,
          ).copyWith(
            secondary: Colors.amber, // アクセントカラー（ボタン・FABなど）
          ),
      fontFamily: 'Noto_Sans_JP',
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          fontSize: 18.0,
          color: Colors.black87,
          fontWeight: FontWeight.bold,
        ),
        bodyMedium: TextStyle(
          fontSize: 16.0,
          color: Colors.black87,
          fontWeight: FontWeight.w600,
        ),
        bodySmall: TextStyle(
          fontSize: 14.0,
          color: Colors.black54,
        ),
      ),
    ),
  ));
}
