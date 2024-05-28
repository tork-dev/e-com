import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:torganic/src/features/personalization/model/profile_update_image_model.dart';
import 'package:torganic/src/features/personalization/model/profile_update_model.dart';
import 'package:torganic/src/features/personalization/repositories/personalization_repositories.dart';
import 'package:torganic/src/utils/constants/colors.dart';
import 'package:torganic/src/utils/helpers/helper_functions.dart';
import 'package:torganic/src/utils/local_storage/local_storage_keys.dart';
import 'package:torganic/src/utils/local_storage/storage_utility.dart';

class AccountDetailsController extends GetxController {
  static AccountDetailsController get instance => Get.find();

  TextEditingController nameController = TextEditingController(
      text: AppLocalStorage().readData(LocalStorageKeys.userName));
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
  GlobalKey<FormState> updatePasswordFormKey = GlobalKey<FormState>();

  Rx<ProfileUpdateResponse> profileUpdateResponse = ProfileUpdateResponse().obs;
  Rx<ProfileUpdateImageResponse> profileUpdateImageResponse = ProfileUpdateImageResponse().obs;


  Future<ProfileUpdateResponse> getProfileUpdateResponse() async {
    return profileUpdateResponse.value = await PersonalizationRepositories()
        .getProfileUpdateResponse(nameController.text,
            confirmNewPasswordController.text, currentPasswordController.text);
  }

  Future<void> profileUpdate() async {
    try {
      if (newPasswordController.text.isNotEmpty || confirmNewPasswordController.text.isNotEmpty) {
        if (!updatePasswordFormKey.currentState!.validate()) return;
      }
      await getProfileUpdateResponse().then((value) {
        if (profileUpdateResponse.value.result == true) {
          AppLocalStorage().saveData(
              LocalStorageKeys.userName, nameController.text.toString());
        }
        AppHelperFunctions.showToast(profileUpdateResponse.value.message!);
      });
      await uploadImage();
    } catch (e) {
      AppHelperFunctions.showToast('Failed To Update');
    }
  }




  var image = File('').obs;
  final picker = ImagePicker();
  Rx<ProfileUpdateImageResponse> profileImageUpdateResponse = ProfileUpdateImageResponse().obs;

  Future<void> pickImage() async {
    // Request photo library permission
    var status = await Permission.storage.request();
    if (!status.isGranted) {
      status = await Permission.storage.request();
      if (!status.isGranted) {
        Get.snackbar('Error', 'Photo library permission is required to pick an image.');
        return;
      }
    }

    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    } else {
      Get.snackbar('Error', 'No image selected');
    }
  }

  Future<void> uploadImage() async {
    if (image.value.path.isEmpty) {
      Get.snackbar('Error', 'No image selected to upload');
      return;
    }

    try {
      profileImageUpdateResponse.value = await PersonalizationRepositories().updateProfileImage(
        imagePath: image.value.path,
        filename: image.value.path.split('/').last,
      );

      if (profileUpdateResponse.value.result != null) {
        Get.snackbar('Success', profileUpdateResponse.value.message!);
      } else {
        Get.snackbar('Error', 'Failed to update profile image');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update profile image: $e');
    }
  }


}
