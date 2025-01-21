import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/features/personalization/controller/account_details_controller.dart';
import '../../../../common/widgets/containers/banner_image.dart';
import '../../../../common/widgets/containers/card_container.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/local_storage/local_storage_keys.dart';
import '../../../../utils/local_storage/storage_utility.dart';

class AppEditProfilePicturePart extends StatelessWidget {
  const AppEditProfilePicturePart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final detailsController = Get.put(AccountDetailsController());
    return Center(
      child: Stack(
        children: [
          AppCardContainer(
              width: 140,
              height: 140,
              applyRadius: false,
              borderColor: AppColors.grey,
              borderWidth: 2 * 0.8,
              hasBorder: true,
              isCircle: true,
              child: Obx(() {
                return AppBannerImage(
                    imgBoarderRadius: 100,
                    isNetworkImage: true,
                    fit: BoxFit.fill,
                    imgUrl: detailsController
                            .profileUpdateImageResponse.value.path ??
                        AppLocalStorage()
                            .readData(LocalStorageKeys.avatarOriginal) ?? '') ;
              })),
          Positioned(
              right: 0,
              bottom: 15,
              child: AppCardContainer(
                width: 30,
                height: 30,
                backgroundColor: AppColors.grey,
                child: InkWell(
                    onTap: () {
                      detailsController.chooseAndUploadImage();
                    },
                    child: const Icon(
                      Icons.edit,
                      size: 20,
                    )),
              ))
        ],
      ),
    );
  }
}
