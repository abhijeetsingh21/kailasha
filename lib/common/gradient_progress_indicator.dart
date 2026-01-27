import 'dart:math';
import 'package:flutter/material.dart';
import 'package:kailasha/core/theme/app_colors.dart';
import 'package:kailasha/core/theme/app_size.dart';
class GradientProgressIndicator extends StatefulWidget {
  final double strokeWidth;
  final double size;

  const GradientProgressIndicator({
    super.key,
    this.strokeWidth = 6,
    this.size = 80,
  });

  @override
  State<GradientProgressIndicator> createState() =>
      _GradientProgressIndicatorState();
}

class _GradientProgressIndicatorState extends State<GradientProgressIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(); //  rotates forever
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * pi,
          child: CustomPaint(
            painter: _GradientArcPainter(strokeWidth: widget.strokeWidth),
            size: Size(
              widget.size.widthMultiplier,
              widget.size.widthMultiplier,
            ),
          ),
        );
      },
    );
  }
}

class _GradientArcPainter extends CustomPainter {
  final double strokeWidth;

  _GradientArcPainter({required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    final gradient = SweepGradient(
      startAngle: 0,
      endAngle: pi * 2,
      colors: const [Color(0xFFBFA9DD), Color(0xFF7954C7)],
    );

    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final backgroundPaint = Paint()
      ..color = AppColors.white100
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final center = size.center(Offset.zero);
    final radius = size.width / 2;

    canvas.drawCircle(center, radius, backgroundPaint);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      pi * 1.7,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(_) => true;
}
