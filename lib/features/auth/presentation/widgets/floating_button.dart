import 'package:flutter/material.dart';
import 'package:digital_shop/core/constants/app_colors.dart';

class AnimatedStartButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const AnimatedStartButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  State<AnimatedStartButton> createState() => _AnimatedStartButtonState();
}

class _AnimatedStartButtonState extends State<AnimatedStartButton> with TickerProviderStateMixin {
  late final AnimationController _floatController;
  late final AnimationController _shadowController;
  late final AnimationController _scaleController;

  late final Animation<Offset> _floatAnimation;
  late final Animation<double> _shadowAnimation;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _floatAnimation = Tween<Offset>(
      begin: const Offset(0, 0.03),
      end: const Offset(0, -0.03),
    ).animate(CurvedAnimation(
      parent: _floatController,
      curve: Curves.elasticInOut,
    ));

    _shadowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _shadowAnimation = Tween<double>(
      begin: 6.0,
      end: 18.0,
    ).animate(CurvedAnimation(
      parent: _shadowController,
      curve: Curves.easeInOut,
    ));

    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.07,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _floatController.dispose();
    _shadowController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SlideTransition(
        position: _floatAnimation,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 50.0),
          child: AnimatedBuilder(
            animation: Listenable.merge([_shadowController, _scaleController]),
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: ElevatedButton(
                  onPressed: widget.onPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: _shadowAnimation.value,
                    shadowColor: AppColors.primary.withOpacity(0.5),
                  ),
                  child: Text(
                    widget.text,
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
