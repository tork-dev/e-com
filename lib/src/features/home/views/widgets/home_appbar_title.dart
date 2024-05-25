import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:torganic/src/common/widgets/containers/banner_image.dart';
import 'package:torganic/src/utils/constants/app_api_end_points.dart';
import 'package:torganic/src/utils/constants/colors.dart';
import 'package:torganic/src/utils/constants/sizes.dart';
import 'package:torganic/src/utils/local_storage/local_storage_keys.dart';
import 'package:torganic/src/utils/local_storage/storage_utility.dart';
import '../../../../common/widgets/containers/card_container.dart';
import '../../../../utils/constants/image_strings.dart';

class AppHomeAppBarTitle extends StatelessWidget {
  const AppHomeAppBarTitle({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
            width: 70,
            child: Image.asset(AppImages.darkAppLogo)),
         SizedBox(
            child: Row(
                children: [
                  Text('Hi, User', style: Theme.of(context).textTheme.bodyLarge,),
                  const Gap(AppSizes.spaceBtwRowItem),
                  AppLocalStorage().readData(LocalStorageKeys.isLoggedIn) == true?
                   AppCardContainer(
                     padding: const EdgeInsets.all(5),
                      height: 40,
                      width: 40,
                      borderRadius: 100,
                     // backgroundColor: Colors.black,
                     hasBorder: true,
                      borderWidth: 1,
                      borderColor: AppColors.secondary,
                      child: AppBannerImage(
                        isNetworkImage: true,
                          imgUrl: 'https://app.kireibd.com/${AppLocalStorage().readData(LocalStorageKeys.avatarOriginal)}'))
                      :
                  const Icon(Icons.account_circle_outlined, color: AppColors.secondary)

                ]))
      ],
    );
  }
}