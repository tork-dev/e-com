import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kirei/src/features/authentication/views/sign_up/model/signup_response.dart';
import 'package:kirei/src/utils/firebase/gtm_events.dart';
import 'package:kirei/src/utils/helpers/network_manager.dart';
import 'package:kirei/src/utils/popups/loaders.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../../bottom_navigation/convex-bottom_navigation.dart';
import '../../forgot_password/view/otp.dart';
import '../repository/signup_repository.dart';

class SignUpPageController extends GetxController {
  static SignUpPageController get instance => Get.find();

  ///Controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  Rx<bool> passwordObscured = true.obs;
  Rx<bool> confirmPasswordObscured = true.obs;
  Rx<bool> signupWithPassword = false.obs;
  List<SignupResponse> signupList = [];
  List<SignupResponse> signupOtpList = [];
  RxBool isSignupOtp = false.obs;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> sendOtpSignUp(

      ) async {
    final isConnected = await NetworkManager.instance.isConnected();
    try {
      /// Validate Form
      if (!signupFormKey.currentState!.validate()) return;

      ///Check Internet
      if (!isConnected) return;

      ///Api Calling
       var response = await SignupRepository().getSignupOtpResponse(
           emailController.text,
       );
      signupOtpList.add(response);

      isSignupOtp.value = true;


    } catch (e) {
      /// Error
      AppLoaders.errorSnackBar(title: 'oh, Snap', message: "Something went wrong, Please try again");
    } finally {
      //FullScreenLoader.stopLoading();
      if (signupFormKey.currentState!.validate()) {
        if(signupOtpList[0].result == true){
          AppHelperFunctions.showToast(signupOtpList[0].message.toString());
          Get.to(()=> const Otp());
        } else{
          AppHelperFunctions.showToast(signupOtpList[0].message.toString());
        }
      }
    }
  }


  Future<void> emailPasswordSignUp() async {
    final isConnected = await NetworkManager.instance.isConnected();
    try {
      ///Check Internet
      if (!isConnected) return;


      ///API Calling
      var response = await SignupRepository().getSignupResponse(
          nameController.text,
          emailController.text,
          passwordController.text,
          confirmPasswordController.text,
          "email",
      );

      signupList.add(response);

      /// Validate Form
      if (!signupFormKey.currentState!.validate()) return;
    } catch (e) {
      /// Error
      AppLoaders.errorSnackBar(title: 'oh, Snap', message: "Something went wrong, Please try again");
    } finally {
      if(signupFormKey.currentState!.validate()){
        if(signupList[0].result==true){
          AppHelperFunctions.showToast(signupList[0].message.toString());
          Get.offAll(const HelloConvexAppBar());
          EventLogger().logSignUpEvent('email and password');
        } else{
          AppHelperFunctions.showToast(signupList[0].message.toString());
        }
      }
    }
  }
}
