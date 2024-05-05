import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:torganic/src/common/widgets/containers/card_container.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../buttons/app_buttons.dart';
import 'banner_image.dart';

class AppProductImageContainer extends StatelessWidget {
  const AppProductImageContainer({
    this.height,
    this.width,
    this.border,
    this.onPress,
    required this.imgUrl,
    this.fit = BoxFit.contain,
    this.boarderRadius = AppSizes.md,
    this.isNetworkImage = false,
    this.applyImageRadius = true,
    this.backgroundColor = AppColors.light,
    super.key,
  });

  final double? height, width;
  final String imgUrl;
  final BoxBorder? border;
  final Color backgroundColor;
  final BoxFit? fit;
  final bool isNetworkImage, applyImageRadius;
  final double boarderRadius;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    final isDark = AppHelperFunctions.isDarkMode(context);
    return InkWell(
      onTap: onPress,
      child: Stack(
        children: [
          AppBannerImage(
              onPress: onPress,
              height: height,
              width: width,
              applyImageRadius: applyImageRadius,
              isNetworkImage: isNetworkImage,
              boarderRadius: boarderRadius,
              fit: fit,
              imgUrl: AppImages.banner3),
          Positioned(
            right: 10,
            top: 10,
            child: AppButtons.iconRoundButton(
                onPressed: () {},
                buttonColor: isDark? AppColors.black: AppColors.white,
                icon: CupertinoIcons.bookmark,
                iconSize: 14),
          ),
        ],
      ),
    );
  }
}
