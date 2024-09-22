import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/drawer/controller/drawer_controller.dart';
import 'package:kirei/src/common/drawer/view/widgets/drawer_bottom_button.dart';
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
    return AppCardContainer(
      margin: const EdgeInsets.only(bottom: 50),
      width: 300,
      backgroundColor: AppColors.dark,
      applyRadius: false,
      child: ListView(
        children: [
          InkWell(
              onTap: () => Get.to(() => const AccountDetailsScreen()),
              child: const AppDrawerHeaderPart()),
          AppDrawerCard(
            title: 'HOME',
            onPress: () => Get.offAll(() => const HelloConvexAppBar()),
          ),
          AppDrawerCard(
            title: 'new arrivals',
            onPress: () {
              if (isFromOtherPage) {
                Get.to(const HelloConvexAppBar(
                  pageIndex: 1,
                ));
              }
              shopController.updateCategory('new');
              shopController.getShopData();
              bottomController.jumpToTab(1);
            },
          ),
          Obx(() {
            return ExpansionTile(
              iconColor: AppColors.white,
              collapsedIconColor: AppColors.white,
              backgroundColor: AppColors.white.withOpacity(.05),
              title: Row(
                children: [
                  Text("Categories".toUpperCase(),
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
                            color: Colors.pinkAccent,
                          ),
                        ),
                      ),
                      Container(
                        height: 22,
                        width: 45,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.pinkAccent,
                            borderRadius: BorderRadius.circular(2)),
                        child: const Text(
                          "New!",
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
              children:
                  drawerController.allCategories.asMap().entries.map((entry) {
                final category = entry.value;
                final index = entry.key;
                return category.children != null &&
                        category.children!.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: ExpansionTile(
                          backgroundColor: AppColors.white.withOpacity(.09),
                          iconColor: AppColors.white,
                          collapsedIconColor: AppColors.white,
                          title: GestureDetector(
                              onTap: () {
                                shopController.resetAll();
                                if (isFromOtherPage) {
                                  Get.to(() => const HelloConvexAppBar(
                                        pageIndex: 1,
                                      ));
                                }
                                shopController.updateCategory(category.slug!);
                                shopController.getShopData();
                                bottomController.jumpToTab(1);
                              },
                              child: Text(
                                category.name!,
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
                            final childIndex = childEntry.key;
                            return Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: child.children!.isNotEmpty
                                  ? ExpansionTile(
                                backgroundColor: AppColors.white.withOpacity(.1),
                                      iconColor: AppColors.white,
                                      collapsedIconColor: AppColors.white,
                                      title: Text(child.name!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .apply(color: AppColors.light)),
                                      children: child.children!.map((children) {
                                        return Padding(
                                            padding:
                                                const EdgeInsets.only(left: 16),
                                            child: AppDrawerCard(
                                              onPress: () {
                                                if (child.name ==
                                                    'By Category') {
                                                  shopController.updateCategory(
                                                      children.slug ?? '');
                                                } else if (child.name ==
                                                    'By Skin Concern') {
                                                  shopController.goodFor.value =
                                                      children.slug ?? '';
                                                } else {
                                                  shopController
                                                          .skinType.value =
                                                      children.slug ?? '';
                                                }
                                                shopController.getShopData();
                                                bottomController.jumpToTab(1);
                                              },
                                              title: children.name ?? '',
                                            ));
                                      }).toList(),
                                    )
                                  : AppDrawerCard(
                                      onPress: () {
                                        shopController.resetAll();
                                        if (isFromOtherPage) {
                                          Get.to(() => const HelloConvexAppBar(
                                                pageIndex: 1,
                                              ));
                                        }
                                        shopController
                                            .updateCategory(category.slug!);
                                        shopController.getShopData();
                                        bottomController.jumpToTab(1);
                                      },
                                      title: child.name ?? '',
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
                            shopController.updateCategory(category.slug!);
                            shopController.getShopData();
                            bottomController.jumpToTab(1);
                          },
                        ),
                      );
              }).toList(),
            );
          }),
          ListTile(
              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
              title: Row(
                children: [
                  Text('BRANDS',
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
                            color: Colors.pinkAccent,
                          ),
                        ),
                      ),
                      Container(
                        height: 22,
                        width: 45,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.pinkAccent,
                            borderRadius: BorderRadius.circular(2)),
                        child: const Text(
                          "Top!",
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
              onTap: () {
                Get.to(() => const WebViewScreen(
                    title: 'Brands',
                    url: "https://kireibd.com/brands?type=app"));
              }),
          AppDrawerCard(
            title: 'beauty tips',
            onPress: () => Get.offAll(() => const BeautyTipsScreen()),
          ),
          AppDrawerCard(
              title: 'AI Suggestion',
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
            title: 'kirei community',
            onPress: () => Get.offAll(() => const CommunityScreen()),
          ),
          AppDrawerCard(
            title: 'dr. appointment',
            onPress: () => Get.offAll(() => const AppointmentScreen()),
          ),
          AppDrawerCard(
            title: 'blog',
            onPress: () {
              Get.to(() => const WebViewScreen(
                  url: "https://kireibd.com/blogs?type=app", title: 'Blogs'));
            },
          ),
          ExpansionTile(
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
                  title: 'who we are?',
                  onPress: () {
                    Get.to(() => const WebViewScreen(
                        url: 'https://kireibd.com/about-us?type=app',
                        title: 'Who We Are?'));
                  },
                ),
                AppDrawerCard(
                  title: 'faqs',
                  onPress: () {
                    Get.to(() => const WebViewScreen(
                        url: 'https://kireibd.com/faq?type=app',
                        title: 'FAQs'));
                  },
                ),
                AppDrawerCard(
                  title: 'contact us',
                  onPress: () {
                    Get.to(() => const WebViewScreen(
                        url: 'https://kireibd.com/contact-us?type=app',
                        title: 'Contact us'));
                  },
                ),
                AppDrawerCard(
                  title: 'testimonials',
                  onPress: () {
                    Get.to(() => const WebViewScreen(
                        url: 'https://kireibd.com/testimonial?type=app',
                        title: 'Testimonials'));
                  },
                ),
                AppDrawerCard(
                  title: 'privacy & policy',
                  onPress: () {
                    Get.to(() => const WebViewScreen(
                        url: 'https://kireibd.com/privacy-policy?type=app',
                        title: 'Privacy & Policy'));
                  },
                ),
                AppDrawerCard(
                  title: 'terms & condition',
                  onPress: () {
                    Get.to(() => const WebViewScreen(
                        url: 'https://kireibd.com/term-condition?type=app',
                        title: 'Terms & Conditions'));
                  },
                ),
                AppDrawerCard(
                  title: 'returns & refunds',
                  onPress: () {
                    Get.to(() => const WebViewScreen(
                        url: 'https://kireibd.com/return-refund?type=app',
                        title: 'Returns & Refunds'));
                  },
                ),
                AppDrawerCard(
                  title: 'responsibility disclosure',
                  onPress: () {
                    Get.to(() => const WebViewScreen(
                        url:
                            'https://kireibd.com/responsible-disclosure?type=app',
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
                    title: 'profile',
                    onPress: () => bottomController.jumpToTab(3),
                  ),
                  AppDrawerCard(
                    title: 'orders',
                    onPress: () => Get.to(() => const PurchaseHistory()),
                  ),
                  AppDrawerCard(
                      title: 'logout',
                      onPress: () {
                        AuthHelper().clearUserData();
                        Get.offAll(() => const HelloConvexAppBar());
                      }),
                  AppDrawerCard(
                    title: 'influencer store',
                    onPress: () => Get.offAll(() => const InfluencerStore()),
                  ),
                ],
              )),
          const Gap(AppSizes.xs),
          AppDividersStyle.fullFlatAppDivider,
          const Gap(AppSizes.xs),
          const AppDrawerBottomButton()
        ],
      ),
    );
  }
}
