import 'dart:math' as math;
import 'package:flutter/material.dart';

class RoundedLoadingIndicators extends StatefulWidget {
  final double strokeWidth;
  final Color color;
  final double size;

  const RoundedLoadingIndicators({
    super.key,
    required this.color,
    this.strokeWidth = 6,
    this.size = 48,
  });

  @override
  State<RoundedLoadingIndicators> createState() =>
      _RoundedLoadingIndicatorsState();
}

class _RoundedLoadingIndicatorsState extends State<RoundedLoadingIndicators>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          return CustomPaint(
            painter: _RoundedPainter(
              progress: _controller.value,
              strokeWidth: widget.strokeWidth,
              color: widget.color,
            ),
          );
        },
      ),
    );
  }
}

class _RoundedPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color color;

  _RoundedPainter({
    required this.progress,
    required this.strokeWidth,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round; // 🔥 ujung bulat

    final radius = size.width / 2;

    canvas.drawArc(
      Rect.fromCircle(center: Offset(radius, radius), radius: radius),
      -math.pi / 2,
      progress * 2 * math.pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
