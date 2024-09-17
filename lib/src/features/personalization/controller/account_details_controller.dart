import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:kirei/src/features/bottom_navigation/convex_controller.dart';
import 'package:kirei/src/features/personalization/model/profile_update_image_model.dart';
import 'package:kirei/src/features/personalization/model/profile_update_model.dart';
import 'package:kirei/src/features/personalization/repositories/personalization_repositories.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';

import '../../../utils/helpers/file_helper.dart';

class AccountDetailsController extends GetxController {
  static AccountDetailsController get instance => Get.find();

  TextEditingController nameController = TextEditingController(
      text: AppLocalStorage().readData(LocalStorageKeys.userName));
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
  GlobalKey<FormState> updatePasswordFormKey = GlobalKey<FormState>();

  /// password obsecure values
  RxBool visibleCurrentPassword = true.obs;
  RxBool visibleNewPassword = true.obs;
  RxBool visibleConfirmPassword = true.obs;

  Rx<ProfileUpdateResponse> profileUpdateResponse = ProfileUpdateResponse().obs;
  Rx<ProfileUpdateImageResponse> profileUpdateImageResponse = ProfileUpdateImageResponse().obs;


  Future<ProfileUpdateResponse> getProfileUpdateResponse() async {
    return profileUpdateResponse.value = await PersonalizationRepositories()
        .getProfileUpdateResponse(nameController.text,
            confirmNewPasswordController.text, currentPasswordController.text);
  }

  Future<void> profileUpdate() async {
    try {
      if(AppLocalStorage().readData(LocalStorageKeys.userHavePassword) && currentPasswordController.text == ''){
        return AppHelperFunctions.showToast('Must be provide current password');
      }

      if (newPasswordController.text.isNotEmpty || confirmNewPasswordController.text.isNotEmpty) {
        if (!updatePasswordFormKey.currentState!.validate()) return;
      }
      await getProfileUpdateResponse().then((value) {
        //convexBottomNavController.getUserDataByToken();
        AppHelperFunctions.showToast(profileUpdateResponse.value.message!);
        if(profileUpdateResponse.value.result == true){
          Get.back();
        }
      });
    } catch (e) {
      AppHelperFunctions.showToast('Failed To Update');
    }
  }




  final ImagePicker _picker = ImagePicker();
  XFile? _file;

  chooseAndUploadImage() async {
    // var status = await Permission.photos.request();
      _file = await _picker.pickImage(source: ImageSource.gallery);
      print(_file);

      if(_file!= null) {
        String base64Image = FileHelper.getBase64FormatedFile(_file!.path);
        String fileName = _file!
            .path
            .split("/")
            .last;
        profileUpdateImageResponse.value =
        await PersonalizationRepositories().getProfileImageUpdateResponse(
            image: base64Image,
            filename: fileName
        );
        AppLocalStorage().saveData(
            LocalStorageKeys.avatarOriginal, profileUpdateImageResponse.value.path);
      }else {
        return null;
      }
    }
  }

