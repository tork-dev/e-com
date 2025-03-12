import 'package:flutter/material.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import '../../../../common/styles/skeleton_style.dart';
import '../../../../common/widgets/containers/banner_image.dart';

class KireiTubeShortsCard extends StatelessWidget {
  const KireiTubeShortsCard(
      {super.key,
      required this.hittingApi,
      required this.shortsBanner,
      required this.shortsTitle,
      this.onShortsPress});

  final bool hittingApi;
  final String shortsBanner, shortsTitle;
  final VoidCallback? onShortsPress;

  @override
  Widget build(BuildContext context) {
    return AppCardContainer(
      onTap: onShortsPress,
      width: 138,
      child: Stack(
        children: [
          hittingApi
              ? ShimmerHelper().buildBasicShimmer(width: 138, height: 228)
              : AspectRatio(
            aspectRatio: 9/16,
                child: AppBannerImage(
                    // height: 250,
                    // width: double.infinity,
                    backgroundColor: AppColors.addToCartButton,
                    fit: BoxFit.fitHeight,
                    applyImageRadius: false,
                    isNetworkImage: true,
                    imgUrl: shortsBanner),
              ),
          const Center(
            child: AppCardContainer(
              height: 60,
              width: 60,
              applyRadius: false,
              isCircle: true,
              backgroundColor: AppColors.dark,
              child: Icon(
                Icons.play_arrow_rounded,
                color: AppColors.white,
                size: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
