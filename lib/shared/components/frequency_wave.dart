import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../../core/theme/app_colors.dart';

class FrequencyWave extends StatefulWidget {
  final List<int> frequencyData;
  final Color color;
  final double height;
  final bool isPlaying;

  const FrequencyWave({
    super.key,
    this.frequencyData = const [],
    this.color = AppColors.primary,
    this.height = 120,
    this.isPlaying = true,
  });

  @override
  State<FrequencyWave> createState() => _FrequencyWaveState();
}

class _FrequencyWaveState extends State<FrequencyWave>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3600),
    );

    if (widget.isPlaying) {
      _animationController.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant FrequencyWave oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isPlaying != oldWidget.isPlaying) {
      if (widget.isPlaying) {
        _animationController.repeat();
      } else {
        _animationController.stop();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return CustomPaint(
          painter: _FrequencyWavePainter(
            frequencyData: widget.frequencyData,
            color: widget.color,
            animationValue: _animationController.value,
            isPlaying: widget.isPlaying,
          ),
          size: Size(double.infinity, widget.height),
        );
      },
    );
  }
}

class _FrequencyWavePainter extends CustomPainter {
  final List<int> frequencyData;
  final Color color;
  final double animationValue;
  final bool isPlaying;

  _FrequencyWavePainter({
    required this.frequencyData,
    required this.color,
    required this.animationValue,
    required this.isPlaying,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final centerY = size.height / 2;
    final pulse = isPlaying
        ? 0.5 + math.sin(animationValue * math.pi * 2) * 0.5
        : 0.35;

    final glowPaint = Paint()
      ..shader =
          RadialGradient(
            colors: [
              color.withOpacity(0.18 + pulse * 0.06),
              color.withOpacity(0.03),
              Colors.transparent,
            ],
          ).createShader(
            Rect.fromCircle(center: center, radius: size.shortestSide * 0.82),
          );

    canvas.drawCircle(center, size.shortestSide * 0.58, glowPaint);

    final orbPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = color.withOpacity(0.12);

    for (var i = 0; i < 3; i++) {
      final radius =
          size.shortestSide *
          (0.18 + i * 0.1 + (isPlaying ? pulse * 0.018 : 0));
      canvas.drawCircle(center, radius, orbPaint);
    }

    for (var layer = 0; layer < 3; layer++) {
      final path = Path();
      final amplitude = size.height * (0.08 + layer * 0.035);
      final phase = animationValue * math.pi * 2 * (0.55 + layer * 0.12);
      final verticalOffset = (layer - 1) * size.height * 0.08;

      for (var i = 0; i <= 96; i++) {
        final progress = i / 96;
        final x = progress * size.width;
        final dataBoost = frequencyData.isEmpty
            ? 1.0
            : 0.72 +
                  (frequencyData[(i + layer) % frequencyData.length] / 255) *
                      0.48;
        final envelope = math.sin(progress * math.pi);
        final wave =
            math.sin(progress * math.pi * (2.2 + layer * 0.65) + phase) *
            amplitude *
            envelope *
            dataBoost *
            (isPlaying ? 1 : 0.32);
        final breath =
            math.sin(progress * math.pi * 5 - phase * 0.45) *
            amplitude *
            0.24 *
            envelope *
            (isPlaying ? 1 : 0.25);
        final y = centerY + verticalOffset + wave + breath;

        if (i == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }

      final linePaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = layer == 1 ? 3.2 : 2
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..shader = LinearGradient(
          colors: [
            color.withOpacity(0.08),
            color.withOpacity(layer == 1 ? 0.78 : 0.42),
            color.withOpacity(0.08),
          ],
        ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

      canvas.drawPath(path, linePaint);
    }

    final particlePaint = Paint()..style = PaintingStyle.fill;
    for (var i = 0; i < 8; i++) {
      final progress = (i / 8 + animationValue * 0.18) % 1;
      final x = progress * size.width;
      final floatY =
          centerY +
          math.sin(progress * math.pi * 2 + i) *
              size.height *
              (isPlaying ? 0.18 : 0.05);
      particlePaint.color = color.withOpacity(isPlaying ? 0.24 : 0.08);
      canvas.drawCircle(Offset(x, floatY), 2.2 + (i % 3) * 0.7, particlePaint);
    }
  }

  @override
  bool shouldRepaint(_FrequencyWavePainter oldDelegate) {
    return oldDelegate.animationValue != animationValue ||
        oldDelegate.frequencyData != frequencyData ||
        oldDelegate.color != color ||
        oldDelegate.isPlaying != isPlaying;
  }
}
