import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import '../../../../common/styles/skeleton_style.dart';
import '../../../../common/widgets/containers/banner_image.dart';
import '../../../../utils/constants/sizes.dart';

class KireiTubeShortsCard extends StatelessWidget {
  const KireiTubeShortsCard({
    super.key, required this.hittingApi, required this.shortsBanner, required this.shortsTitle, required this.shortsViewCount,
  });

  final bool hittingApi;
  final String shortsBanner, shortsTitle, shortsViewCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 138,
      child: Column(
        children: [
          hittingApi
              ? ShimmerHelper().buildBasicShimmer(
              width: 138, height: 228)
              : AppBannerImage(
              height: 228,
              fit: BoxFit.cover,
              applyImageRadius: false,
              isNetworkImage: true,
              imgUrl: shortsBanner),
          Padding(
            padding:
            const EdgeInsets.all(AppSizes.sm),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                  child: hittingApi
                      ? ShimmerHelper()
                      .buildBasicShimmer(
                      height: 15,
                      width: 100)
                      : Text(
                    shortsTitle,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge,
                    overflow:
                    TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                const Gap(AppSizes.xs),
                hittingApi
                    ? ShimmerHelper()
                    .buildBasicShimmer(
                    height: 10, width: 70)
                    : Text(
                  "${NumberFormat.compact().format(int.parse(shortsViewCount))} Views",
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge,
                  overflow:
                  TextOverflow.ellipsis,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}