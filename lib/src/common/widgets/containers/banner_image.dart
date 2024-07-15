import 'dart:io';
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
    this.hasBorder = false,
    this.isFileImage = false,
    this.borderColor,
    this.padding = const EdgeInsets.all(AppSizes.sm),
    this.applyPadding = false,
    this.backgroundColor,
    super.key,
  });

  final double? height, width, imageOpacity, borderWidth;
  final dynamic imgUrl;
  final bool applyImageRadius, applyPadding;
  final EdgeInsets padding;
  final BoxFit? fit;
  final bool isNetworkImage, hasBorder, isFileImage;
  final double imgBoarderRadius, boarderRadius;
  final VoidCallback? onPress;
  final Color? borderColor, backgroundColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: AppCardContainer(
        padding: applyPadding ? padding : const EdgeInsets.all(0),
        height: height,
        width: width,
        hasBorder: hasBorder, // if you want to use this. you must have use borderWidth and borderColor
        borderWidth: borderWidth,
        borderColor: borderColor,
        borderRadius: boarderRadius,
        backgroundColor: backgroundColor,
        child: ClipRRect(
            borderRadius: applyImageRadius
                ? BorderRadius.circular(imgBoarderRadius)
                : BorderRadius.zero,
            child: isNetworkImage
                ?
                //Image(image: NetworkImage(imgUrl), fit: fit,)
                CachedNetworkImage(
                    imageUrl: imgUrl,
                    fit: fit,
                    placeholder: (context, url) =>
                        ShimmerHelper().buildBasicShimmer(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  )
                : !isFileImage
                    ? Image(
                        image: AssetImage(imgUrl) as ImageProvider,
                        fit: fit,
                        //opacity: AlwaysStoppedAnimation(imageOpacity!),
                        //color: Colors.red.withOpacity(.2),
                      )
                    : Image(image: FileImage(imgUrl as File))),
      ),
    );
  }
}
