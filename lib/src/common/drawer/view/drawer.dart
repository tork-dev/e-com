import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/drawer/controller/drawer_controller.dart';
import 'package:kirei/src/common/drawer/view/widgets/drawer_bottom_button.dart';
import 'package:kirei/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:kirei/src/common/widgets/containers/banner_image.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/appointment/view/appointment_screen.dart';
import 'package:kirei/src/features/beauty_tips/view/beauty_tips.dart';
import 'package:kirei/src/features/blogs/view/blogs.dart';
import 'package:kirei/src/features/bottom_navigation/convex_controller.dart';
import 'package:kirei/src/features/bottom_navigation/google_nav_bar.dart';
import 'package:kirei/src/features/home/controller/home_controller.dart';
import 'package:kirei/src/features/purchase_history/view/purchace_history.dart';
import 'package:kirei/src/features/shop/controller/get_shop_data_controller.dart';
import 'package:kirei/src/features/web_view/web_view.dart';
import 'package:kirei/src/utils/constants/image_strings.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:kirei/src/utils/helpers/env_config.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';
import '../../../features/authentication/views/log_in/view/login.dart';
import '../../../features/authentication/views/sign_up/view/signup.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/auth_helper.dart';
import 'widgets/common_drawer_card.dart';

class AppDrawer extends StatelessWidget {
  final bool isFromOtherPage;

  const AppDrawer({super.key, required this.isFromOtherPage});

  @override
  Widget build(BuildContext context) {
    AppDrawerController drawerController = Get.put(AppDrawerController());
    GetShopDataController shopController = Get.put(GetShopDataController());
    ConvexBottomNavController bottomController = Get.put(
      ConvexBottomNavController(),
    );
    HomeController homeController = Get.put(HomeController());
    final String baseUrlWeb = EnvConfig.baseUrlWeb;
    return AppCardContainer(
      // padding: const EdgeInsets.only(bottom: 50),
      width: 300,
      backgroundColor: AppColors.dark,
      applyRadius: false,
      child: ListView(
        children: [
          // const AppDrawerHeaderPart(),
          AppCardContainer(
            onTap: () => AppHelperFunctions.openCaller('+8809666791110'),
            margin: EdgeInsets.symmetric(
              horizontal: AppSizes.sm,
              vertical: AppSizes.md,
            ),
            padding: EdgeInsets.all(AppSizes.md),
            hasBorder: true,
            backgroundColor: AppColors.white.withAlpha(13),
            child: Row(
              children: [
                AppBannerImage(
                  height: 48,
                  width: 48,
                  imgUrl: AppImages.phoneIcon
                ),
                Gap(AppSizes.md),
                Column(
                  children: [
                    Text(
                      "Support",
                      style: Theme.of(
                        context,
                      ).textTheme.titleSmall?.apply(color: AppColors.white),
                    ),
                    Text(
                      "+880 966679111010",
                      style: Theme.of(
                        context,
                      ).textTheme.titleLarge?.apply(color: AppColors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
          AppDrawerCard(title: 'HOME', onPress: () => Get.offAllNamed("/home")),
          AppDrawerCard(
            title: 'new arrivals'.toUpperCase(),
            onPress: () {
              shopController.resetAll();
              if (isFromOtherPage) {
                Get.to(const GoogleNavBar(pageIndex: 1));
              }
              shopController.updateCategory('new');
              shopController.type('new-arrivals');
              bottomController.jumpToTab(1);

              if (bottomController.pageIndex.value == 1) {
                Get.back();
              }
            },
          ),
          Obx(() {
            return AppListViewLayout(
              itemCount: drawerController.allNewCategories.length,
              applyPadding: false,
              builderFunction:
                  (BuildContext context, int index) =>
                      drawerController
                              .allNewCategories[index]
                              .children!
                              .isNotEmpty
                          ? ExpansionTile(
                            collapsedShape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                              side: BorderSide.none,
                            ),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                              side: BorderSide.none,
                            ),
                            iconColor: AppColors.white,
                            collapsedIconColor: AppColors.white,
                            backgroundColor: AppColors.white.withAlpha(13),
                            title: InkWell(
                              onTap: () {
                                shopController.getValuesFromUrl(drawerController
                                    .allNewCategories[index]
                                    .url!);

                                  if(bottomController.pageIndex.value == 1){
                                    Get.back();
                                    shopController.allProducts.clear();
                                    shopController.getShopData();
                                    return;
                                  }

                                  bottomController.jumpToTab(1);
                              },
                              child: Text(
                                drawerController.allNewCategories[index].name!
                                    .toUpperCase(),
                                style: Theme.of(context).textTheme.bodyLarge!
                                    .apply(color: AppColors.light),
                              ),
                            ),
                            children:
                                drawerController.allNewCategories[index].children!.asMap().entries.map((
                                  entry,
                                ) {
                                  final category = entry.value;
                                  return category.children != null &&
                                          category.children!.isNotEmpty
                                      ? Padding(
                                        padding: const EdgeInsets.only(
                                          left: AppSizes.sm,
                                        ),
                                        child: ExpansionTile(
                                          backgroundColor: AppColors.white
                                              .withAlpha((0.09 * 255).toInt()),
                                          iconColor: AppColors.white,
                                          collapsedIconColor: AppColors.white,
                                          collapsedShape:
                                              const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.zero,
                                                side: BorderSide.none,
                                              ),
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.zero,
                                            side: BorderSide.none,
                                          ),
                                          title: GestureDetector(
                                            onTap: () {
                                              shopController.getValuesFromUrl(category.url!);
                                              if(bottomController.pageIndex.value == 1){
                                                Get.back();
                                                shopController.allProducts.clear();
                                                shopController.getShopData();
                                                return;
                                              }
                                              bottomController.jumpToTab(1);
                                            },
                                            child: Text(
                                              category.counts != null
                                                  ? '${category.name!} (${category.counts})'
                                                  : '${category.name}',
                                              style: Theme.of(
                                                context,
                                              ).textTheme.bodyLarge!.apply(
                                                color: AppColors.light,
                                              ),
                                            ),
                                          ),
                                          children:
                                              category.children!.asMap().entries.map((
                                                childEntry,
                                              ) {
                                                final child = childEntry.value;
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        left: 16,
                                                      ),
                                                  child:
                                                      child.children!.isNotEmpty
                                                          ? ExpansionTile(
                                                            backgroundColor:
                                                                AppColors.white
                                                                    .withAlpha(
                                                                      26,
                                                                    ),
                                                            iconColor:
                                                                AppColors.white,
                                                            collapsedIconColor:
                                                                AppColors.white,
                                                            collapsedShape:
                                                                const RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .zero,
                                                                  side:
                                                                      BorderSide
                                                                          .none,
                                                                ),
                                                            shape:
                                                                const RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .zero,
                                                                  side:
                                                                      BorderSide
                                                                          .none,
                                                                ),
                                                            title: Text(
                                                              child.name!,
                                                              style: Theme.of(
                                                                    context,
                                                                  )
                                                                  .textTheme
                                                                  .bodyLarge!
                                                                  .apply(
                                                                    color:
                                                                        AppColors
                                                                            .light,
                                                                  ),
                                                            ),
                                                            children:
                                                                child.children!.asMap().entries.map((
                                                                  children,
                                                                ) {
                                                                  final childValue =
                                                                      children
                                                                          .value;
                                                                  return Padding(
                                                                    padding:
                                                                        const EdgeInsets.only(
                                                                          left:
                                                                              16,
                                                                        ),
                                                                    child: AppDrawerCard(
                                                                      onPress: () {
                                                                              shopController.getValuesFromUrl(childValue.url!);
                                                                              if(bottomController.pageIndex.value == 1){
                                                                                Get.back();
                                                                                shopController.allProducts.clear();
                                                                                shopController.getShopData();
                                                                                return;
                                                                              }
                                                                              bottomController.jumpToTab(1);
                                                                      },
                                                                      title:
                                                                          childValue.counts !=
                                                                                  null
                                                                              ? '${childValue.name!} (${childValue.counts})'
                                                                              : '${childValue.name}',
                                                                    ),
                                                                  );
                                                                }).toList(),
                                                          )
                                                          : AppDrawerCard(
                                                            onPress: () {
                                                              WidgetsBinding
                                                                  .instance
                                                                  .addPostFrameCallback((
                                                                    _,
                                                                  ) {
                                                                shopController.getValuesFromUrl(child.url!);
                                                                if(bottomController.pageIndex.value == 1){
                                                                  Get.back();
                                                                  shopController.allProducts.clear();
                                                                  shopController.getShopData();
                                                                  return;
                                                                }
                                                                bottomController.jumpToTab(1);
                                                                  });
                                                            },
                                                            title:
                                                                child.counts !=
                                                                        null
                                                                    ? "${child.name} (${child.counts})"
                                                                    : "${child.name}",
                                                          ),
                                                );
                                              }).toList(),
                                        ),
                                      )
                                      : Padding(
                                        padding: const EdgeInsets.only(
                                          left: 8.0,
                                        ),
                                        child: AppDrawerCard(
                                          title: category.name!,
                                          onPress: () {
                                            WidgetsBinding.instance
                                                .addPostFrameCallback((_) {
                                                  shopController.getValuesFromUrl(category.url!);
                                                  if(bottomController.pageIndex.value == 1){
                                                    Get.back();
                                                    shopController.allProducts.clear();
                                                    shopController.getShopData();
                                                    return;
                                                  }
                                                  bottomController.jumpToTab(1);
                                                });
                                          },
                                        ),
                                      );
                                }).toList(),
                          )
                          : AppDrawerCard(
                            title:
                                drawerController.allNewCategories[index].name!
                                    .toUpperCase(),
                            onPress: () {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                shopController.getValuesFromUrl(drawerController.allNewCategories[index].url!);
                                if(bottomController.pageIndex.value == 1){
                                  Get.back();
                                  shopController.allProducts.clear();
                                  shopController.getShopData();
                                  return;
                                }
                                bottomController.jumpToTab(1);
                              });
                            },
                          ),
            );
          }),
          Visibility(
            visible:
                homeController
                    .homeProductResponse
                    .value
                    .homepageSettings
                    ?.features
                    ?.groupShopping ??
                false,
            child: AppDrawerCard(
              title: 'Group shopping'.toUpperCase(),
              onPress: () => Get.toNamed('/group-shopping'),
            ),
          ),
          AppDrawerCard(
            title: 'Kip membership'.toUpperCase(),
            titleColor: const Color(0xffFFAC00),
            onPress: () => Get.toNamed('/reward-details'),
          ),
          AppDrawerCard(
            title: 'beauty tips'.toUpperCase(),
            onPress: () => Get.offAll(() => const BeautyTipsScreen()),
          ),
          AppDrawerCard(
            title: 'kirei community'.toUpperCase(),
            onPress: () => Get.toNamed("/community"),
          ),
          AppDrawerCard(
            title: 'dr. appointment'.toUpperCase(),
            onPress: () => Get.offAll(() => const AppointmentScreen()),
          ),
          AppDrawerCard(
            title: 'blog'.toUpperCase(),
            onPress: () {
              Get.back();
              Get.to(() => Blogs());
            },
          ),
          ExpansionTile(
            collapsedShape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
              side: BorderSide.none,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
              side: BorderSide.none,
            ),
            iconColor: AppColors.white,
            collapsedIconColor: AppColors.white,
            backgroundColor: AppColors.white.withAlpha(13),
            title: Row(
              children: [
                Text(
                  "kirei".toUpperCase(),
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge!.apply(color: AppColors.light),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                Stack(
                  children: [
                    Transform.rotate(
                      angle: pi / 5,
                      child: Container(
                        margin: const EdgeInsets.only(top: 3),
                        height: 15,
                        width: 15,
                        decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: AppColors.preorder,
                        ),
                      ),
                    ),
                    Container(
                      height: 22,
                      width: 45,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.preorder,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: const Text(
                        "INFO",
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            children: [
              AppDrawerCard(
                title: 'who we are?'.capitalize!,
                onPress: () {
                  Get.to(
                    () => WebViewScreen(
                      url: '$baseUrlWeb/about-us?app=true',
                      title: 'Who We Are?',
                    ),
                  );
                },
              ),
              AppDrawerCard(
                title: 'faqs'.capitalize!,
                onPress: () {
                  Get.to(
                    () => WebViewScreen(
                      url: '$baseUrlWeb/faq?app=true',
                      title: 'FAQs',
                    ),
                  );
                },
              ),
              AppDrawerCard(
                title: 'contact us'.capitalize!,
                onPress: () {
                  Get.to(
                    () => WebViewScreen(
                      url: '$baseUrlWeb/contact?app=true',
                      title: 'Contact us',
                    ),
                  );
                },
              ),
              AppDrawerCard(
                title: 'testimonials'.capitalize!,
                onPress: () {
                  Get.to(
                    () => WebViewScreen(
                      url: '$baseUrlWeb/testimonials?app=true',
                      title: 'Testimonials',
                    ),
                  );
                },
              ),
              AppDrawerCard(
                title: 'privacy & policy'.capitalize!,
                onPress: () {
                  Get.to(
                    () => WebViewScreen(
                      url: '$baseUrlWeb/privacy-policy?app=true',
                      title: 'Privacy & Policy',
                    ),
                  );
                },
              ),
              AppDrawerCard(
                title: 'terms & condition'.capitalize!,
                onPress: () {
                  Get.to(
                    () => WebViewScreen(
                      url: '$baseUrlWeb/term-condition?app=true',
                      title: 'Terms & Conditions',
                    ),
                  );
                },
              ),
              AppDrawerCard(
                title: 'returns & refunds'.capitalize!,
                onPress: () {
                  Get.to(
                    () => WebViewScreen(
                      url: '$baseUrlWeb/return-refund?app=true',
                      title: 'Returns & Refunds',
                    ),
                  );
                },
              ),
              AppDrawerCard(
                title: 'responsibility disclosure'.capitalize!,
                onPress: () {
                  Get.to(
                    () => WebViewScreen(
                      url: '$baseUrlWeb/responsible-disclosure?app=true',
                      title: 'Responsible Disclosure',
                    ),
                  );
                },
              ),
            ],
          ),
          Visibility(
            visible:
                AppLocalStorage().readData(LocalStorageKeys.isLoggedIn) == true,
            child: Column(
              children: [
                AppDrawerCard(
                  title: 'profile'.toUpperCase(),
                  onPress: () => bottomController.jumpToTab(3),
                ),
                AppDrawerCard(
                  title: 'orders'.toUpperCase(),
                  onPress: () => Get.to(() => const PurchaseHistory()),
                ),
                AppDrawerCard(
                  title: 'logout'.toUpperCase(),
                  onPress: () {
                    AuthHelper().clearUserData();
                    Get.offAllNamed("/home");
                  },
                ),
              ],
            ),
          ),
          Visibility(
            visible:
                AppLocalStorage().readData(LocalStorageKeys.isLoggedIn) != true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppDrawerCard(
                  title: 'Login'.toUpperCase(),
                  onPress: () => Get.to(const LogIn()),
                ),
                AppDrawerCard(
                  title: 'Register'.toUpperCase(),
                  onPress: () => Get.to(const SignUp()),
                ),
              ],
            ),
          ),
          const Gap(AppSizes.defaultSpace),
          const AppDrawerBottomButton(),
          const Gap(AppSizes.defaultSpace),

        ],
      ),
    );
  }
}
