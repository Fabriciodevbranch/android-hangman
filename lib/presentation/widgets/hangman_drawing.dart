import 'package:flutter/material.dart';

class HangmanDrawing extends StatelessWidget {
  const HangmanDrawing({
    super.key,
    required this.wrongAttempts,
  });

  final int wrongAttempts;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: CustomPaint(
        painter: _HangmanPainter(
          stage: wrongAttempts.clamp(0, 6),
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}

class _HangmanPainter extends CustomPainter {
  _HangmanPainter({
    required this.stage,
    required this.color,
  });

  final int stage;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final baseY = size.height - 12;
    canvas.drawLine(Offset(24, baseY), Offset(size.width * 0.72, baseY), paint);
    canvas.drawLine(Offset(56, baseY), Offset(56, 18), paint);
    canvas.drawLine(Offset(54, 18), Offset(size.width * 0.56, 18), paint);
    canvas.drawLine(
      Offset(size.width * 0.56, 18),
      Offset(size.width * 0.56, 38),
      paint,
    );

    final headCenter = Offset(size.width * 0.56, 56);

    if (stage >= 1) {
      canvas.drawCircle(headCenter, 18, paint);
    }
    if (stage >= 2) {
      canvas.drawLine(
        Offset(headCenter.dx, 74),
        Offset(headCenter.dx, 122),
        paint,
      );
    }
    if (stage >= 3) {
      canvas.drawLine(
        Offset(headCenter.dx, 88),
        Offset(headCenter.dx - 28, 104),
        paint,
      );
    }
    if (stage >= 4) {
      canvas.drawLine(
        Offset(headCenter.dx, 88),
        Offset(headCenter.dx + 28, 104),
        paint,
      );
    }
    if (stage >= 5) {
      canvas.drawLine(
        Offset(headCenter.dx, 122),
        Offset(headCenter.dx - 24, 154),
        paint,
      );
    }
    if (stage >= 6) {
      canvas.drawLine(
        Offset(headCenter.dx, 122),
        Offset(headCenter.dx + 24, 154),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _HangmanPainter oldDelegate) {
    return oldDelegate.stage != stage || oldDelegate.color != color;
  }
}
