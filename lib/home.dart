import 'package:flutter/material.dart';
import 'package:myhomepage/widgets/custom_app_bar.dart';
import 'package:myhomepage/widgets/custom_min_app_bar.dart';




class PcHomeLayout extends StatelessWidget {
  const PcHomeLayout({super.key});


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;


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
        Container(width: size.width ,height: 270,color: Colors.transparent,),
        Container(width: size.width, color:Colors.black, child: Row(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
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
            Container(width: size.width ,height: -0.36*size.width+630,color: Colors.transparent,child: Center(child: Text("プロフィール /n 4月14日"),),),
            Container(width: size.width ,color: Colors.black, child: Column(children: [
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
      endDrawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text("メニュー", style: TextStyle(fontSize: 20)),
            ),
            ListTile(
              title: Text("プロフィール"),
              onTap: () {},
            ),
            ListTile(
              title: Text("記事"),
              onTap: () {},
            ),
          ],
        ),
      ),
    body: body,
    );
  }
}
