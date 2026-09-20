import 'package:flutter/material.dart';
import 'package:myhomepage/l10n/l10n.dart';
import 'package:myhomepage/widgets/custom_app_bar.dart';
import 'package:myhomepage/widgets/custom_drawer.dart';
import 'package:myhomepage/widgets/custom_min_app_bar.dart';




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
            child: Stack(
              alignment: Alignment.center,
              children: [
                // 1. 最背面：ソフトな影
                Text(
                  l10n.titleA,
                  style: TextStyle(
                    fontSize: 54,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 4.0,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 14
                      ..color = Colors.black.withValues(alpha: 0.6)
                      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6),
                  ),
                ),
                // 2. 外側の枠線（白）
                Text(
                  l10n.titleA,
                  style: TextStyle(
                    fontSize: 54,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 4.0,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 10
                      ..strokeJoin = StrokeJoin.round
                      ..color = Colors.white,
                  ),
                ),
                // 3. 内側の枠線（黒）
                Text(
                  l10n.titleA,
                  style: TextStyle(
                    fontSize: 54,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 4.0,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 4
                      ..strokeJoin = StrokeJoin.round
                      ..color = Colors.black,
                  ),
                ),
                // 4. 最前面：文字本体
                Text(
                  l10n.titleA,
                  style: const TextStyle(
                    fontSize: 54,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 4.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(width: size.width, color: Theme.of(context).colorScheme.surfaceContainer, child: Row(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          SizedBox(width: 1,),
          SizedBox(width: 1),
          SizedBox(width: 1),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(width: size.width*0.5 ,height: 300,color: Colors.red,),
              Container(width: size.width*0.5 ,height: 300,color: Colors.yellow,),
              Container(width: size.width*0.5 ,height: 300,color: Colors.green,),
            ]),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(width: size.width*0.2 ,height: 300, decoration: BoxDecoration(color: Colors.red,borderRadius: BorderRadius.circular(10),),),
              Container(height: 20, color: Colors.transparent),
              Container(width: size.width*0.2 ,height: 600, decoration: BoxDecoration(color: Colors.yellow,borderRadius: BorderRadius.circular(10),),),
            ]),
          SizedBox(width: 1),
          SizedBox(width: 1),
          SizedBox(width: 1),
          ])
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
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // 1. 最背面：ソフトな影
                    Text(
                      l10n.titleA,
                      style: TextStyle(
                        fontSize: 54,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 4.0,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 14
                          ..color = Colors.black.withValues(alpha: 0.6)
                          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6),
                      ),
                    ),
                    // 2. 外側の枠線（白）
                    Text(
                      l10n.titleA,
                      style: TextStyle(
                        fontSize: 54,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 4.0,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 10
                          ..strokeJoin = StrokeJoin.round
                          ..color = Colors.white,
                      ),
                    ),
                    // 3. 内側の枠線（黒）
                    Text(
                      l10n.titleA,
                      style: TextStyle(
                        fontSize: 54,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 4.0,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 4
                          ..strokeJoin = StrokeJoin.round
                          ..color = Colors.black,
                      ),
                    ),
                    // 4. 最前面：文字本体
                    Text(
                      l10n.titleA,
                      style: const TextStyle(
                        fontSize: 54,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 4.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(width: size.width ,color: Theme.of(context).colorScheme.surfaceContainer, child: Column(children: [
              Container(width: size.width*0.9 ,height: 300,color: Colors.red,),
              Container(width: size.width*0.9 ,height: 300,color: Colors.yellow,),
              Container(width: size.width*0.9 ,height: 300,color: Colors.green,),
            ],),),
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
