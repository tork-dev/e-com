import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/common/widgets/buttons/app_buttons.dart';
import 'package:kirei/src/common/widgets/containers/new_product_card.dart';
import 'package:kirei/src/features/group_shopping/controller/group_shopping_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../common/widgets/containers/banner_image.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';

class GroupShoppingHeaderPart extends StatelessWidget {
  const GroupShoppingHeaderPart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final groupShoppingController = GroupShoppingController.instance;
    final ScrollController pageController = ScrollController();

    return Stack(
      children: [
        AppBannerImage(
          width: AppHelperFunctions.screenWidth(),
          applyImageRadius: false,
          imgUrl: AppImages.groupShoppingBg,
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: AppSizes.md, right: AppSizes.md, top: AppSizes.xl),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Why shop alone?',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const Gap(AppSizes.sm),
                Text(
                  'When you can shop & save with friends',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .apply(color: AppColors.darkGrey),
                ),
                const Gap(AppSizes.spaceBtwSections),
                SizedBox(
                  width: 125,
                  child: AppButtons.largeFlatFilledButton(
                      verticallyPadding: AppSizes.sm,
                      onPressed: () {},
                      backgroundColor: AppColors.secondary,
                      buttonText: 'JOIN TODAY'),
                ),
                const Gap(AppSizes.md),
                Obx(
                  () => SizedBox(
                    height: 300,
                    child: ListView.builder(
                      controller: pageController,
                      scrollDirection: Axis.horizontal,
                      itemCount: groupShoppingController.hittingApi.value
                          ? 2
                          : groupShoppingController
                              .groupShoppingProduct.value.data!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: AppSizes.md),
                          child: groupShoppingController.hittingApi.value
                              ? ShimmerHelper().buildBasicShimmer()
                              : AppNewProductCard(
                                  height: 300,
                                  width: 164,
                                  productName: groupShoppingController
                                      .groupShoppingProduct
                                      .value
                                      .data![index]
                                      .name!,
                                  categoryLength: groupShoppingController
                                      .groupShoppingProduct
                                      .value
                                      .data![index]
                                      .productCategories!
                                      .length,
                                  categoryName: groupShoppingController
                                      .groupShoppingProduct
                                      .value
                                      .data![index]
                                      .productCategories!,
                                  buttonColor: AppColors.white,
                                  onPress: () {},
                                  onCartPress: () {},
                                  imgUrl: groupShoppingController
                                      .groupShoppingProduct
                                      .value
                                      .data![index]
                                      .pictures![0]
                                      .url!,
                                  buttonName: 'Create Group',
                                  backgroundColor: AppColors.addToCartButton,
                                  isDiscountAvailable: false,
                                  discount: 0,
                                  ratings: groupShoppingController
                                      .groupShoppingProduct
                                      .value
                                      .data![index]
                                      .ratings!
                                      .toDouble(),
                                  reviews: groupShoppingController
                                      .groupShoppingProduct
                                      .value
                                      .data![index]
                                      .reviews,
                                  price: groupShoppingController.groupShoppingProduct.value.data![index].price.toString(),
                                  salePrice: groupShoppingController.groupShoppingProduct.value.data![index].salePrice.toString(),
                                  isStockAvailable: true),
                        );
                      },
                    ),
                  ),
                ),
                const Gap(AppSizes.md),
                // Obx(
                //       () =>
                //       SmoothPageIndicator(
                //         controller: pageController,
                //         count: (groupShoppingController
                //             .groupShoppingProduct.value.data?.length ??
                //             0 + 1) ~/
                //             2, // Adjust the count based on two items per page
                //         effect: WormEffect(
                //           dotHeight: 8.0,
                //           dotWidth: 8.0,
                //           spacing: 8.0,
                //           activeDotColor: AppColors.primary,
                //           dotColor: AppColors.grey,
                //         ),
                //       ),
                // ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
