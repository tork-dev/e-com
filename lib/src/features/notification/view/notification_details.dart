import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/common/widgets/containers/banner_image.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/notification/controller/notification_details_controller.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:kirei/src/utils/helpers/routing_helper.dart';
import 'package:kirei/src/utils/logging/logger.dart';
import '../../../utils/helpers/helper_functions.dart';

class NotificationDetails extends StatelessWidget {
  final int notificationId;

  const NotificationDetails({super.key, required this.notificationId});

  @override
  Widget build(BuildContext context) {
    final detailsController = Get.put(
      NotificationDetailsController(notificationId: notificationId),
    );
    return AppLayoutWithBackButton(
      title: const Text('Notification Details'),
      body: Obx(() {
        Log.i(detailsController.hittingApi.value.toString());
        return detailsController.hittingApi.value
            ? ShimmerHelper().buildListShimmer(itemCount: 10, itemHeight: 70.00)
            : ListView(
              children: [
                const Gap(AppSizes.md),
                Text(
                  detailsController
                          .userNotification
                          .value
                          .data!
                          .data![0]
                          .title ??
                      '',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Gap(AppSizes.xs),
                Text(
                  detailsController
                          .userNotification
                          .value
                          .data!
                          .data![0]
                          .description ??
                      '',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const Gap(AppSizes.spaceBtwItems),
                Visibility(
                  visible:
                      detailsController
                          .userNotification
                          .value
                          .data!
                          .data![0]
                          .image !=
                      null,
                  child: AppBannerImage(
                    isNetworkImage: true,
                    imgUrl:
                        detailsController
                            .userNotification
                            .value
                            .data!
                            .data![0]
                            .image,
                  ),
                ),

                const Gap(AppSizes.spaceBtwItems),
                Text(
                  AppHelperFunctions.formatTimestampWithAgo(
                    detailsController
                        .userNotification
                        .value
                        .data!
                        .data![0]
                        .createdAt,
                  ),
                  style: Theme.of(context).textTheme.labelMedium,
                ),

                const Gap(AppSizes.appBarHeight),

                Visibility(
                  visible:
                      detailsController
                          .userNotification
                          .value
                          .data
                          ?.data?[0]
                          .route !=
                      null,
                  child: AppCardContainer(
                    onTap:
                        () => WidgetsBinding.instance.addPostFrameCallback((_) {
                          RoutingHelper.urlRouting(
                            detailsController
                                .userNotification
                                .value
                                .data
                                ?.data?[0]
                                .route,
                          );
                        }),
                    backgroundColor: AppColors.primary,
                    width: 150,
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSizes.sm,
                      horizontal: AppSizes.spaceBtwItems,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          detailsController
                                  .userNotification
                                  .value
                                  .data
                                  ?.data?[0]
                                  .btnName ??
                              'View details ',
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge!.apply(color: AppColors.white),
                        ),
                        const Icon(
                          Icons.arrow_forward,
                          size: 18,
                          color: AppColors.white,
                        ),
                      ],
                    ),
                  ),

                  // child: TextButton(onPressed: (){
                  //   RoutingHelper.urlRouting(detailsController.userNotification.value.data?.data?[0].route);
                  // }, child:

                  // ),
                ),
              ],
            );
      }),
    );
  }
}
