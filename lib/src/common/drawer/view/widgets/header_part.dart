import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import '../../../../features/personalization/view/account_details.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/local_storage/local_storage_keys.dart';
import '../../../../utils/local_storage/storage_utility.dart';


class AppDrawerHeaderPart extends StatelessWidget {
  const AppDrawerHeaderPart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userImage =
        AppLocalStorage().readData(LocalStorageKeys.avatarOriginal);
    final userName = AppLocalStorage().readData(LocalStorageKeys.userName);
    final userPhone = AppLocalStorage().readData(LocalStorageKeys.userEmail);
    return Column(
      children: [
        AppLocalStorage().readData(LocalStorageKeys.isLoggedIn) == true
            ? Column(
                children: [
                  ListTile(
                      onTap: () => Get.to(() => const AccountDetailsScreen()),
                      leading: CircleAvatar(
                        backgroundImage: userImage != null
                            ? NetworkImage(userImage) as ImageProvider
                            : const AssetImage(AppImages.profileIcon)
                                as ImageProvider,
                      ),
                      title: Text(
                        userName,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .apply(color: AppColors.white),
                      ),
                      subtitle: Text(
                        userPhone,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .apply(color: AppColors.light.withAlpha(230)),
                      )),
                  const Gap(AppSizes.xs),
                  Container(
                    width: AppHelperFunctions.screenWidth() * 1,
                    color: AppColors.darkGrey,
                    height: .5,
                  ),
                ],
              )
            : Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                InkWell(
                  onTap: () => Get.back(),
                  child: const Icon(
                    Icons.clear,
                    color: AppColors.white,
                  ),
                ),
                const Gap(AppSizes.sm)
              ]),
      ],
    );
  }
}
