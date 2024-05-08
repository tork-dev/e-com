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
    this.boarderRadius = 12,
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
      child: AppCardContainer(
        height: height,
        width: width,
        child: ClipRRect(
          borderRadius:applyImageRadius? BorderRadius.circular(boarderRadius) : BorderRadius.zero,
          child: isNetworkImage
              ? CachedNetworkImage(
                  imageUrl: imgUrl,
                  fit: fit,
                  placeholder: (context, url) =>
                      ShimmerHelper().buildBasicShimmer(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )
              : Image(
                  image: AssetImage(imgUrl) as ImageProvider,
                  fit: fit,
                  opacity: AlwaysStoppedAnimation(imageOpacity!),
                  //color: Colors.red.withOpacity(.2),
                ),
        ),
      ),
    );
  }
}
