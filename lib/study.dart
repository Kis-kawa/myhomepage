import 'package:flutter/material.dart';
import 'package:myhomepage/widgets/custom_app_bar.dart';
import 'package:myhomepage/widgets/custom_min_app_bar.dart';

class PcStudyLayout extends StatelessWidget {
  const PcStudyLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          CustomAppBar(),
          Expanded(
            child: Center(
              child: Text("Study"),
            ),
          ),
        ],
      ),
    );
  }
}

class PcMinStudyLayout extends StatelessWidget {
  const PcMinStudyLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const Drawer(),
      body: const Column(
        children: [
          CustomMinAppBar(),
          Expanded(
            child: Center(
              child: Text("Study"),
            ),
          ),
        ],
      ),
    );
  }
}
