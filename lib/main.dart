import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

/// 汎用的なレスポンシブレイアウトウィジェット
class ResponsiveLayout<T extends Widget> extends StatelessWidget {
  final T Function() pcLayout;
  final T Function() smartphoneLayout;

  const ResponsiveLayout({
    super.key,
    required this.pcLayout,
    required this.smartphoneLayout,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < 600) {
          return smartphoneLayout();
        } else {
          return pcLayout();
        }
      },
    );
  }
}


class PcHomeLayout extends StatelessWidget {
  const PcHomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("PC Home")),
    );
  }
}

class SmartphoneHomeLayout extends StatelessWidget {
  const SmartphoneHomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Smartphone Home")),
    );
  }
}

class PcNewsLayout extends StatelessWidget {
  const PcNewsLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("PC News")),
    );
  }
}

class SmartphoneNewsLayout extends StatelessWidget {
  const SmartphoneNewsLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Smartphone News")),
    );
  }
}


void main() {
  setUrlStrategy(PathUrlStrategy());

  final router = GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(
        path: '/home',
        builder: (context, state) => const ResponsiveLayout(
          pcLayout: PcHomeLayout.new,
          smartphoneLayout: SmartphoneHomeLayout.new,
        ),
      ),
      GoRoute(
        path: '/news',
        builder: (context, state) => const ResponsiveLayout(
          pcLayout: PcNewsLayout.new,
          smartphoneLayout: SmartphoneNewsLayout.new,
        ),
      ),
    ],
  );

  runApp(MaterialApp.router(
    routeInformationParser: router.routeInformationParser,
    routerDelegate: router.routerDelegate,
    routeInformationProvider: router.routeInformationProvider,
  ));
}
