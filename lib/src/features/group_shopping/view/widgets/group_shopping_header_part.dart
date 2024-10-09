import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/styles/app_dividers.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/common/widgets/texts/section_title_text.dart';
import 'package:kirei/src/features/group_shopping/view/widgets/group_checkout_alert.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../common/widgets/buttons/app_buttons.dart';
import '../../../../common/widgets/containers/banner_image.dart';

import '../../../../common/widgets/containers/course_title_container.dart';
import '../../../../common/widgets/containers/product_image.dart';
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
                            height: 320,
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
                                        child: AppCardContainer(
                                          padding:
                                              const EdgeInsets.all(AppSizes.sm),
                                          backgroundColor: AppColors.white,
                                          applyRadius: false,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Stack(
                                                children: [
                                                  AppBannerImage(
                                                    height: 150,
                                                    imgUrl: product
                                                        .pictures![0].url!,
                                                    isNetworkImage: true,
                                                    applyImageRadius: false,
                                                  ),
                                                  AppCardContainer(
                                                      applyRadius: false,
                                                      backgroundColor:
                                                          const Color(
                                                              0xffE4F7E8),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              AppSizes.xs),
                                                      child: RichText(
                                                        text: TextSpan(
                                                            text: 'Required: ',
                                                            style: const TextStyle(
                                                                fontSize: 8,
                                                                color: AppColors
                                                                    .secondary),
                                                            children: [
                                                              TextSpan(
                                                                  text:
                                                                      '${product.groupMemberQuantity} Members',
                                                                  style: const TextStyle(
                                                                      color: AppColors
                                                                          .primary,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold))
                                                            ]),
                                                      ))
                                                ],
                                              ),
                                              AppButtons.largeFlatFilledButton(
                                                  onPressed: () {
                                                    print(product.groupToken);
                                                    product.groupToken ==
                                                            null
                                                        ? showDialog(
                                                            context: context,
                                                            builder:
                                                                (context) =>
                                                                    Dialog(
                                                                      backgroundColor:
                                                                          AppColors
                                                                              .white,
                                                                      shape:
                                                                          const RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.zero,
                                                                      ),
                                                                      insetPadding: const EdgeInsets
                                                                          .all(
                                                                          AppSizes
                                                                              .md),
                                                                      child:
                                                                          Stack(
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(AppSizes.md),
                                                                            child:
                                                                                ListView(
                                                                              children: [
                                                                                const AppSectionTitleText(
                                                                                  sectionTitle: 'Create Group',
                                                                                  haveTxtButton: false,
                                                                                ),
                                                                                const Gap(AppSizes.spaceBtwDefaultItems),
                                                                                GroupCheckoutAlert(
                                                                                  buttonName: 'Create group',
                                                                                  buttonWork: () {
                                                                                    groupShoppingController.createGroup(groupShoppingController.groupShoppingProduct.value.data![index].id);
                                                                                  },
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Positioned(
                                                                              right: 10,
                                                                              top: 10,
                                                                              child: AppCardContainer(onTap: () => Get.back(), height: 44, width: 44, backgroundColor: AppColors.white, applyRadius: false, child: const Icon(Icons.clear)))
                                                                        ],
                                                                      ),
                                                                    ))
                                                        : showDialog(
                                                      context: context,
                                                      builder: (BuildContext context) {
                                                        return Dialog(
                                                          shape: const RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.zero,
                                                          ),
                                                          child: AppCardContainer(
                                                            padding: const EdgeInsets.all(20),
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              mainAxisSize: MainAxisSize.min,
                                                              children:[
                                                                const Text(
                                                                  "This product has already a group",
                                                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                                                  textAlign: TextAlign.center,
                                                                ),
                                                                const SizedBox(height: 10),
                                                                const Text(
                                                                  "Please join here",
                                                                  style: TextStyle(fontSize: 16),
                                                                  textAlign: TextAlign.center,
                                                                ),
                                                                const SizedBox(height: 20),
                                                                AppButtons.largeFlatFilledButton(
                                                                    onPressed: (){
                                                                      Get.toNamed(
                                                                          '/group-shopping/${product.groupToken}',
                                                                          parameters: {
                                                                            'productId':
                                                                            "${product.id}"
                                                                          });
                                                                    },
                                                                    backgroundColor: AppColors.secondary,
                                                                    buttonText: 'JOIN NOW')
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                  buttonText: 'Create Group',
                                                  verticallyPadding:
                                                      AppSizes.sm,
                                                  backgroundColor: AppColors
                                                      .addToCartButton),
                                              Text(
                                                product.name ?? '',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const Gap(AppSizes.sm),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  RatingBar(
                                                    itemSize: 12.0,
                                                    ignoreGestures: true,
                                                    initialRating: product
                                                        .ratings!
                                                        .toDouble(),
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: false,
                                                    itemCount: 5,
                                                    ratingWidget: RatingWidget(
                                                      full: const Icon(
                                                          Icons.star,
                                                          color: Color.fromRGBO(
                                                              192, 53, 50, 1)),
                                                      empty: const Icon(
                                                          Icons.star,
                                                          color: Color.fromRGBO(
                                                              224,
                                                              224,
                                                              225,
                                                              1)),
                                                      half: const Icon(
                                                          Icons.star,
                                                          color: Color.fromRGBO(
                                                              192, 53, 50, 1)),
                                                    ),
                                                    itemPadding:
                                                        const EdgeInsets.only(
                                                            right: 1.0),
                                                    onRatingUpdate: (rating) {
                                                      //print(rating);
                                                    },
                                                  ),
                                                  Text(
                                                    '(${product.reviews})',
                                                    textAlign: TextAlign.left,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: const TextStyle(
                                                        color:
                                                            AppColors.primary,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Visibility(
                                                    visible:
                                                        product.salePrice !=
                                                            product.price,
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          "৳${product.price}",
                                                          textAlign:
                                                              TextAlign.left,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                          style: const TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                              color: AppColors
                                                                  .darkGrey,
                                                              fontSize: 9,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        const Gap(AppSizes.sm)
                                                      ],
                                                    ),
                                                  ),
                                                  Text(
                                                    "৳${product.salePrice}",
                                                    textAlign: TextAlign.left,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: const TextStyle(
                                                        color:
                                                            AppColors.primary,
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                              const Gap(AppSizes.sm),
                                              AppDividersStyle
                                                  .fullFlatAppDivider,
                                              const Gap(AppSizes.sm),
                                              RichText(
                                                text: TextSpan(
                                                    text: 'Duration: ',
                                                    style: const TextStyle(
                                                        fontSize: 8,
                                                        color: AppColors
                                                            .secondary),
                                                    children: [
                                                      TextSpan(
                                                          text:
                                                              '${groupShoppingController.groupShoppingProduct.value.data![index].groupDuration} Days ',
                                                          style: const TextStyle(
                                                              color: AppColors
                                                                  .primary,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))
                                                    ]),
                                              )
                                            ],
                                          ),
                                        ));
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
