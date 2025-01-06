import 'dart:math';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/drawer/controller/drawer_controller.dart';
import 'package:kirei/src/common/drawer/view/widgets/drawer_bottom_button.dart';
import 'package:kirei/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:kirei/src/common/styles/app_dividers.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/ai_recommendation/view/skin_care_history/recomedation_screen_one.dart';
import 'package:kirei/src/features/appoinment/view/appointment_screen.dart';
import 'package:kirei/src/features/beauty_tips/view/beauty_tips.dart';
import 'package:kirei/src/features/bottom_navigation/convex-bottom_navigation.dart';
import 'package:kirei/src/features/bottom_navigation/convex_controller.dart';
import 'package:kirei/src/features/community/view/community_screen.dart';
import 'package:kirei/src/features/influencer_store/view/influencer_screen.dart';
import 'package:kirei/src/features/personalization/view/account_details.dart';
import 'package:kirei/src/features/purchase_history/view/purchace_history.dart';
import 'package:kirei/src/features/shop/controller/get_shop_data_controller.dart';
import 'package:kirei/src/features/web_view/web_view.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';
import '../../../features/authentication/views/log_in/view/login.dart';
import '../../../features/authentication/views/sign_up/view/signup.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/auth_helper.dart';
import 'widgets/common_drawer_card.dart';
import 'widgets/header_part.dart';

class AppDrawer extends StatelessWidget {
  final bool isFromOtherPage;

  const AppDrawer({super.key, required this.isFromOtherPage});

  @override
  Widget build(BuildContext context) {
    final drawerController = Get.put(AppDrawerController());
    final shopController = Get.put(GetShopDataController());
    final bottomController = Get.put(ConvexBottomNavController());
    final String baseUrlWeb = dotenv.env["BASE_URL_WEB"]!;
    return AppCardContainer(
      margin: const EdgeInsets.only(bottom: 50),
      width: 300,
      backgroundColor: AppColors.dark,
      applyRadius: false,
      child: ListView(
        children: [
          const AppDrawerHeaderPart(),
          AppDrawerCard(
            title: 'HOME',
            onPress: () => Get.offAll(() => const HelloConvexAppBar()),
          ),
          AppDrawerCard(
            title: 'new arrivals'.toUpperCase(),
            onPress: () {
              shopController.resetAll();
              if (isFromOtherPage) {
                Get.to(const HelloConvexAppBar(
                  pageIndex: 1,
                ));
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
              builderFunction: (context, index) => drawerController
                      .allNewCategories[index].children!.isNotEmpty
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
                      backgroundColor: AppColors.white.withOpacity(.05),
                      title: InkWell(
                        onTap: () {
                          if(drawerController.allNewCategories[index].name!.toUpperCase() == "J-BEAUTY"){
                            return;
                          }
                          shopController.resetAll();
                          if (isFromOtherPage) {
                            Get.to(() => const HelloConvexAppBar(
                                  pageIndex: 1,
                                ));
                          }
                          shopController.updateCategory(
                              drawerController.allNewCategories[index].slug!);
                          bottomController.jumpToTab(1);
                          if (bottomController.pageIndex.value == 1) {
                            Get.back();
                          }
                        },
                        child: Text(
                            drawerController.allNewCategories[index].name!.toUpperCase() ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .apply(color: AppColors.light)),
                      ),
                      children: drawerController.allNewCategories[index].children!
                          .asMap()
                          .entries
                          .map((entry) {
                        final category = entry.value;
                        return category.children != null &&
                                category.children!.isNotEmpty
                            ? Padding(
                                padding:
                                    const EdgeInsets.only(left: AppSizes.sm),
                                child: ExpansionTile(
                                  backgroundColor:
                                      AppColors.white.withOpacity(.09),
                                  iconColor: AppColors.white,
                                  collapsedIconColor: AppColors.white,
                                  collapsedShape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                    side: BorderSide.none,
                                  ),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                    side: BorderSide.none,
                                  ),
                                  title: GestureDetector(
                                      onTap: () {
                                        shopController.resetAll();
                                        if (isFromOtherPage) {
                                          Get.to(() => const HelloConvexAppBar(
                                                pageIndex: 1,
                                              ));
                                        }
                                        shopController
                                            .updateCategory(category.slug!);
                                        bottomController.jumpToTab(1);
                                        if (bottomController.pageIndex.value ==
                                            1) {
                                          Get.back();
                                        }
                                      },
                                      child: Text(
                                        category.counts != null
                                            ? '${category.name!} (${category.counts})'
                                            : '${category.name}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .apply(color: AppColors.light),
                                      )),
                                  children: category.children!
                                      .asMap()
                                      .entries
                                      .map((childEntry) {
                                    final child = childEntry.value;
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 16),
                                      child: child.children!.isNotEmpty
                                          ? ExpansionTile(
                                              backgroundColor: AppColors.white
                                                  .withOpacity(.1),
                                              iconColor: AppColors.white,
                                              collapsedIconColor:
                                                  AppColors.white,
                                              collapsedShape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.zero,
                                                side: BorderSide.none,
                                              ),
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.zero,
                                                side: BorderSide.none,
                                              ),
                                              title: Text(child.name!,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .apply(
                                                          color:
                                                              AppColors.light)),
                                              children: child.children!
                                                  .asMap()
                                                  .entries
                                                  .map((children) {
                                                final child = children.value;
                                                return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 16),
                                                    child: AppDrawerCard(
                                                      onPress: () {
                                                        shopController
                                                            .resetAll();
                                                        if (child.name ==
                                                            'By Category') {
                                                          shopController
                                                              .updateCategory(
                                                                  child.slug ??
                                                                      '');
                                                        } else if (child.name ==
                                                            'By Skin Concern') {
                                                          shopController.goodFor
                                                                  .value =
                                                              child.slug ?? '';
                                                        } else if (child.name ==
                                                            'By Brand') {
                                                          shopController
                                                                  .brand.value =
                                                              child.slug ?? '';
                                                          print(child.slug);
                                                        } else {
                                                          shopController
                                                                  .skinType
                                                                  .value =
                                                              child.slug ?? '';
                                                        }
                                                        bottomController
                                                            .jumpToTab(1);
                                                        if (bottomController
                                                                .pageIndex
                                                                .value ==
                                                            1) {
                                                          Get.back();
                                                        }
                                                      },
                                                      title: child.counts !=
                                                              null
                                                          ? '${child.name!} (${child.counts})'
                                                          : '${child.name}',
                                                    ));
                                              }).toList(),
                                            )
                                          : AppDrawerCard(
                                              onPress: () {
                                                print('print value');
                                                shopController.resetAll();
                                                if (isFromOtherPage) {
                                                  Get.to(() =>
                                                      const HelloConvexAppBar(
                                                        pageIndex: 1,
                                                      ));
                                                }
                                                shopController.updateCategory(
                                                    child.slug!);
                                                bottomController.jumpToTab(1);
                                                if (bottomController
                                                        .pageIndex.value ==
                                                    1) {
                                                  Get.back();
                                                }
                                              },
                                              title: child.counts != null
                                                  ? "${child.name} (${child.counts})"
                                                  : "${child.name}",
                                            ),
                                    );
                                  }).toList(),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: AppDrawerCard(
                                  title: category.name!,
                                  onPress: () {
                                    shopController.resetAll();
                                    if (isFromOtherPage) {
                                      Get.to(() => const HelloConvexAppBar(
                                            pageIndex: 1,
                                          ));
                                    }
                                    shopController
                                        .updateCategory(category.slug!);
                                    bottomController.jumpToTab(1);
                                    if (bottomController.pageIndex.value == 1) {
                                      Get.back();
                                    }
                                  },
                                ),
                              );
                      }).toList(),
                    )
                  : AppDrawerCard(
                      title: drawerController.allNewCategories[index].name!.toUpperCase(),
                      onPress: () {
                        shopController.updateCategory(
                            drawerController.allNewCategories[index].slug!);
                        bottomController.jumpToTab(1);
                      }),
            );
          }),
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
              title: 'AI Suggestion'.toUpperCase(),
              onPress: () {
                if (AppLocalStorage().readData(LocalStorageKeys.isLoggedIn) ==
                    true) {
                  Get.to(() => const SkinCareHistoryOne());
                } else {
                  AppHelperFunctions.showToast('Please login first');
                  Get.toNamed('/login/personal-recommendation');
                }
              }),
          AppDrawerCard(
            title: 'kirei community'.toUpperCase(),
            onPress: () => Get.offAll(() => const CommunityScreen()),
          ),
          AppDrawerCard(
            title: 'dr. appointment'.toUpperCase(),
            onPress: () => Get.offAll(() => const AppointmentScreen()),
          ),
          AppDrawerCard(
            title: 'blog'.toUpperCase(),
            onPress: () {
              Get.to(() => WebViewScreen(
                  url: "$baseUrlWeb/blogs?type=app", title: 'Blogs'));
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
              backgroundColor: AppColors.white.withOpacity(.05),
              title: Row(
                children: [
                  Text("kirei".toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .apply(color: AppColors.light)),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
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
                            borderRadius: BorderRadius.circular(2)),
                        child: const Text(
                          "INFO",
                          style: TextStyle(
                              color: AppColors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              children: [
                AppDrawerCard(
                  title: 'who we are?'.capitalize!,
                  onPress: () {
                    Get.to(() => WebViewScreen(
                        url: '$baseUrlWeb/about-us?type=app',
                        title: 'Who We Are?'));
                  },
                ),
                AppDrawerCard(
                  title: 'faqs'.capitalize!,
                  onPress: () {
                    Get.to(() => WebViewScreen(
                        url: '$baseUrlWeb/faq?type=app', title: 'FAQs'));
                  },
                ),
                AppDrawerCard(
                  title: 'contact us'.capitalize!,
                  onPress: () {
                    Get.to(() => WebViewScreen(
                        url: '$baseUrlWeb/contact-us?type=app',
                        title: 'Contact us'));
                  },
                ),
                AppDrawerCard(
                  title: 'testimonials'.capitalize!,
                  onPress: () {
                    Get.to(() => WebViewScreen(
                        url: '$baseUrlWeb/testimonial?type=app',
                        title: 'Testimonials'));
                  },
                ),
                AppDrawerCard(
                  title: 'privacy & policy'.capitalize!,
                  onPress: () {
                    Get.to(() => WebViewScreen(
                        url: '$baseUrlWeb/privacy-policy?type=app',
                        title: 'Privacy & Policy'));
                  },
                ),
                AppDrawerCard(
                  title: 'terms & condition'.capitalize!,
                  onPress: () {
                    Get.to(() => WebViewScreen(
                        url: '$baseUrlWeb/term-condition?type=app',
                        title: 'Terms & Conditions'));
                  },
                ),
                AppDrawerCard(
                  title: 'returns & refunds'.capitalize!,
                  onPress: () {
                    Get.to(() => WebViewScreen(
                        url: '$baseUrlWeb/return-refund?type=app',
                        title: 'Returns & Refunds'));
                  },
                ),
                AppDrawerCard(
                  title: 'responsibility disclosure'.capitalize!,
                  onPress: () {
                    Get.to(() => WebViewScreen(
                        url: '$baseUrlWeb/responsible-disclosure?type=app',
                        title: 'Responsible Disclosure'));
                  },
                ),
              ]),
          Visibility(
              visible:
                  AppLocalStorage().readData(LocalStorageKeys.isLoggedIn) ==
                      true,
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
                        Get.offAll(() => const HelloConvexAppBar());
                      }),
                  // AppDrawerCard(
                  //   title: 'influencer store'.toUpperCase(),
                  //   onPress: () => Get.offAll(() => const InfluencerStore()),
                  // ),
                ],
              )),
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
          const AppDrawerBottomButton()
        ],
      ),
    );
  }
}
