import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:torganic/src/features/authentication/views/sign_up/model/signup_response.dart';
import 'package:torganic/src/utils/constants/image_strings.dart';
import 'package:torganic/src/utils/helpers/network_manager.dart';
import 'package:torganic/src/utils/popups/loaders.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../utils/helpers/auth_helper.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../../../utils/local_storage/local_storage_keys.dart';
import '../../../../../utils/local_storage/storage_utility.dart';
import '../../../../../utils/popups/full_screen_loader.dart';
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

      /// Start Loading
      // FullScreenLoader.openLoadingDialog(
      //     AppLocalizations.of(Get.overlayContext!)!.processing,
      //     AppImages.loading);

      ///Api Calling
       var response = await SignupRepository().getSignupOtpResponse(
           emailController.text,
       );
      signupOtpList.add(response);

      isSignupOtp.value = true;


    } catch (e) {
      /// Error
      AppLoaders.errorSnackBar(title: 'oh, Snap', message: e.toString());
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
      /// Start Loading
      // FullScreenLoader.openLoadingDialog(
      //     AppLocalizations.of(Get.overlayContext!)!.processing,
      //     AppImages.loaderAnimation);

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
      AuthHelper().setUserData(response);
      // AuthHelper().fetch_and_set();
      /// Validate Form
      if (!signupFormKey.currentState!.validate()) return;
    } catch (e) {
      /// Error
      AppLoaders.errorSnackBar(title: 'oh, Snap', message: e.toString());
    } finally {
      //FullScreenLoader.stopLoading();
      if(signupFormKey.currentState!.validate()){
        if(signupList[0].result==true){
          AppHelperFunctions.showToast(signupList[0].message.toString());
          Get.offAll(const HelloConvexAppBar());
        } else{
          AppHelperFunctions.showToast(signupList[0].message.toString());
        }
      }
    }
  }
}
