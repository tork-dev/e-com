import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:torganic/src/features/personalization/controller/account_details_controller.dart';

import '../../../../common/widgets/containers/banner_image.dart';
import '../../../../common/widgets/containers/card_container.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/local_storage/local_storage_keys.dart';
import '../../../../utils/local_storage/storage_utility.dart';

class AppEditProfilePicturePart extends StatelessWidget {
  const AppEditProfilePicturePart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final detailsController = AccountDetailsController.instance;
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
                    isNetworkImage: AppLocalStorage()
                        .readData(LocalStorageKeys.avatarOriginal) !=
                        null && detailsController.image.value.path.isEmpty,
                    isFileImage: detailsController.image.value.path.isNotEmpty,
                    fit: BoxFit.fill,
                    imgUrl: AppLocalStorage().readData(
                        LocalStorageKeys.avatarOriginal) !=
                        null  && detailsController.image.value.path.isEmpty
                        ? 'https://app.kireibd.com/${AppLocalStorage().readData(LocalStorageKeys.avatarOriginal)}'
                        : detailsController.image.value ?? AppImages.profileIcon,
                  );
                }
              )),
          Positioned(
              right: 0,
              bottom: 15,
              child: AppCardContainer(
                width: 30,
                height: 30,
                backgroundColor: AppColors.grey,
                child: InkWell(
                    onTap: (){
                      detailsController.pickImage();
                    },
                    child: const Icon(Icons.edit, size: 20,)),
              ))
        ],
      ),
    );
  }
}