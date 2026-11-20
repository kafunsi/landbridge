import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

/// Animated spider-web background that adapts to the active theme.
class SpiderWebBackground extends StatefulWidget {
  final Widget child;

  const SpiderWebBackground({super.key, required this.child});

  @override
  State<SpiderWebBackground> createState() => _SpiderWebBackgroundState();
}

class _SpiderWebBackgroundState extends State<SpiderWebBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animation = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 24),
  )..repeat();

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = isDark ? AppColors.emeraldTealLight : AppColors.royalBlue;
    final secondary = isDark ? AppColors.royalBlueLight : AppColors.emeraldTeal;

    return Stack(
      children: [
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? [AppColors.darkBackground, const Color(0xFF121A24)]
                    : [AppColors.lightBackground, AppColors.white],
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: CustomPaint(
            painter: _WebPainter(
              colorPrimary: primary.withValues(alpha: isDark ? 0.16 : 0.10),
              colorSecondary: secondary.withValues(alpha: isDark ? 0.12 : 0.08),
              animation: _animation,
            ),
          ),
        ),
        Positioned.fill(child: widget.child),
      ],
    );
  }
}

class _WebPainter extends CustomPainter {
  final Color colorPrimary;
  final Color colorSecondary;
  final Animation<double> animation;

  _WebPainter({
    required this.colorPrimary,
    required this.colorSecondary,
    required this.animation,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final rand = math.Random(7); // deterministic layout
    final nodes = <Offset>[];
    final count = math.min(
      64,
      math.max(14, (size.width * size.height / 26000).round()),
    );
    final progress = animation.value * math.pi * 2;

    for (var i = 0; i < count; i++) {
      final x = rand.nextDouble();
      final y = rand.nextDouble();
      final phase = rand.nextDouble() * math.pi * 2;
      final speed = 0.7 + rand.nextDouble() * 0.6;
      nodes.add(
        Offset(
          (x + math.sin(progress * speed + phase) * 0.018).clamp(0.0, 1.0) *
              size.width,
          (y + math.cos(progress * speed + phase) * 0.018).clamp(0.0, 1.0) *
              size.height,
        ),
      );
    }

    final linePaintA = Paint()
      ..color = colorPrimary
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final linePaintB = Paint()
      ..color = colorSecondary
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke;

    final nodePaint = Paint()
      ..color = colorPrimary.withValues(alpha: 0.35)
      ..style = PaintingStyle.fill;

    // Connect nearby nodes to form a web.
    for (var i = 0; i < nodes.length; i++) {
      for (var j = i + 1; j < nodes.length; j++) {
        final d = (nodes[i] - nodes[j]).distance;
        if (d < size.width * 0.28) {
          final paint = (i + j) % 2 == 0 ? linePaintA : linePaintB;
          canvas.drawLine(nodes[i], nodes[j], paint);
        }
      }
    }

    for (var i = 0; i < nodes.length; i++) {
      final pulse = 2.0 + math.sin(progress + i) * 0.5;
      canvas.drawCircle(nodes[i], pulse, nodePaint);
    }
  }

  @override
  bool shouldRepaint(_WebPainter oldDelegate) =>
      oldDelegate.colorPrimary != colorPrimary ||
      oldDelegate.colorSecondary != colorSecondary ||
      oldDelegate.animation != animation;
}
