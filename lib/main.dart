import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Hello world!"));
  }
}

void main() {
  const body = MyWidget();
  const scaffold = Scaffold(body: body,);
  const app = MaterialApp(home: scaffold,);
  runApp(app);
}
