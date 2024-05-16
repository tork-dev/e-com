import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../utils/constants/sizes.dart';
import '../../styles/skeleton_style.dart';
import 'card_container.dart';

class AppBannerImage extends StatelessWidget {
  const AppBannerImage({
    this.height,
    this.width,
    this.onPress,
    required this.imgUrl,
    this.applyImageRadius = true,
    this.fit = BoxFit.fill,
    this.imgBoarderRadius = AppSizes.borderRadiusMd,
    this.boarderRadius = AppSizes.borderRadiusMd,
    this.isNetworkImage = false,
    this.imageOpacity = 1.0,
    this.borderWidth,
    this.hasBorder= false,
    this.borderColor,
    super.key,
  });

  final double? height, width, imageOpacity, borderWidth;
  final String imgUrl;
  final bool applyImageRadius;
  final BoxFit? fit;
  final bool isNetworkImage, hasBorder;
  final double imgBoarderRadius, boarderRadius;
  final VoidCallback? onPress;
  final Color? borderColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: AppCardContainer(
        height: height,
        width: width,
        hasBorder: hasBorder,
        borderWidth: borderWidth,
        borderColor: borderColor,
        borderRadius: boarderRadius,
        child: ClipRRect(
          borderRadius:applyImageRadius? BorderRadius.circular(imgBoarderRadius) : BorderRadius.zero,
          child: isNetworkImage
              ?
              //Image(image: NetworkImage(imgUrl), fit: fit,)
          CachedNetworkImage(
                  imageUrl: imgUrl,
                  fit: fit,
                  placeholder: (context, url) =>
                      ShimmerHelper().buildBasicShimmer(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )
              : Image(
                  image: AssetImage(imgUrl) as ImageProvider,
                  fit: fit,
                  //opacity: AlwaysStoppedAnimation(imageOpacity!),
                  //color: Colors.red.withOpacity(.2),
                ),
        ),
      ),
    );
  }
}
