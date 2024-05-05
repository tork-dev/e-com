import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class AppBannerImage extends StatelessWidget {
  const AppBannerImage({
    this.height,
    this.width,
    this.onPress,
    required this.imgUrl,
    this.applyImageRadius = true,
    this.fit = BoxFit.contain,
    this.boarderRadius = AppSizes.md,
    this.isNetworkImage = false,
    this.imageOpacity = 1,
    super.key,
  });

  final double? height, width, imageOpacity;
  final String imgUrl;
  final bool applyImageRadius;
  final BoxFit? fit;
  final bool isNetworkImage;
  final double boarderRadius;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: height,
        width: width,
        decoration:
        BoxDecoration(borderRadius: BorderRadius.circular(boarderRadius)),
        child: ClipRRect(
            borderRadius: applyImageRadius
                ? BorderRadius.circular(boarderRadius)
                : BorderRadius.zero,
            child: Image(
              image: isNetworkImage
                  ? NetworkImage(imgUrl)
                  : AssetImage(imgUrl) as ImageProvider,
              fit: fit,
                opacity: AlwaysStoppedAnimation(imageOpacity!),
              //color: Colors.red.withOpacity(.2),
            )),
      ),
    );
  }
}