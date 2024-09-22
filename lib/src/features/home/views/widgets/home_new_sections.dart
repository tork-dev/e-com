import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/common/widgets/containers/banner_image.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/home/controller/home_controller.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';

import '../../../../utils/helpers/routing_helper.dart';

class HomeImageTitleAndButtonSection extends StatelessWidget {
  const HomeImageTitleAndButtonSection({super.key, required this.sectionName});

  final sectionName;

  @override
  Widget build(BuildContext context) {
    final homeController = HomeController.instance;
    return Obx(() {
      return Visibility(
        visible: sectionName?.isActive == "1" && sectionName?.isActive != null,
        child: AppCardContainer(
            child: Column(
          children: [
            const Gap(AppSizes.spaceBtwSections),
            homeController.hittingApi.value
                ? ShimmerHelper().buildBasicShimmer(height: 250)
                :
                  AppBannerImage(
                    height: 300,
                      width: AppHelperFunctions.screenWidth(),
                      fit: BoxFit.cover,
                      applyImageRadius: false,
                      isNetworkImage: sectionName?.banner != null,
                      imgUrl: sectionName?.banner),
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
                            onTap: () => RoutingHelper.urlRouting(sectionName
                                    ?.route ??
                                'https://kireibd.com/kirei-tube'),
                            backgroundColor: AppColors.secondary,
                            applyRadius: false,
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppSizes.defaultSpace,
                                vertical: AppSizes.spaceBtwDefaultItems),
                            child: Text(
                              sectionName?.btnName ?? '',
                              style: const TextStyle(color: AppColors.white),
                            ))
                  ],
                )),
          ],
        )),
      );
    });
  }
}
