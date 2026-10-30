import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Resolution-independent water, light rays and flowing current lines.
class AquaticBackground extends StatelessWidget {
  const AquaticBackground({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF052C43), Color(0xFF07566B), Color(0xFF087F88)],
      ),
    ),
    child: CustomPaint(painter: _WaterPainter(), child: child),
  );
}

class _WaterPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rayPaint = Paint()..color = const Color(0x06D9FFFF);
    for (int i = 0; i < 5; i++) {
      final x = size.width * (.1 + i * .19);
      canvas.drawPath(
        Path()
          ..moveTo(x, 0)
          ..lineTo(x + 90, 0)
          ..lineTo(x + size.width * .3, size.height)
          ..lineTo(x + 50, size.height)
          ..close(),
        rayPaint,
      );
    }
    for (int line = 0; line < 9; line++) {
      final path = Path();
      for (double x = 0; x <= size.width + 8; x += 8) {
        final y =
            size.height * .68 +
            line * 25 +
            math.sin(x / (size.width / 5) + line * .22) * (38 + line * 3);
        if (x == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      canvas.drawPath(
        path,
        Paint()
          ..color = const Color(0x157CF1E1)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1,
      );
    }
    final bubble = Paint()
      ..color = const Color(0x187CF1E1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.3;
    for (final dot in [
      const Offset(.08, .28),
      const Offset(.48, .18),
      const Offset(.89, .3),
      const Offset(.93, .65),
      const Offset(.55, .87),
    ]) {
      canvas.drawCircle(
        Offset(dot.dx * size.width, dot.dy * size.height),
        7,
        bubble,
      );
    }
  }

  @override
  bool shouldRepaint(_WaterPainter oldDelegate) => false;
}
