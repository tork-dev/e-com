import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kirei/src/utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../styles/skeleton_style.dart';
import 'card_container.dart';

class AppBannerImage extends StatelessWidget {
  const AppBannerImage({
    this.height,
    this.width,
    this.onPress,
    required this.imgUrl,
    this.applyOnlyRadius = false,
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
    this.topLeftRadius = 0,
    this.topRightRadius = 0,
    this.bottomLeftRadius = 0,
    this.bottomRightRadius = 0,
    this.errorImage = AppImages.placeholder,
    super.key,
  });

  final double? height, width, imageOpacity, borderWidth;
  final dynamic imgUrl;
  final bool applyImageRadius, applyPadding, applyOnlyRadius;
  final EdgeInsets padding;
  final BoxFit? fit;
  final bool isNetworkImage, hasBorder, isFileImage;
  final double imgBoarderRadius, boarderRadius,
      topLeftRadius,
      topRightRadius,
      bottomLeftRadius,
      bottomRightRadius;
  final VoidCallback? onPress;
  final Color? borderColor, backgroundColor;
  final String errorImage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: AppCardContainer(
        // applyRadius: applyImageRadius,
        padding: applyPadding ? padding : const EdgeInsets.all(0),
        height: height,
        width: width,
        hasBorder: hasBorder,
        // if you want to use this. you must have use borderWidth and borderColor
        borderWidth: borderWidth,
        borderColor: borderColor,
        borderRadius: boarderRadius,
        backgroundColor: backgroundColor,
        child: ClipRRect(
          borderRadius:
              applyOnlyRadius
                  ?  BorderRadius.only(
                topLeft: Radius.circular(topLeftRadius),
                topRight: Radius.circular(topRightRadius),
                bottomLeft: Radius.circular(bottomLeftRadius),
                bottomRight: Radius.circular(bottomRightRadius),
              )
                  : applyImageRadius
                  ? BorderRadius.circular(imgBoarderRadius)
                  : BorderRadius.zero,
          child:
              isNetworkImage
                  ?
                  //Image(image: NetworkImage(imgUrl), fit: fit,)
                  CachedNetworkImage(
                    imageUrl: imgUrl,
                    fit: fit,
                    placeholder:
                        (context, url) => ShimmerHelper().buildBasicShimmer(),
                    errorWidget:
                        (context, url, error) => Image.asset(errorImage, fit: BoxFit.cover,),
                  )
                  : !isFileImage
                  ? Image(
                    image: AssetImage(imgUrl) as ImageProvider,
                    fit: fit,
                  )
                  : Image(image: FileImage(imgUrl as File)),
        ),
      ),
    );
  }
}
