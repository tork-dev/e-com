import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kirei/src/common/layouts/layout_with_drawer/layout_with_drawer.dart';
import 'package:kirei/src/common/layouts/layout_with_refresher/layout_with_refresher.dart';
import 'package:kirei/src/common/styles/app_dividers.dart';
import 'package:kirei/src/common/styles/spacing_style.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/authentication/data/repositories/auth_repositories.dart';
import 'package:kirei/src/features/details/controller/details_page_controller.dart';
import 'package:kirei/src/features/personalization/controller/account_details_controller.dart';
import 'package:kirei/src/features/personalization/view/widget/log_out_button.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/image_strings.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../controller/user_controller.dart';
import 'widget/details_card.dart';
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
                    const Gap(AppSizes.spaceBtwItems),
                    const AppCardContainer(
                        width: 200,
                        child: DetailsCardPart()),
                    const Gap(AppSizes.spaceBtwItems),
                    AppDividersStyle.fullFlatAppDivider,
                    const Gap(AppSizes.spaceBtwSections),
                    const ProfileLogOutButton()
                  ],
                ),
              )
            ]));
  }
}
