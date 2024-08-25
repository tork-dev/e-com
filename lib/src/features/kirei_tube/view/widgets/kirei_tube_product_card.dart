import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/common/widgets/containers/banner_image.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/kirei_tube/controller/kirei_tube_details_controller.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

class KireiTubeProductCard extends StatelessWidget {
  const KireiTubeProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    final kireiTubeDetailsController = KireiTubeDetailsController.instance;
    return Obx(() {
      return AppListViewLayout(
          itemCount: kireiTubeDetailsController.hittingApi.value
              ? 2
              : kireiTubeDetailsController
                  .kireiTubeDetailsResponse.value.data!.products!.length,
          builderFunction: (context, index) {
            return kireiTubeDetailsController.hittingApi.value
                ? ShimmerHelper().buildBasicShimmer(height: 100)
                : AppCardContainer(
                    padding: const EdgeInsets.all(AppSizes.md),
                    applyRadius: false,
                    backgroundColor: AppColors.lightGrey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppBannerImage(
                            height: 112,
                            width: 112,
                            applyImageRadius: false,
                            backgroundColor: AppColors.white,
                            isNetworkImage: true,
                            imgUrl: kireiTubeDetailsController
                                .kireiTubeDetailsResponse
                                .value
                                .data!
                                .products![index]
                                .pictures![0]
                                .url),
                        SizedBox(
                            width: 200,
                            child: Column(
                              children: [
                                Text(
                                  kireiTubeDetailsController
                                      .kireiTubeDetailsResponse
                                      .value
                                      .data!
                                      .products![index]
                                      .name!,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                                const Gap(AppSizes.spaceBtwDefaultItems),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Visibility(
                                          visible: kireiTubeDetailsController
                                                  .kireiTubeDetailsResponse
                                                  .value
                                                  .data!
                                                  .products![index]
                                                  .salePrice !=
                                              kireiTubeDetailsController
                                                  .kireiTubeDetailsResponse
                                                  .value
                                                  .data!
                                                  .products![index]
                                                  .price,
                                          child: Row(
                                            children: [
                                              Text(
                                                  "৳${kireiTubeDetailsController.kireiTubeDetailsResponse.value.data!.products![index].price!}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!
                                                      .copyWith(
                                                        decoration: TextDecoration
                                                            .lineThrough,
                                                      )),
                                              const Gap(AppSizes.sm),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          "৳${kireiTubeDetailsController.kireiTubeDetailsResponse.value.data!.products![index].salePrice!}",
                                          style:
                                              Theme.of(context).textTheme.bodyLarge,
                                        ),
                                      ],
                                    ),
                                    const AppCardContainer(
                                      height: 40,
                                        width: 40,
                                        backgroundColor: AppColors.white,
                                        applyRadius: false,
                                        child: Icon(Icons.shopping_bag_outlined))
                                  ],
                                )
                              ],
                            ))
                      ],
                    ));
          });
    });
  }
}
