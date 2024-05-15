
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:torganic/src/features/authentication/views/forgot_password/controllers/forgot_password_controllers.dart';
import 'package:torganic/src/features/authentication/views/forgot_password/model/forget_password_confrim_response.dart';
import 'package:torganic/src/features/authentication/views/forgot_password/repository/forgot_password_repository.dart';
import 'package:torganic/src/features/authentication/views/forgot_password/view/new_password.dart';
import 'package:torganic/src/features/authentication/views/log_in/controllers/login_controller.dart';
import 'package:torganic/src/features/authentication/views/log_in/model/login_response.dart';
import 'package:torganic/src/features/authentication/views/log_in/repository/login_repository.dart';
import 'package:torganic/src/features/authentication/views/sign_up/controllers/signup_controller.dart';
import 'package:torganic/src/features/authentication/views/sign_up/model/signup_response.dart';
import 'package:torganic/src/features/authentication/views/sign_up/repository/signup_repository.dart';
import 'package:torganic/src/utils/helpers/helper_functions.dart';
import 'package:torganic/src/utils/helpers/network_manager.dart';
import 'package:torganic/src/utils/popups/loaders.dart';
import '../../../../../utils/helpers/auth_helper.dart';
import '../../../../bottom_navigation/convex-bottom_navigation.dart';


class OtpController extends GetxController{
  static OtpController get instance => Get.find();
  final forgetPasswordController = Get.put(ForgotPasswordController());
  final signUpController = Get.put(SignUpPageController());
  final loginController = LogInPageController.instance;

  ///Controllers
  final otpCodeController = TextEditingController();

  GlobalKey<FormState> otpKey = GlobalKey<FormState>();
  List<LoginResponse> otpLoginResponse = [];
  List<LoginResendOtpResponse> resendOtpLoginResponse = [];
  List<SignupResponse> otpSignUpResponse = [];
  List<SignupResendOtpResponse> resendOtpSignUpResponse = [];
  List<ForgetPasswordConfirmResponse> otpForgetPasswordResponse = [];
  List<ResendForgetPasswordResponse> resendOtpForgetPasswordResponse = [];

  @override
  void dispose() {
    otpCodeController.dispose();
    super.dispose();
  }

  Future<void> verify({bool? isOtpLogin}) async{
    final isConnected = await NetworkManager.instance.isConnected();
    try{
      /// Start Loading
     // FullScreenLoader.openLoadingDialog('Processing', AppImages.loaderAnimation);

      ///Check Internet
      if(!isConnected) return;

      /// Validate Form
      if(!otpKey.currentState!.validate()) return;

      ///Api Calling

      var response = forgetPasswordController.isForgotPassword.value == true? await ForgotPasswordRepository().getPasswordConfirmResponse(
          otpCodeController.text,
          forgetPasswordController.forgotPasswordEmail.text,
      )
          :
      signUpController.isSignupOtp.value == true ?
          await SignupRepository().getSignUpOtpConfirmCodeResponse(
              signUpController.emailController.text,
              otpCodeController.text
          )
          :
      await LoginRepository().getLogInOtpConfirmCodeResponse(
          loginController.emailController.text,
          otpCodeController.text,
      );
      forgetPasswordController.isForgotPassword.value == true? otpForgetPasswordResponse.add(response) : signUpController.isSignupOtp.value == true ? otpSignUpResponse.add(response) :
      otpLoginResponse.add(response);
      forgetPasswordController.isForgotPassword.value == true? Container() : AuthHelper().setUserData(response);
      forgetPasswordController.isForgotPassword.value == true? Container() : AuthHelper().fetch_and_set();

    }catch(e){
      /// Error
      AppLoaders.errorSnackBar(title: 'oh, Snap', message: e.toString());
      //print("problem: ${e.toString()}");
    }finally{
      //FullScreenLoader.stopLoading();
      if(otpKey.currentState!.validate()){
        if(forgetPasswordController.isForgotPassword.value== true ? otpForgetPasswordResponse[0].result == true : signUpController.isSignupOtp.value == true ? otpSignUpResponse[0].result == true : otpLoginResponse[0].result == true){
          forgetPasswordController.isForgotPassword.value== true ? AppHelperFunctions.showToast(otpForgetPasswordResponse[0].message.toString()) : signUpController.isSignupOtp.value == true ? AppHelperFunctions.showToast(otpSignUpResponse[0].message.toString()) : AppHelperFunctions.showToast(otpLoginResponse[0].message.toString());
        if(forgetPasswordController.isForgotPassword.value != false || signUpController.isSignupOtp.value != true){
          Get.to(() => const NewPassword());
        } else {
          Get.to(() => const HelloConvexAppBar());
        }
      } else{
          //AppHelperFunctions.showToast(otpLoginResponse[0].message.toString());
          signUpController.isSignupOtp.value == true ? AppHelperFunctions.showToast(otpSignUpResponse[0].message.toString()) : AppHelperFunctions.showToast(otpLoginResponse[0].message.toString());
        }
      }
    }
  }

  Future<void> reSendCode() async{
    final isConnected = await NetworkManager.instance.isConnected();
    try{
      /// Start Loading
      // FullScreenLoader.openLoadingDialog('Processing', AppImages.loaderAnimation);

      ///Check Internet
      if(!isConnected) return;

      /// Validate Form
      //if(!otpKey.currentState!.validate()) return;

      ///Api Calling

      var response =
      forgetPasswordController.isForgotPassword.value == true?
      await ForgotPasswordRepository().getResendForgetPasswordResponse(forgetPasswordController.forgotPasswordEmail.text)
          :
      signUpController.isSignupOtp.value == true ? await SignupRepository().getResendSignupOtpResponse(
          signUpController.emailController.text,
      )
          :
      await LoginRepository().getLoginResendOTPResponse(loginController.emailController.text);

      forgetPasswordController.isForgotPassword.value == true?  resendOtpForgetPasswordResponse.add(response) : signUpController.isSignupOtp.value == true ? resendOtpSignUpResponse.add(response) : resendOtpLoginResponse.add(response);


    } catch(e){
      /// Error
      AppLoaders.errorSnackBar(title: 'oh, Snap', message: e.toString());
      //print("Problem is: "+ e.toString());
    }finally{
      //FullScreenLoader.stopLoading();
        if(forgetPasswordController.isForgotPassword.value == true? resendOtpForgetPasswordResponse[0].result == true : signUpController.isSignupOtp.value == true ? resendOtpSignUpResponse[0].result == true : resendOtpLoginResponse[0].result == true){

          AppHelperFunctions.showToast(forgetPasswordController.isForgotPassword.value == true? resendOtpForgetPasswordResponse[0].message.toString() : signUpController.isSignupOtp.value == true ? resendOtpSignUpResponse[0].message.toString() : resendOtpLoginResponse[0].message.toString());

        } else{
          AppHelperFunctions.showToast(forgetPasswordController.isForgotPassword.value == true? resendOtpForgetPasswordResponse[0].message.toString() : signUpController.isSignupOtp.value == true ? resendOtpSignUpResponse[0].message.toString() : resendOtpLoginResponse[0].message.toString());
        }
    }

  }


}