
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:torganic/src/features/authentication/views/forgot_password/controllers/forgot_password_controllers.dart';
import 'package:torganic/src/features/authentication/views/forgot_password/view/new_password.dart';
import 'package:torganic/src/features/authentication/views/forgot_password/view/otp.dart';
import 'package:torganic/src/features/authentication/views/log_in/controllers/login_controller.dart';
import 'package:torganic/src/features/authentication/views/log_in/model/login_response.dart';
import 'package:torganic/src/features/authentication/views/log_in/repository/login_repository.dart';
import 'package:torganic/src/features/authentication/views/sign_up/controllers/signup_controller.dart';
import 'package:torganic/src/features/authentication/views/sign_up/model/signup_response.dart';
import 'package:torganic/src/features/authentication/views/sign_up/repository/signup_repository.dart';
import 'package:torganic/src/features/bottom_navigation/bottom_navigation.dart';
import 'package:torganic/src/features/home/views/home.dart';
import 'package:torganic/src/utils/constants/image_strings.dart';
import 'package:torganic/src/utils/helpers/helper_functions.dart';
import 'package:torganic/src/utils/helpers/network_manager.dart';
import 'package:torganic/src/utils/popups/loaders.dart';
import '../../../../../utils/helpers/auth_helper.dart';
import '../../../../../utils/popups/full_screen_loader.dart';
import '../../../../bottom_navigation/convex-bottom_navigation.dart';
import '../model/forget_password_confrim_response.dart';

class OtpController extends GetxController{
  static OtpController get instance => Get.find();
  final forgetPasswordController = Get.put(ForgotPasswordController());
  final signUpController = Get.put(SignUpPageController());
  final loginController = LogInPageController.instance;

  ///Controllers
  final otpCodeController = TextEditingController();

  GlobalKey<FormState> otpKey = GlobalKey<FormState>();
  List<LoginResponse> otpLoginResponse = [];
  List<SignupResponse> otpSignUpResponse = [];
  List<ForgetPasswordConfirmResponse> otpForgetPasswordResponse = [];

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

      print("Otp verification Page Working");
      print("value : ${signUpController.isSignupOtp.value}");
      print("value login: ${loginController.emailController.text}");
      print("value login: ${otpCodeController.text}");
      print("value signup: ${signUpController.emailController.text}");
      print("value signup: ${otpCodeController.text}");

      var response = signUpController.isSignupOtp.value == true ?
          await SignupRepository().getSignUpOtpConfirmCodeResponse(
              signUpController.emailController.text,
              otpCodeController.text
          )
          :
      await LoginRepository().getLogInOtpConfirmCodeResponse(
          loginController.emailController.text,
          otpCodeController.text,
      );
      print("After hit response: ${response}");
      signUpController.isSignupOtp.value == true ? otpSignUpResponse.add(response) :
      otpLoginResponse.add(response);
      print("After entering list login: ${otpLoginResponse}");
      print("After entering list signup: ${otpSignUpResponse}");
      print("saving procedure start");
      AuthHelper().setUserData(response);
      AuthHelper().fetch_and_set();
      print("saving procedure done");

    }catch(e){
      /// Error
      AppLoaders.errorSnackBar(title: 'oh, Snap', message: e.toString());
      print("problem: ${e.toString()}");
    }finally{
      //FullScreenLoader.stopLoading();
      if(otpKey.currentState!.validate()){
        print("entering final loop");
        print("final value: ${signUpController.isSignupOtp.value}");
        if(signUpController.isSignupOtp.value == true ? otpSignUpResponse[0].result == true : otpLoginResponse[0].result == true){
          signUpController.isSignupOtp.value == true ? AppHelperFunctions.showToast(otpSignUpResponse[0].message.toString()) : AppHelperFunctions.showToast(otpLoginResponse[0].message.toString());
          print("final value initial stage: ${signUpController.isSignupOtp.value}");
          print("final value final stage: ${forgetPasswordController.isForgotPassword.value}");
        if(forgetPasswordController.isForgotPassword.value != false || signUpController.isSignupOtp.value != true){
          print("success");
          Get.to(const NewPassword());
        } else {
          print("failed");
          Get.to(const HelloConvexAppBar());
        }
      } else{
          print("exit final loop");
          //AppHelperFunctions.showToast(otpLoginResponse[0].message.toString());
          signUpController.isSignupOtp.value == true ? AppHelperFunctions.showToast(otpSignUpResponse[0].message.toString()) : AppHelperFunctions.showToast(otpLoginResponse[0].message.toString());
        }
      }
    }
  }
}