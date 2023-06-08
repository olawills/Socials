import 'package:flutter/material.dart';

class TabIndicatorWidget extends Decoration {
  final Color color;
  final double radius;
  const TabIndicatorWidget({required this.color, required this.radius});
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final Color color;
  double radius;
  _CirclePainter({required this.color, required this.radius});
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint paint = Paint();
    paint.color = color;
    paint.isAntiAlias = true;
    final Offset circlOffset =
        Offset(configuration.size!.width, configuration.size!.height);

    canvas.drawCircle(offset + circlOffset, radius, paint);
  }
}
