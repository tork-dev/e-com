import 'package:flutter/material.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

import '../../../utils/constants/colors.dart';

class GlowingButton extends StatefulWidget {
  final String text;
  final Color color;
  final Color glowColor;
  final VoidCallback onTap;

  const GlowingButton({
    required this.text,
    required this.onTap,
    this.color = AppColors.primary,
    this.glowColor = const Color(0xffFF6F8F),
    super.key,
  });

  @override
  State<GlowingButton> createState() => _GlowingButtonState();
}

class _GlowingButtonState extends State<GlowingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      lowerBound: 0.4,
      upperBound: 1,
    )..repeat(reverse: true);
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
      builder: (context, child) {
        return GestureDetector(
          onTap: widget.onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
              boxShadow: [
                BoxShadow(
                  color: widget.glowColor.withAlpha(
                    (_controller.value * 255).toInt(),
                  ),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Text(
              widget.text,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        );
      },
    );
  }
}
