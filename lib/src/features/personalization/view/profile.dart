import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/layout_with_drawer/layout_with_drawer.dart';
import 'package:kirei/src/common/layouts/layout_with_refresher/layout_with_refresher.dart';
import 'package:kirei/src/common/styles/app_dividers.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/personalization/view/widget/log_out_button.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import '../../../l10n/app_localizations.dart';
import '../controller/user_controller.dart';
import 'widget/details_part.dart';
import 'widget/picture_part.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(UserController());

    // final authController = Get.put(AuthRepositories());
    return AppLayoutWithDrawer(
        globalKey: profileController.profileKey,
        backToHome: true,
        inHome: true,
        title: Text(
          AppLocalizations.of(context)!.profile,
          style: const TextStyle(color: AppColors.white),
        ),
        centerTitle: true,
        padding: 0,
        body: AppLayoutWithRefresher(
            onRefresh: profileController.onRefresh,
            children: [
              const PicturePart(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    AppDividersStyle.fullFlatAppDivider,
                    const Gap(AppSizes.spaceBtwDefaultItems),
                    const AppCardContainer(
                        width: 200,
                        child: DetailsCardPart()),
                    const Gap(AppSizes.spaceBtwDefaultItems),
                    AppDividersStyle.fullFlatAppDivider,
                    const Gap(AppSizes.spaceBtwSections),
                    const ProfileLogOutButton()
                  ],
                ),
              )
            ]));
  }
}
