import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../containers/card_container.dart';

class AppTabsCard extends StatelessWidget {
  const AppTabsCard({
    required this.tabName,
    this.onTap,
    this.backgroundColor,
    super.key,
    this.isNeedBorder = false,
    this.isNeedPadding = true,
    this.textFontSize = 12,
    this.textFontWidth = FontWeight.w400,
    this.tabCardTextColor = AppColors.secondary,
  });

  final String tabName;
  final bool isNeedBorder;
  final bool isNeedPadding;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final double textFontSize;
  final FontWeight textFontWidth;
  final Color? tabCardTextColor;

  @override
  Widget build(BuildContext context) {
    final isDark = AppHelperFunctions.isDarkMode(context);
    return AppCardContainer(
      width: tabName.length <= 4 ? 60 : null,
      onTap: onTap,
      padding:
          isNeedPadding == true
              ? const EdgeInsets.symmetric(horizontal: 12, vertical: 7)
              : EdgeInsets.zero,
      hasBorder: isNeedBorder,
      borderColor: isDark ? AppColors.light : AppColors.dark,
      borderWidth: 0,
      backgroundColor: backgroundColor,
      margin: const EdgeInsets.symmetric(horizontal: AppSizes.xs),
      child: Center(
        child: Text(
          tabName,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: textFontSize,
            fontWeight: textFontWidth,
            color: tabCardTextColor,
          ),
        ),
      ),
    );
  }
}
