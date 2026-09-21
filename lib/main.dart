import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:myhomepage/home.dart';
import 'package:myhomepage/news.dart';
import 'package:myhomepage/study.dart';
import 'package:myhomepage/works.dart';
import 'package:myhomepage/others.dart';
// ignore: avoid_web_libraries_in_flutter
import 'package:web/web.dart' as web;
import 'package:myhomepage/l10n/l10n.dart';
import 'package:myhomepage/providers/locale_provider.dart';
import 'package:myhomepage/providers/theme_provider.dart';


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
  web.document.title = "HP | Kyohei Kishikawa";

  //スマホか確認
  bool isMobile = web.window.navigator.userAgent.toLowerCase().contains('iphone') || (web.window.navigator.userAgent.toLowerCase().contains('android') && web.window.navigator.userAgent.toLowerCase().contains('mobile'));

  final router = GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(
        path: '/home',
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: ResponsiveLayout(
            pcLayout: PcHomeLayout.new,
            pcMinLayout: PcMinHomeLayout.new,
            smartphoneLayout: PcMinHomeLayout.new,
            deviceType: isMobile,
          ),
        ),
      ),
      GoRoute(
        path: '/news',
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: ResponsiveLayout(
            pcLayout: PcNewsLayout.new,
            pcMinLayout: PcMinNewsLayout.new,
            smartphoneLayout: SmartphoneNewsLayout.new,
            deviceType: isMobile,
          ),
        ),
      ),
      GoRoute(
        path: '/study',
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: ResponsiveLayout(
            pcLayout: PcStudyLayout.new,
            pcMinLayout: PcMinStudyLayout.new,
            smartphoneLayout: PcMinStudyLayout.new,
            deviceType: isMobile,
          ),
        ),
      ),
      GoRoute(
        path: '/works',
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: ResponsiveLayout(
            pcLayout: PcWorksLayout.new,
            pcMinLayout: PcMinWorksLayout.new,
            smartphoneLayout: PcMinWorksLayout.new,
            deviceType: isMobile,
          ),
        ),
      ),
      GoRoute(
        path: '/others',
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: ResponsiveLayout(
            pcLayout: PcOthersLayout.new,
            pcMinLayout: PcMinOthersLayout.new,
            smartphoneLayout: PcMinOthersLayout.new,
            deviceType: isMobile,
          ),
        ),
      ),
    ],
  );


  runApp(
    ProviderScope(
      child: Consumer(
        builder: (context, ref, child) {
          final locale = ref.watch(localeProvider);
          final themeMode = ref.watch(themeModeProvider);

          return MaterialApp.router(
            title: "HP | Kyohei Kishikawa",
            locale: locale,
            themeMode: themeMode,
            routeInformationParser: router.routeInformationParser,
            routerDelegate: router.routerDelegate,
            routeInformationProvider: router.routeInformationProvider,
            localizationsDelegates: L10n.localizationsDelegates,
            supportedLocales: L10n.supportedLocales,
            localeResolutionCallback: (locale, supportedLocales) {
                if (locale != null) {
                  final currentLocale = Locale(locale.languageCode);
                  if (supportedLocales.contains(currentLocale)) {
                    return currentLocale;
                  }
                }
                return supportedLocales.first;
            },
            theme: ThemeData(
              brightness: Brightness.light,
              scaffoldBackgroundColor: Colors.white,
              primarySwatch: Colors.indigo,
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.indigo,
                brightness: Brightness.light,
              ).copyWith(
                secondary: Colors.amber,
                surface: Colors.white,
                surfaceContainer: const Color(0xFFE2E8F0),
                onSurface: Colors.black87,
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
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              scaffoldBackgroundColor: const Color(0xFF121212),
              primarySwatch: Colors.indigo,
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.indigo,
                brightness: Brightness.dark,
              ).copyWith(
                primary: const Color(0xFF82B1FF),
                secondary: Colors.amber,
                surface: const Color(0xFF1E1E1E),
                surfaceContainer: const Color(0xFF22272E),
                onSurface: Colors.white,
              ),
              fontFamily: 'Noto_Sans_JP',
              textTheme: const TextTheme(
                bodyLarge: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                bodyMedium: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
                bodySmall: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white70,
                ),
              ),
            ),
          );
        },
      ),
    ),
  );
}
