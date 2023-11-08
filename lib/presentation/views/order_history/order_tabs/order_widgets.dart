import 'package:flutter/material.dart';
import 'package:insta_king/core/constants/env_colors.dart';

class CustomTabIndicator extends BoxDecoration {
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CustomTabIndicatorPainter(this, onChanged);
  }
}

class _CustomTabIndicatorPainter extends BoxPainter {
  final CustomTabIndicator decoration;

  _CustomTabIndicatorPainter(this.decoration, VoidCallback? onChanged)
      : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final rect = offset & configuration.size!;
    final paint = Paint()
      ..color = EnvColors.primaryColor
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, Radius.circular(10.0)),
      paint,
    );
  }
}
