import 'package:flutter/material.dart';
import '../../../utils/constants/sizes.dart';



class AppCardContainer extends StatelessWidget {
  const AppCardContainer({
    this.height,
    this.width,
    this.backgroundColor,
    this.gradient,
    this.padding,
    this.borderRadius = AppSizes.cardRadiusLg,
    this.applyRadius = true,
    this.hasBorder = false,
    this.borderColor,
    this.borderWidth,
    required this.child,
    this.onTap,
    super.key});

  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor, borderColor;
  final Gradient? gradient;
  final bool applyRadius;
  final double borderRadius;
  final double? height, width, borderWidth;
  final bool hasBorder;
  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: padding,
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: backgroundColor,
          gradient: gradient,
          border: hasBorder ? Border.all(color: borderColor!, width: borderWidth!) : null,
          borderRadius: applyRadius? BorderRadius.circular(borderRadius) : BorderRadius.zero
        ),
        child: child,
      ),
    );
  }
}

