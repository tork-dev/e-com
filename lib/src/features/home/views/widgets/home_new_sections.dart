import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/common/widgets/containers/banner_image.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/home/controller/home_controller.dart';
import 'package:kirei/src/utils/constants/app_api_end_points.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/image_strings.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';

import '../../../../utils/helpers/routing_helper.dart';

class HomeImageTitleAndButtonSection extends StatelessWidget {
  const HomeImageTitleAndButtonSection(
      {super.key,
      required this.sectionName,
      required this.showTheSection,
      this.showBg = true,
      this.fit = BoxFit.contain,
      this.bgUrl = AppImages.aiRecommendationBg});

  final sectionName;
  final bool showTheSection, showBg;
  final BoxFit fit;
  final String bgUrl;

  @override
  Widget build(BuildContext context) {
    final homeController = HomeController.instance;
    final String baseUrlWeb = dotenv.env["BASE_URL_WEB"]!;
    return Obx(() {
      return Visibility(
        visible: showTheSection,
        child: AppCardContainer(
            child: Column(
          children: [
            const Gap(AppSizes.defaultSpace),
            homeController.hittingApi.value
                ? ShimmerHelper().buildBasicShimmer(height: 250)
                : AppCardContainer(
                    height: 216,
                    child: Stack(
                      children: [
                        Visibility(
                          visible: showBg,
                          child: AppBannerImage(
                            width: AppHelperFunctions.screenWidth(),
                            imgUrl: bgUrl,
                            fit: BoxFit.cover,
                            applyImageRadius: false,
                          ),
                        ),
                        AppBannerImage(
                            width: AppHelperFunctions.screenWidth(),
                            fit: fit,
                            applyImageRadius: false,
                            isNetworkImage: sectionName?.banner != null,
                            imgUrl: sectionName?.banner),
                      ],
                    ),
                  ),
            Padding(
                padding: const EdgeInsets.all(AppSizes.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    homeController.hittingApi.value
                        ? ShimmerHelper()
                            .buildBasicShimmer(height: 20, width: 300)
                        : Text(
                            sectionName?.title ?? '',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                    const Gap(AppSizes.spaceBtwDefaultItems),
                    homeController.hittingApi.value
                        ? ShimmerHelper()
                            .buildBasicShimmer(height: 20, width: 200)
                        : HtmlWidget(
                            sectionName?.description ?? '',
                          ),
                    const Gap(AppSizes.defaultSpace),
                    homeController.hittingApi.value
                        ? ShimmerHelper()
                            .buildBasicShimmer(height: 40, width: 150)
                        : AppCardContainer(
                            onTap: () {
                              print(sectionName?.route);
                              RoutingHelper.urlRouting(sectionName?.route ??
                                  '$baseUrlWeb/kirei-tube');
                            },
                            backgroundColor: AppColors.secondary,
                            applyRadius: false,
                            padding: const EdgeInsets.only(
                                left: AppSizes.defaultSpace,
                                right: AppSizes.defaultSpace,
                                top: AppSizes.spaceBtwDefaultItems,
                                bottom: AppSizes.spaceBtwDefaultItems),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  sectionName?.btnName ?? '',
                                  style:
                                      const TextStyle(color: AppColors.white),
                                ),
                              ],
                            ))
                  ],
                )),
          ],
        )),
      );
    });
  }
}
