import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kirei/src/features/authentication/views/forgot_password/controllers/forgot_password_controllers.dart';
import 'package:kirei/src/features/authentication/views/forgot_password/model/forget_password_confrim_response.dart';
import 'package:kirei/src/features/authentication/views/forgot_password/model/forgot_password_reponse.dart';
import 'package:kirei/src/features/authentication/views/forgot_password/repository/forgot_password_repository.dart';
import 'package:kirei/src/features/authentication/views/forgot_password/view/new_password.dart';
import 'package:kirei/src/features/authentication/views/log_in/controllers/login_controller.dart';
import 'package:kirei/src/features/authentication/views/log_in/model/login_response.dart';
import 'package:kirei/src/features/authentication/views/log_in/repository/login_repository.dart';
import 'package:kirei/src/features/authentication/views/sign_up/controllers/signup_controller.dart';
import 'package:kirei/src/features/authentication/views/sign_up/model/signup_response.dart';
import 'package:kirei/src/features/authentication/views/sign_up/repository/signup_repository.dart';
import 'package:kirei/src/features/spinner_wheel/controller/spinner_controller.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';
import 'package:kirei/src/utils/helpers/network_manager.dart';
import 'package:kirei/src/utils/popups/loaders.dart';
import '../../../../../utils/firebase/gtm_events.dart';
import '../../../../../utils/helpers/auth_helper.dart';
import '../../../../bottom_navigation/convex-bottom_navigation.dart';
import '../../../model/resend_code_model.dart';

class OtpController extends GetxController {
  static OtpController get instance => Get.find();
  final forgetPasswordController = Get.put(ForgotPasswordController());
  final signUpController = Get.put(SignUpPageController());
  final loginController = Get.put(LogInPageController());

  ///Controllers
  final otpCodeController = TextEditingController();

  GlobalKey<FormState> otpKey = GlobalKey<FormState>();
  Rx<AppLoginResponse> loginResponse = AppLoginResponse().obs;
  Rx<AppLoginResponse> otpSignUpResponse = AppLoginResponse().obs;
  Rx<ForgetPasswordConfirmResponse> otpForgetPasswordResponse =
      ForgetPasswordConfirmResponse().obs;
  Rx<SendOtpCodeResponse> sendOtpResponse = SendOtpCodeResponse().obs;
  RxInt startTime = 60.obs;
  Timer? timer;


  @override
  void onInit() {
    super.onInit();
    // TODO: implement onInit
    timeCount();
  }

  @override
  void dispose() {
    otpCodeController.dispose();
    super.dispose();
  }

  Future<void> verify() async {
    final isConnected = await NetworkManager.instance.isConnected();
    try {
      ///Check Internet
      if (!isConnected) return;

      /// Validate Form
      if (!otpKey.currentState!.validate()) return;

      ///Api Calling
      forgetPasswordController.isForgotPassword.value == true
          ? otpForgetPasswordResponse.value =
              await ForgotPasswordRepository().getPasswordConfirmResponse(
              otpCodeController.text,
              forgetPasswordController.forgotPasswordEmail.text,
            )
          : signUpController.isSignupOtp.value == true
              ? loginResponse.value = await SignupRepository()
                  .getSignUpOtpConfirmCodeResponse(
                      signUpController.emailController.text,
                      otpCodeController.text)
              : loginResponse.value =
                  await LoginRepository().getLogInOtpConfirmCodeResponse(
                  loginController.emailController.text,
                  otpCodeController.text,
                );
      forgetPasswordController.isForgotPassword.value == true
          ? Container()
          : AuthHelper().setUserData(loginResponse.value);
    } catch (e) {
      /// Error
      AppLoaders.errorSnackBar(title: 'oh, Snap', message: "Something went wrong, Please try again");
    } finally {
      if (otpKey.currentState!.validate()) {
        if (forgetPasswordController.isForgotPassword.value == true
            ? otpForgetPasswordResponse.value.result == true
                : loginResponse.value.result == true) {
          forgetPasswordController.isForgotPassword.value == true
              ? AppHelperFunctions.showToast(
                  otpForgetPasswordResponse.value.message.toString())
              : signUpController.isSignupOtp.value == true
                  ? AppHelperFunctions.showToast(
                      loginResponse.value.message.toString())
                  : AppHelperFunctions.showToast(
              loginResponse.value.message.toString());
          if (forgetPasswordController.isForgotPassword.value != false &&
              signUpController.isSignupOtp.value != true) {
            Get.to(() => const NewPassword());
          } else {
            Get.offAll(() => const HelloConvexAppBar(
                  pageIndex: 0,
                ));
            EventLogger().logLoginEvent('Otp');
          }
        } else {
          signUpController.isSignupOtp.value == true
              ? AppHelperFunctions.showToast(
              loginResponse.value.message.toString())
              : AppHelperFunctions.showToast(
              loginResponse.value.message.toString());
        }
      }
    }
  }

  Future<void> reSendCode() async {
    final isConnected = await NetworkManager.instance.isConnected();
    try {
      ///Check Internet
      if (!isConnected) return;

      ///Api Calling
      forgetPasswordController.isForgotPassword.value == true
          ? sendOtpResponse.value = await ForgotPasswordRepository()
              .getResendForgetPasswordResponse(
                  forgetPasswordController.forgotPasswordEmail.text)
          : signUpController.isSignupOtp.value == true
              ? sendOtpResponse.value =
                  await SignupRepository().getResendSignupOtpResponse(
                  signUpController.emailController.text,
                )
              : sendOtpResponse.value = await LoginRepository()
                  .getLoginResendOTPResponse(
                      loginController.emailController.text);
    } catch (e) {
      /// Error
      AppLoaders.errorSnackBar(title: 'oh, Snap', message: "Something went wrong, Please try again");
    } finally {
      AppHelperFunctions.showToast(sendOtpResponse.value.message!);
    }
  }


  Future<void> reSendCodeForSpinner() async {
    final spinnerController = SpinnerController.instance;
    try {
      ///Api Calling
      sendOtpResponse.value = await LoginRepository().getLoginOTPResponse(spinnerController.phoneNumberController.text);
    } catch (e) {
      /// Error
      AppLoaders.errorSnackBar(title: 'oh, Snap', message: "Something went wrong, Please try again");
    } finally {
      AppHelperFunctions.showToast(sendOtpResponse.value.message!);
    }
  }



  Future<void> verifyForSpinner() async {
    final spinnerController = SpinnerController.instance;
    if (!otpKey.currentState!.validate()) return;
    loginResponse.value = await LoginRepository()
        .getLogInOtpConfirmCodeResponse(
            spinnerController.phoneNumberController.text.toString(), otpCodeController.text);
    if (loginResponse.value.result == true) {
      EventLogger().logLoginEvent('Otp');
      await spinnerController.getSelectedCouponResponse(loginResponse.value.accessToken);
      AuthHelper().setUserData(loginResponse.value);
      AppHelperFunctions.showToast('Phone verified');
      Get.back();
      return;
    }
    AppHelperFunctions.showToast(loginResponse.value.message!);
  }

  timeCount() {
    if (timer != null && timer!.isActive) {
      timer!.cancel(); // Cancel the old timer if it's still running
    }

    startTime.value = 60;

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (startTime.value > 0) {
        startTime.value--;
      } else {
        timer.cancel();
      }
    });
  }
}
