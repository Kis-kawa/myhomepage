import 'package:flutter/material.dart';
import 'package:myhomepage/l10n/l10n.dart';
import 'package:myhomepage/widgets/custom_app_bar.dart';
import 'package:myhomepage/widgets/custom_drawer.dart';
import 'package:myhomepage/widgets/custom_min_app_bar.dart';
import 'package:myhomepage/widgets/decorated_page_title.dart';
import 'package:myhomepage/widgets/profile_section.dart';
import 'package:myhomepage/widgets/side_info_section.dart';




class PcHomeLayout extends StatelessWidget {
  const PcHomeLayout({super.key});


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final l10n = L10n.of(context)!;


    final stack = Stack(children:[
      Positioned(
        top: 0, // 画面上部に配置
        left: 0,
        right: 0,
        child: SizedBox(
          height: 270, // 高さを抑える
          child: Image.asset(
            "assets/images/home_background_01.webp",
            fit: BoxFit.cover, // 横幅いっぱいに拡大
          ),
        ),
      ),
      SingleChildScrollView(
        child: Center(child:Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        // Container(width: size.width ,height: 270,color: Colors.transparent,child: Center(child: Text("プロフィール"),),),
        Container(
          width: size.width,
          height: 270,
          color: Colors.transparent,
          child: Center(
            child: DecoratedPageTitle(title: l10n.titleA),
          ),
        ),
        Container(
          width: size.width,
          color: Theme.of(context).colorScheme.surfaceContainer,
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(width: 1),
              const SizedBox(width: 1),
              const SizedBox(width: 1),
              ProfileSection(width: size.width * 0.5),
              SideInfoSection(width: (size.width * 0.22).clamp(220.0, 320.0)),
              const SizedBox(width: 1),
              const SizedBox(width: 1),
              const SizedBox(width: 1),
            ],
          ),
        )])),
      )
    ]);

    final body = Column(children: [
      CustomAppBar(),
      Expanded(child: stack,)
    ],);

    return Scaffold(
      body: body,
      // appBar: CustomAppBar(),
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






class PcMinHomeLayout extends StatelessWidget {
  const PcMinHomeLayout({super.key});


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final l10n = L10n.of(context)!;


    final stack = Stack(children:[
      Positioned(
        top: 0, // 画面上部に配置
        left: 0,
        right: 0,
        child: SizedBox(
          height: -0.36*size.width+630 , // 高さを抑える
          child: Image.asset(
            "assets/images/home_background_01.webp",
            fit: BoxFit.cover, // 横幅いっぱいに拡大
          ),
        ),
      ),
      SingleChildScrollView(
        child: Center(child:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: size.width,
              height: -0.36 * size.width + 630,
              color: Colors.transparent,
              child: Center(
                child: DecoratedPageTitle(title: l10n.titleA),
              ),
            ),
            Container(
              width: size.width,
              color: Theme.of(context).colorScheme.surfaceContainer,
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Center(
                child: ProfileSection(
                  width: (size.width * 0.9).clamp(0.0, 700.0),
                ),
              ),
            ),
          ]),
        ),
      )
    ]);

    final body = Column(children: [
      CustomMinAppBar(),
      Expanded(child: stack,)
    ],);

    return Scaffold(
      endDrawer: const CustomDrawer(),
      body: body,
    );
  }
}
