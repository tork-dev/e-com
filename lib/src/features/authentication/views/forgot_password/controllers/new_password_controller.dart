import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kirei/src/features/authentication/views/forgot_password/controllers/forgot_password_controllers.dart';
import 'package:kirei/src/features/authentication/views/forgot_password/controllers/otp_controller.dart';
import 'package:kirei/src/features/authentication/views/forgot_password/model/new_password_response.dart';
import 'package:kirei/src/features/authentication/views/forgot_password/repository/new_password_repository.dart';
import 'package:kirei/src/features/authentication/views/log_in/view/login.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';
import 'package:kirei/src/utils/popups/loaders.dart';

class NewPasswordController extends GetxController{
  static NewPasswordController get instance => Get.find();
  OtpController otpController = Get.put(OtpController());
  ForgotPasswordController forgetPasswordController = Get.put(ForgotPasswordController());
  ///Controllers
  TextEditingController newPassword = TextEditingController();
  TextEditingController newConfirmPassword = TextEditingController();

  Rx<bool> passwordObscured = true.obs;
  Rx<bool> confirmPasswordObscured = true.obs;

  GlobalKey<FormState> newPasswordKey = GlobalKey<FormState>();

  List<NewPasswordResponse> newPasswordList = [];

  Future<void> submit() async{
    // final isConnected = await NetworkManager.instance.isConnected();
    try{
      /// Start Loading
      //FullScreenLoader.openLoadingDialog('Processing', AppImages.loaderAnimation);

      ///Check Internet
      // if(!isConnected) return;

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
      AppLoaders.errorSnackBar(title: 'oh, Snap', message: "Something went wrong, Please try again");
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