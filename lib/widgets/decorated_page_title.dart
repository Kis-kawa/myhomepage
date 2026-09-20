import 'package:flutter/material.dart';

class DecoratedPageTitle extends StatelessWidget {
  final String title;

  const DecoratedPageTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // 1. 最背面：ソフトな影
        Text(
          title,
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
          title,
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
          title,
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
          title,
          style: const TextStyle(
            fontSize: 54,
            fontWeight: FontWeight.w900,
            letterSpacing: 4.0,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
