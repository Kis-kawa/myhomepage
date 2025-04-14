import 'package:flutter/material.dart';


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

class PcMinNewsLayout extends StatelessWidget {
  const PcMinNewsLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Pc min News")),
    );
  }
}
