import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/utils/popups/loaders.dart';
import '../model/user_model.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final GlobalKey<ScaffoldState> profileKey = GlobalKey<ScaffoldState>();

  Rx<UserModel> user = UserModel.empty().obs;
  //final userRepository = Get.put(UserRepositories());


  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  /// On refresh
  Future<void> onRefresh() async {
    print('refresh');
  }

  /// Save User Record
  Future<void> saveUserData(UserCredential? userCredential) async {
    try {
      if (userCredential != null) {
        final nameParts = UserModel.nameParts(
            userCredential.user!.displayName ?? '');
        final userName = UserModel.generateUserName(
            userCredential.user!.displayName ?? '');

        /// Map Data
        final user = UserModel(id: userCredential.user!.uid,
            firstName: nameParts[0],
            lastName: nameParts.length > 1 ? nameParts.sublist(1).join() : '',
            userName: userName,
            email: userCredential.user!.email ?? '',
            phoneNumber: userCredential.user!.phoneNumber ?? '',
            profilePicture: userCredential.user!.photoURL ?? '');

        //await userRepository.saveUserRecord(user);
      }
    } catch (e) {
      AppLoaders.warningSnackBar(title: 'Data not saved');
    }
  }

  /// Fetch user data
  Future<void> fetchUserData() async {
    try{
      //final userData = await userRepository.fetchUserRecord();
      //user.value = userData;
    }catch(e){
      UserModel.empty();
    }
  }
}