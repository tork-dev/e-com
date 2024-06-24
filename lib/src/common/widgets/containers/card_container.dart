import 'package:flutter/material.dart';
import 'package:torganic/src/utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';



class AppCardContainer extends StatelessWidget {
  const AppCardContainer({
    this.height,
    this.width,
    this.backgroundColor,
    this.gradient,
    this.padding,
    this.margin,
    this.borderRadius = AppSizes.cardRadiusLg,
    this.applyRadius = true,
    this.hasBorder = false,
    this.borderColor = AppColors.secondary,
    this.borderWidth = 1,
    required this.child,
    this.onTap,
    this.applyShadow = false,
    this.isCircle = false,
    super.key});

  final EdgeInsetsGeometry? padding, margin;
  final Color? backgroundColor, borderColor;
  final Gradient? gradient;
  final bool applyRadius;
  final double borderRadius;
  final double? height, width, borderWidth;
  final bool hasBorder, applyShadow, isCircle;
  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: margin,
        padding: padding,
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: backgroundColor,
          gradient: gradient,
          shape: isCircle? BoxShape.circle : BoxShape.rectangle,
          border: hasBorder ? Border.all(color: borderColor!, width: borderWidth!) : null,
          borderRadius: applyRadius? BorderRadius.circular(borderRadius) : null,
          boxShadow: applyShadow? [
            const BoxShadow(color: AppColors.grey, blurRadius: 5, offset: Offset(0, 7))
          ]: null
        ),
        child: child,
      ),
    );
  }
}

