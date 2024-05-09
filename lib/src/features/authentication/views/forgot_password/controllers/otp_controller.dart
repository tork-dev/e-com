
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:torganic/src/features/authentication/views/forgot_password/controllers/forgot_password_controllers.dart';
import 'package:torganic/src/features/authentication/views/forgot_password/view/new_password.dart';
import 'package:torganic/src/features/authentication/views/forgot_password/view/otp.dart';
import 'package:torganic/src/features/authentication/views/log_in/controllers/login_controller.dart';
import 'package:torganic/src/features/authentication/views/log_in/model/login_response.dart';
import 'package:torganic/src/features/authentication/views/log_in/repository/login_repository.dart';
import 'package:torganic/src/features/bottom_navigation/bottom_navigation.dart';
import 'package:torganic/src/features/home/views/home.dart';
import 'package:torganic/src/utils/constants/image_strings.dart';
import 'package:torganic/src/utils/helpers/helper_functions.dart';
import 'package:torganic/src/utils/helpers/network_manager.dart';
import 'package:torganic/src/utils/popups/loaders.dart';
import '../../../../../utils/helpers/auth_helper.dart';
import '../../../../../utils/popups/full_screen_loader.dart';
import '../../../../bottom_navigation/convex-bottom_navigation.dart';

class OtpController extends GetxController{
  static OtpController get instance => Get.find();
  final forgetPasswordController = Get.put(ForgotPasswordController());
  final loginController = LogInPageController.instance;

  ///Controllers
  final otpCodeController = TextEditingController();

  GlobalKey<FormState> otpKey = GlobalKey<FormState>();
  List<LoginResponse> otpLoginResponse = [];



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
      var response = await LoginRepository().getLogInOtpConfirmCodeResponse(
          loginController.emailController.text,
          otpCodeController.text,
      );

      otpLoginResponse.add(response);
      print("${otpLoginResponse}");

      AuthHelper().setUserData(response);
      AuthHelper().fetch_and_set();


    }catch(e){
      /// Error
      AppLoaders.errorSnackBar(title: 'oh, Snap', message: e.toString());
    }finally{
      //FullScreenLoader.stopLoading();
      if(otpKey.currentState!.validate()){
        if(otpLoginResponse[0].result == true){
          AppHelperFunctions.showToast(otpLoginResponse[0].message.toString());
        if(forgetPasswordController.isForgotPassword.value != false ){
          Get.to(const NewPassword());
        } else {
          Get.to(const HelloConvexAppBar());
        }
      } else{
          AppHelperFunctions.showToast(otpLoginResponse[0].message.toString());
        }
      }
    }
  }
}