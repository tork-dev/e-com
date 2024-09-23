import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/widgets/containers/banner_image.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/authentication/views/log_in/controllers/login_controller.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/image_strings.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';

import '../../controller/account_details_controller.dart';
import 'custom_shape.dart';
import 'edit_profile_picture_part.dart';

class PicturePart extends StatelessWidget {
  const PicturePart({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(LogInPageController());
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
                  AppEditProfilePicturePart()
                ],
              ),
            )
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Obx(() {
          return Text(
            loginController.userDataByToken.value.name ??
                "${AppLocalStorage().readData(LocalStorageKeys.userName)}",
            style: const TextStyle(
                fontSize: 14,
                color: AppColors.secondary,
                fontWeight: FontWeight.w600),
          );
        }),
      )
    ]);
  }
}
