import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:kirei/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/details/controller/details_page_controller.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

import '../../../../common/widgets/containers/banner_image.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';

class AppDetailsPicturePart extends StatelessWidget {
  const AppDetailsPicturePart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final detailsController = DetailsPageController.instance;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
      child: Obx(() {
        return SizedBox(
          height: 200,
          width: AppHelperFunctions.screenWidth() * 1,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 50,
                child: AppListViewLayout(
                    isScrollVertically: true,
                    itemCount: detailsController
                                .productDetails.value.detailedProducts ==
                            null
                        ? 3
                        : detailsController.productDetails.value
                            .detailedProducts!.pictures!.length,
                    builderFunction: (context, index) => detailsController
                                .productDetails.value.detailedProducts ==
                            null
                        ? ShimmerHelper()
                            .buildBasicShimmer(height: 50, width: 50)
                        : InkWell(
                            onTap: () {
                              detailsController.getLargePicture(index);
                            },
                            child: AppBannerImage(
                                height: 50,
                                width: 50,
                                fit: BoxFit.fill,
                                hasBorder:
                                    detailsController.pictureIndex.value ==
                                        index,
                                borderWidth: 2,
                                borderColor: AppColors.secondary,
                                boarderRadius: 8,
                                isNetworkImage: true,
                                imgUrl: detailsController.productDetails.value
                                    .detailedProducts!.pictures![index].url!),
                          )),
              ),
              const Gap(AppSizes.spaceBtwSections),
              detailsController.productDetails.value.detailedProducts == null
                  ? ShimmerHelper().buildBasicShimmer(height: 200, width: 250)
                  : InstaImageViewer(
                    child: Material(
                      child: AppBannerImage(
                          width: 250,
                          fit: BoxFit.contain,
                          applyImageRadius: false,
                          isNetworkImage: true,
                          imgUrl: detailsController
                              .productDetails
                              .value
                              .detailedProducts!
                              .pictures![detailsController.pictureIndex.value]
                              .url!),
                    ),
                  )
            ],
          ),
        );
      }),
    );
  }
}
