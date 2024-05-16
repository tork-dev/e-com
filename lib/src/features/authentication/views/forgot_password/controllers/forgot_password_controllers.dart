
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:torganic/src/features/authentication/views/forgot_password/repository/forgot_password_repository.dart';
import 'package:torganic/src/features/authentication/views/forgot_password/view/otp.dart';
import 'package:torganic/src/features/bottom_navigation/bottom_navigation.dart';
import 'package:torganic/src/features/home/views/home.dart';
import 'package:torganic/src/utils/constants/image_strings.dart';
import 'package:torganic/src/utils/helpers/network_manager.dart';
import 'package:torganic/src/utils/popups/loaders.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../../../utils/popups/full_screen_loader.dart';
import '../model/forgot_password_reponse.dart';

class ForgotPasswordController extends GetxController{
  static ForgotPasswordController get instance => Get.find();

  ///Controllers
  final forgotPasswordEmail = TextEditingController();

  RxBool isForgotPassword = false.obs;

  GlobalKey<FormState> forgotEmailKey = GlobalKey<FormState>();

  List<ForgotPasswordResponse> forgotPasswordOtpList = [];



  Future<void> sendCode() async{
    final isConnected = await NetworkManager.instance.isConnected();
    try{
      ///Check Internet
      if(!isConnected) return;

      /// Validate Form
      if(!forgotEmailKey.currentState!.validate()) return;

      /// Start Loading
      //FullScreenLoader.openLoadingDialog('Processing', AppImages.loading);

      ///Api calling
      var response = await ForgotPasswordRepository().getForgetPasswordResponse(forgotPasswordEmail.text);

      forgotPasswordOtpList.add(response);

      isForgotPassword.value = true;

    }catch(e){
      /// Error
      AppLoaders.errorSnackBar(title: 'oh, Snap', message: e.toString());
      //print("Problem: ${e.toString()}");
    }finally{
      if(forgotEmailKey.currentState!.validate()){
        //FullScreenLoader.stopLoading();
        if(forgotPasswordOtpList[0].result==true){
          AppHelperFunctions.showToast(forgotPasswordOtpList[0].message.toString());
          Get.to(()=> const Otp());
        } else{
          AppHelperFunctions.showToast(forgotPasswordOtpList[0].message.toString());
        }

      }
    }
  }
}