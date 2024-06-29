import 'package:flutter/material.dart';
import 'package:torganic/src/common/widgets/containers/banner_image.dart';
import 'package:torganic/src/common/widgets/containers/card_container.dart';
import 'package:torganic/src/utils/constants/colors.dart';
import 'package:torganic/src/utils/constants/image_strings.dart';
import 'package:torganic/src/utils/local_storage/local_storage_keys.dart';
import 'package:torganic/src/utils/local_storage/storage_utility.dart';

import 'custom_shape.dart';

class PicturePart extends StatelessWidget {
  const PicturePart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 170,
        child: Stack(
          children: [
            ClipPath(
              clipper: CustomShape(),
              child: Container(
                height: 215, //150
                color: AppColors.primary,
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppCardContainer(
                      width: 140,
                      height: 140,
                      applyRadius: false,
                      borderColor: AppColors.white,
                      borderWidth: 2 * 0.8,
                      hasBorder: true,
                      isCircle: true,
                      child: AppBannerImage(
                        imgBoarderRadius: 100,
                        isNetworkImage: AppLocalStorage()
                                .readData(LocalStorageKeys.avatarOriginal) !=
                            null,
                        fit: BoxFit.fill,
                        imgUrl: AppLocalStorage().readData(
                                    LocalStorageKeys.avatarOriginal) !=
                                null
                            ? '${AppLocalStorage().readData(LocalStorageKeys.avatarOriginal)}'
                            : AppImages.profileIcon,
                      )),
                ],
              ),
            )
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(
          "${AppLocalStorage().readData(LocalStorageKeys.userName)}",
          style: const TextStyle(
              fontSize: 14,
              color: AppColors.secondary,
              fontWeight: FontWeight.w600),
        ),
      )
    ]);
  }
}
