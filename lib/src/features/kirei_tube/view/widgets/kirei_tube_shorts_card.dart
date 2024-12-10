import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import '../../../../common/styles/skeleton_style.dart';
import '../../../../common/widgets/containers/banner_image.dart';
import '../../../../utils/constants/sizes.dart';

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
      child: Column(
        children: [
          hittingApi
              ? ShimmerHelper().buildBasicShimmer(width: 138, height: 228)
              : AppBannerImage(
                  height: 228,
                  fit: BoxFit.cover,
                  applyImageRadius: false,
                  isNetworkImage: true,
                  imgUrl: shortsBanner),
          SizedBox(
            height: 40,
            child: hittingApi
                ? ShimmerHelper()
                    .buildBasicShimmer(height: 15, width: 100)
                : Text(
                    shortsTitle,
                    style: Theme.of(context).textTheme.titleLarge,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
          ),
        ],
      ),
    );
  }
}
