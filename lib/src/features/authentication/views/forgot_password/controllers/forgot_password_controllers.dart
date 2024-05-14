
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
      print("Forget password Api Hitting Start");
      var response = await ForgotPasswordRepository().getPasswordForgetResponse(forgotPasswordEmail.toString());
      print("After Api Hitting forget : ${response.toString()}");

      print("list data add");
      forgotPasswordOtpList.add(response);
      print("finish adding data on list");

      isForgotPassword.value = true;

    }catch(e){
      /// Error
      AppLoaders.errorSnackBar(title: 'oh, Snap', message: e.toString());
      print("Problem: ${e.toString()}");
    }finally{
      if(forgotEmailKey.currentState!.validate()){
        //FullScreenLoader.stopLoading();
        print("final stage start");
        if(forgotPasswordOtpList[0].result==true){
          print("initial success");
          AppHelperFunctions.showToast(forgotPasswordOtpList[0].message.toString());
          print("initial success1");
          Get.to(()=> const Otp());
        } else{
          print("initial failed");
          AppHelperFunctions.showToast(forgotPasswordOtpList[0].message.toString());
        }

      }
    }
  }
}