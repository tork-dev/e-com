import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:kirei/src/common/layouts/layout_with_drawer/layout_with_drawer.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/bottom_navigation/convex_controller.dart';
import 'package:kirei/src/features/my_coupons/view/my_coupons_screen.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';

import '../../../utils/helpers/auth_helper.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../cart/services/cart_services.dart';
import '../../de_active_account/view/de_active_account.dart';
import '../../home/views/widgets/home_appbar_title.dart';
import '../../notification/view/notification_screen.dart';
import '../../purchase_history/view/purchace_history.dart';
import '../../reward_point/view/reward_screen.dart';
import '../../verify_product/view/product_verify_screen.dart';
import '../../wishlist/view/wishlist.dart';
import '../controller/user_controller.dart';
import 'account_details.dart';
import 'widget/dashboard_card.dart';

class UserDashboard extends StatelessWidget {
  const UserDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(UserController());
    ConvexBottomNavController bottomController = ConvexBottomNavController.instance;
    return AppLayoutWithDrawer(
      globalKey: profileController.profileKey,
      backgroundColor: AppColors.white,
      leadingIconColor: AppColors.darkerGrey,
      hasEndDrawer: true,
      action: [SizedBox()],
      title: AppHomeAppBarTitle(
        globalKey: profileController.profileKey,
      ),
      body: SingleChildScrollView(
        child: AppCardContainer(
          margin: EdgeInsets.symmetric(vertical: AppSizes.defaultSpace),
          backgroundColor: AppColors.contentInversePrimary.withAlpha(90),
          padding: EdgeInsets.all(AppSizes.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dashboard',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Gap(AppSizes.sm),
              Divider(),
              Gap(AppSizes.sm),
              AppCardContainer(
                hasBorder: true,
                width: double.infinity,
                borderColor: AppColors.primary,
                backgroundColor: AppColors.primary.withAlpha(25),
                padding: EdgeInsets.all(AppSizes.md),
                child: Text(
                  "Hello, \n${AppLocalStorage().readData(LocalStorageKeys.userName)}",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.darkerGrey,
                  ),
                ),
              ),
              Gap(AppSizes.spaceBtwItems),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: DashboardCard(
                          icon: HugeIcons.strokeRoundedProductLoading,
                          label: 'My Orders',
                          onTap: () => Get.to(() => const PurchaseHistory()),
                        ),
                      ),
                      Expanded(
                        child: DashboardCard(
                          icon: HugeIcons.strokeRoundedUserAccount,
                          label: 'Account Details',
                          onTap:
                              () => Get.to(() => const AccountDetailsScreen()),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: DashboardCard(
                          icon: HugeIcons.strokeRoundedSecurityCheck,
                          label: 'Verify Product',
                          onTap:
                              () => Get.to(() => const ProductVerifyScreen()),
                        ),
                      ),
                      Expanded(
                        child: DashboardCard(
                          icon: HugeIcons.strokeRoundedFavourite,
                          label: 'My WishList',
                          onTap: () => Get.to(() => const WishlistScreen()),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: DashboardCard(
                          icon: HugeIcons.strokeRoundedGift,
                          label: 'My Rewards',
                          onTap: () => Get.to(() => const RewardScreen()),
                        ),
                      ),
                      Expanded(
                        child: DashboardCard(
                          icon: HugeIcons.strokeRoundedCoupon02,
                          label: 'My Coupons',
                          onTap: () => Get.to(() => const MyCouponsScreen()),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: DashboardCard(
                          icon: HugeIcons.strokeRoundedNotification01,
                          label: 'Notification',
                          onTap: () => Get.to(() => const NotificationScreen()),
                        ),
                      ),
                      Expanded(
                        child: DashboardCard(
                          icon: HugeIcons.strokeRoundedDelete03,
                          label: 'Delete Account',
                          onTap: () => Get.to(() => const DeActiveAccount()),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Gap(AppSizes.spaceBtwSections),
              AppCardContainer(
                onTap: () {
                  AppHelperFunctions.showAlert(
                    message: 'Are you sure you want to logout?',
                    leftButtonName: 'Yes',
                    rightButtonName: 'No',
                    onRightPress: Get.back,
                    onLeftPress: () {
                      AuthHelper().clearUserData();
                      CartService.clearCart();
                      Get.offAllNamed("/home");
                    },
                    rightButtonTextColor: AppColors.secondary,
                    rightButtonColor: Colors.transparent,
                  );
                },
                backgroundColor: AppColors.white,
                padding: EdgeInsets.symmetric(
                  vertical: AppSizes.md,
                  horizontal: AppSizes.md,
                ),
                child: Row(
                  children: [
                    HugeIcon(icon: HugeIcons.strokeRoundedLogoutCircle02),
                    Gap(AppSizes.sm),
                    Text(
                      'Logout',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
