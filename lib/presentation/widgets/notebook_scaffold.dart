import 'package:flutter/material.dart';

class NotebookScaffold extends StatelessWidget {
  const NotebookScaffold({
    super.key,
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scaffoldColor = Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: scaffoldColor,
          gradient: LinearGradient(
            colors: <Color>[
              scaffoldColor,
              Theme.of(context).cardColor.withOpacity(0.92),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: IgnorePointer(
                child: CustomPaint(
                  painter: _NotebookLinesPainter(
                    lineColor:
                        Theme.of(context).dividerColor.withOpacity(0.08),
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotebookLinesPainter extends CustomPainter {
  _NotebookLinesPainter({required this.lineColor});

  final Color lineColor;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = 1;

    for (double y = 48; y < size.height; y += 36) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _NotebookLinesPainter oldDelegate) {
    return oldDelegate.lineColor != lineColor;
  }
}
