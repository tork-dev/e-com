
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:torganic/src/features/authentication/views/forgot_password/controllers/forgot_password_controllers.dart';
import 'package:torganic/src/features/authentication/views/forgot_password/controllers/otp_controller.dart';
import 'package:torganic/src/features/authentication/views/forgot_password/model/new_password_response.dart';
import 'package:torganic/src/features/authentication/views/forgot_password/repository/new_password_repository.dart';
import 'package:torganic/src/features/authentication/views/forgot_password/view/new_password.dart';
import 'package:torganic/src/features/authentication/views/forgot_password/view/otp.dart';
import 'package:torganic/src/features/authentication/views/log_in/view/login.dart';
import 'package:torganic/src/features/bottom_navigation/bottom_navigation.dart';
import 'package:torganic/src/features/home/views/home.dart';
import 'package:torganic/src/utils/constants/image_strings.dart';
import 'package:torganic/src/utils/helpers/helper_functions.dart';
import 'package:torganic/src/utils/helpers/network_manager.dart';
import 'package:torganic/src/utils/popups/loaders.dart';
import '../../../../../utils/popups/full_screen_loader.dart';

class NewPasswordController extends GetxController{
  static NewPasswordController get instance => Get.find();
  final otpController = Get.put(OtpController());
  final forgetPasswordController = Get.put(ForgotPasswordController());
  ///Controllers
  final newPassword = TextEditingController();
  final newConfirmPassword = TextEditingController();

  Rx<bool> passwordObscured = true.obs;
  Rx<bool> confirmPasswordObscured = true.obs;

  GlobalKey<FormState> newPasswordKey = GlobalKey<FormState>();

  List<NewPasswordResponse> newPasswordList = [];

  Future<void> submit() async{
    final isConnected = await NetworkManager.instance.isConnected();
    try{
      /// Start Loading
      //FullScreenLoader.openLoadingDialog('Processing', AppImages.loaderAnimation);

      ///Check Internet
      if(!isConnected) return;

      /// Validate Form
      //if(!newPasswordKey.currentState!.validate()) return;

      ///Api Calling
      var response = await NewPasswordRepository().getConfirmReset(
          otpController.otpCodeController.text,
          forgetPasswordController.forgotPasswordEmail.text,
          true,
          newPassword.text,
      );

      newPasswordList.add(response);

    }catch(e){
      /// Error
      AppLoaders.errorSnackBar(title: 'oh, Snap', message: e.toString());
     // print("problem${e.toString()}");
    }finally{
      //FullScreenLoader.stopLoading();
      if(newPasswordKey.currentState!.validate()){
        if(newPasswordList[0].result == true){
          AppHelperFunctions.showToast(newPasswordList[0].message.toString());
          Get.offAll(() => const LogIn());
        } else{
          AppHelperFunctions.showToast(newPasswordList[0].message.toString());
        }
      }
    }
  }
}