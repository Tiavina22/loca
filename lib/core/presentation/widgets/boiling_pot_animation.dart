import 'package:flutter/material.dart';
import 'dart:math';

class BoilingPotAnimation extends StatefulWidget {
  const BoilingPotAnimation({super.key});

  @override
  State<BoilingPotAnimation> createState() => _BoilingPotAnimationState();
}

class _BoilingPotAnimationState extends State<BoilingPotAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _bubbleAnimations;
  late Animation<double> _steamAnimation;
  late Animation<double> _flameAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();

    _bubbleAnimations = List.generate(
      5,
      (index) => Tween<double>(begin: 0, end: 20.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            (index * 0.2).clamp(
              0.0,
              0.8,
            ), // Ensure start is between 0.0 and 0.8
            ((index * 0.2) + 0.4).clamp(
              0.2,
              1.0,
            ), // Ensure end is between 0.2 and 1.0
            curve: Curves.easeInOut,
          ),
        ),
      ),
    );

    _steamAnimation = Tween<double>(begin: 0, end: 15.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.easeInOut),
      ),
    );

    _flameAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.easeInOut),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildFlame() {
    return Positioned(
      bottom: 0,
      child: CustomPaint(
        size: const Size(60, 25),
        painter: FlamePainter(_flameAnimation.value),
      ),
    );
  }

  Widget _buildPotSupport() {
    return Positioned(
      bottom: 15,
      child: Container(
        width: 100,
        height: 8,
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPot() {
    return Positioned(
      bottom: 30,
      child: Stack(
        children: [
          // Effet de brillance
          Container(
            width: 80,
            height: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.grey[850]!,
                  Colors.grey[900]!,
                  Colors.grey[800]!,
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.orange.withOpacity(0.3),
                  blurRadius: 15,
                  spreadRadius: _flameAnimation.value * 3,
                ),
              ],
            ),
          ),
          // Effet de brillance supplémentaire
          Positioned(
            top: 5,
            left: 10,
            child: Container(
              width: 20,
              height: 8,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSteamEffects() {
    return Stack(
      children: List.generate(
        5,
        (index) => Positioned(
          bottom: 80 + (_steamAnimation.value * (1 + index * 0.5)),
          left: 20 + (index * 10),
          child: Transform.translate(
            offset: Offset(sin(_controller.value * 2 * pi + index) * 5, 0),
            child: Opacity(
              opacity:
                  (0.7 - (_steamAnimation.value / 20)).clamp(0.0, 1.0) *
                  (1 - index * 0.15).clamp(0.0, 1.0),
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.3),
                      blurRadius: 5,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBubbles() {
    return Stack(
      children: List.generate(
        _bubbleAnimations.length,
        (index) => Positioned(
          bottom: 30 + _bubbleAnimations[index].value,
          left: 30 + (index * 8),
          child: Opacity(
            opacity: (1 - (_bubbleAnimations[index].value / 20)).clamp(
              0.0,
              1.0,
            ),
            child: Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return SizedBox(
          width: 120,
          height: 140,
          child: Stack(
            alignment: Alignment.center,
            children: [
              _buildPotSupport(),
              _buildFlame(),
              _buildPot(),
              ...List.generate(
                2,
                (index) => Positioned(
                  bottom: 45,
                  left: index == 0 ? 15 : null,
                  right: index == 1 ? 15 : null,
                  child: Container(
                    width: 10,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.grey[850],
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              _buildSteamEffects(),
              _buildBubbles(),
            ],
          ),
        );
      },
    );
  }
}

class FlamePainter extends CustomPainter {
  final double animationValue;

  FlamePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..style = PaintingStyle.fill
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3)
          ..shader = RadialGradient(
            center: const Alignment(0, -0.5),
            radius: 1.5,
            colors: [
              Colors.yellow.withOpacity(animationValue),
              Colors.orange.withOpacity(animationValue * 0.9),
              Colors.red[700]!.withOpacity(animationValue * 0.7),
            ],
          ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path = Path();
    path.moveTo(size.width * 0.2, size.height);
    path.quadraticBezierTo(
      size.width * 0.5,
      -size.height * 0.2 * animationValue,
      size.width * 0.8,
      size.height,
    );
    path.close();

    canvas.drawPath(path, paint);

    // Petites flammes
    for (var i = 0; i < 3; i++) {
      final smallPath = Path();
      final xOffset = size.width * (0.3 + (i * 0.2));
      smallPath.moveTo(xOffset, size.height);
      smallPath.quadraticBezierTo(
        xOffset + (size.width * 0.1),
        size.height * (0.5 - (0.2 * animationValue)),
        xOffset + (size.width * 0.2),
        size.height,
      );
      canvas.drawPath(smallPath, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
