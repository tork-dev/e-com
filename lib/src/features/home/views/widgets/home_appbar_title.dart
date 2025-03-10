import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/widgets/containers/banner_image.dart';
import 'package:kirei/src/features/authentication/views/log_in/view/login.dart';
import 'package:kirei/src/features/bottom_navigation/convex_controller.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';
import '../../../../common/widgets/containers/card_container.dart';
import '../../../../utils/constants/image_strings.dart';

class AppHomeAppBarTitle extends StatelessWidget {
  const AppHomeAppBarTitle({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final bottomController = ConvexBottomNavController.instance;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
            width: 70,
            child: Image.asset(AppImages.lightAppLogo)),
         SizedBox(
            child: InkWell(
              onTap: (){
                if(AppLocalStorage().readData(LocalStorageKeys.isLoggedIn) == true){
                bottomController.jumpToTab(3);
                }else{
                  Get.offAll(const LogIn());
                }
              },
              child: Row(
                  children: [
                    Container(width: 170,
                        alignment: Alignment.centerRight,
                        child: Text('Hi, ${AppLocalStorage().readData(LocalStorageKeys.userName ) ?? 'User'} ', style: Theme.of(context).textTheme.bodyLarge,)),
                    const Gap(AppSizes.spaceBtwSmallItem),
                    AppLocalStorage().readData(LocalStorageKeys.isLoggedIn) == true?
                     AppCardContainer(
                       applyRadius: true,
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
                            imgUrl: '${AppLocalStorage().readData(LocalStorageKeys.avatarOriginal)}'))
                        :
                    const Icon(Icons.account_circle_outlined, color: AppColors.secondary)

                  ]),
            ))
      ],
    );
  }
}