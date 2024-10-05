import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/common/widgets/texts/section_title_text.dart';
import 'package:kirei/src/features/group_shopping/view/widgets/group_checkout_alert.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../common/widgets/buttons/app_buttons.dart';
import '../../../../common/widgets/containers/banner_image.dart';

import '../../../../common/widgets/containers/vertical_product_card.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../controller/group_shopping_controller.dart';

class GroupShoppingHeaderPart extends StatelessWidget {
  const GroupShoppingHeaderPart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final groupShoppingController = GroupShoppingController.instance;
    final PageController pageController = PageController(viewportFraction: 1);

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
                const Gap(AppSizes.md),
                SizedBox(
                  width: 125,
                  child: AppButtons.largeFlatFilledButton(
                      verticallyPadding: AppSizes.sm,
                      onPressed: () {
                        groupShoppingController.scrollToBottom();
                      },
                      backgroundColor: AppColors.secondary,
                      buttonText: 'JOIN TODAY'),
                ),
                const Gap(AppSizes.md),
                Obx(
                  () {
                    final products = groupShoppingController
                            .groupShoppingProduct.value.data ??
                        [];
                    final pageCount = (products.length / 2).ceil();

                    return groupShoppingController.hittingApi.value
                        ? ShimmerHelper().buildBasicShimmer(
                            height: 300,
                          )
                        : SizedBox(
                            height: 300,
                            width: AppHelperFunctions.screenWidth(),
                            child: PageView.builder(
                              controller: pageController,
                              itemCount: pageCount,
                              itemBuilder: (context, pageIndex) {
                                final startIndex = pageIndex * 2;
                                final endIndex = startIndex + 2;

                                // Take the products for the current page, max 2
                                final pageProducts = products.sublist(
                                  startIndex,
                                  endIndex > products.length
                                      ? products.length
                                      : endIndex,
                                );

                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: List.generate(pageProducts.length,
                                      (index) {
                                    final product = pageProducts[index];
                                    return SizedBox(
                                      width: 170,
                                      child: AppVerticalProductCard(
                                        height: 290,
                                        width: 170,
                                        imgWidth: 170,
                                        imgHeight: 150,
                                        padding:
                                            const EdgeInsets.all(AppSizes.sm),
                                        onTap: () {
                                          Get.toNamed(
                                              '/product/${product.slug}');
                                        },
                                        onCartTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) => Dialog(
                                                    backgroundColor:
                                                        AppColors.white,
                                                    shape:
                                                        const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.zero,
                                                    ),
                                                    insetPadding:
                                                        const EdgeInsets.all(
                                                            AppSizes.md),
                                                    child: Stack(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(
                                                                  AppSizes.md),
                                                          child: ListView(
                                                            children: [
                                                              const AppSectionTitleText(
                                                                sectionTitle:
                                                                    'Create Group',
                                                                haveTxtButton:
                                                                    false,
                                                              ),
                                                              const Gap(AppSizes
                                                                  .spaceBtwDefaultItems),
                                                              GroupCheckoutAlert(
                                                                buttonName:
                                                                    'Create group',
                                                                buttonWork: () {
                                                                  groupShoppingController.createGroup(
                                                                      groupShoppingController
                                                                          .groupShoppingProduct
                                                                          .value
                                                                          .data![
                                                                              index]
                                                                          .id);
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Positioned(
                                                            right: 10,
                                                            top: 10,
                                                            child: AppCardContainer(
                                                                onTap: () =>
                                                                    Get.back(),
                                                                height: 44,
                                                                width: 44,
                                                                backgroundColor:
                                                                    AppColors
                                                                        .white,
                                                                applyRadius:
                                                                    false,
                                                                child: const Icon(
                                                                    Icons
                                                                        .clear)))
                                                      ],
                                                    ),
                                                  ));
                                        },
                                        buttonColor: AppColors.white,
                                        imgUrl: product.pictures![0].url!,
                                        buttonName: 'Create Group',
                                        backgroundColor:
                                            AppColors.addToCartButton,
                                        isDiscountAvailable: false,
                                        discount: 0,
                                        isStockAvailable: false,
                                        productName: product.name!,
                                        price: product.price!,
                                        salePrice: product.salePrice!,
                                        ratings: product.ratings!.toDouble(),
                                        reviews: product.reviews!,
                                      ),
                                    );
                                  }),
                                );
                              },
                            ),
                          );
                  },
                ),
                const Gap(AppSizes.md),
                Obx(
                  () {
                    final products = groupShoppingController
                            .groupShoppingProduct.value.data ??
                        [];
                    final pageCount = (products.length / 2).ceil();

                    return groupShoppingController.hittingApi.value
                        ? ShimmerHelper().buildBasicShimmer(height: 10)
                        : SmoothPageIndicator(
                            controller: pageController,
                            count: pageCount, // Correct page count
                            effect: const WormEffect(
                              dotHeight: 8.0,
                              dotWidth: 8.0,
                              spacing: 8.0,
                              activeDotColor: AppColors.primary,
                              dotColor: AppColors.dark,
                            ),
                          );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
