import 'package:flutter/material.dart';
import 'package:myhomepage/widgets/custom_app_bar.dart';
import 'package:myhomepage/widgets/custom_drawer.dart';
import 'package:myhomepage/widgets/custom_min_app_bar.dart';

class PcWorksLayout extends StatelessWidget {
  const PcWorksLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          CustomAppBar(),
          Expanded(
            child: Center(
              child: Text("Works"),
            ),
          ),
        ],
      ),
    );
  }
}

class PcMinWorksLayout extends StatelessWidget {
  const PcMinWorksLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const CustomDrawer(),
      body: const Column(
        children: [
          CustomMinAppBar(),
          Expanded(
            child: Center(
              child: Text("Works"),
            ),
          ),
        ],
      ),
    );
  }
}
