import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:torganic/src/features/authentication/data/repositories/auth_repositories.dart';
import 'package:torganic/src/features/authentication/views/log_in/model/login_response.dart';
import 'package:torganic/src/features/authentication/views/log_in/model/user_by_token_response.dart';
import 'package:torganic/src/features/authentication/views/log_in/repository/login_repository.dart';
import 'package:torganic/src/features/bottom_navigation/bottom_navigation.dart';
import 'package:torganic/src/features/bottom_navigation/convex-bottom_navigation.dart';
import 'package:torganic/src/features/personalization/controller/user_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:torganic/src/utils/constants/colors.dart';
import 'package:torganic/src/utils/constants/app_api_end_points.dart';
import 'package:torganic/src/utils/constants/image_strings.dart';
import 'package:torganic/src/utils/helpers/auth_helper.dart';
import 'package:torganic/src/utils/helpers/helper_functions.dart';
import 'package:torganic/src/utils/helpers/network_manager.dart';
import 'package:torganic/src/utils/local_storage/local_storage_keys.dart';
import 'package:torganic/src/utils/local_storage/storage_utility.dart';
import 'package:torganic/src/utils/popups/loaders.dart';
import '../../../../../utils/http/http_client.dart';
import '../../../../../utils/popups/full_screen_loader.dart';
import '../../forgot_password/view/otp.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LogInPageController extends GetxController {
  static LogInPageController get instance => Get.find();

  //final userController = Get.put(UserController());

  ///Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  GlobalKey<FormState> logInFormKey = GlobalKey<FormState>();

  //final authController = Get.put(AuthRepositories());

  /// variables
  Rx<bool> loginWithPassword = false.obs;
  Rx<bool> passwordObscured = true.obs;
  Rx<bool> rememberMe = false.obs;
  Rx<AppLoginResponse> loginResponse = AppLoginResponse().obs;
  Rx<UserByTokenResponse> userDataByToken = UserByTokenResponse().obs;


  // List<LoginOtpResponse> otpLoginList = [];

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  /// Log in with email and password
  Future<void> emailPasswordLogIn() async {
    final isConnected = await NetworkManager.instance.isConnected();
    try {
      /// Validate Form
      if (!logInFormKey.currentState!.validate()) return;

      ///Check Internet
      if (!isConnected) return;

      /// Start Loading
      // FullScreenLoader.openLoadingDialog(
      //     AppLocalizations.of(Get.overlayContext!)!.processing,
      //     AppImages.loading);

      ///Api Calling
      loginResponse.value = await LoginRepository().getLoginResponse(
        emailController.text.toString(),
        passwordController.text.toString(),
        rememberMe.value,
      );
      ///Save
      AppLocalStorage()
          .saveData(LocalStorageKeys.isRememberMe, rememberMe.value);
    } catch (e) {
      /// Error
      AppLoaders.errorSnackBar(title: 'oh, Snap', message: e.toString());
      print('login error' + e.toString());
    }
    finally {
      //FullScreenLoader.stopLoading();
      if (logInFormKey.currentState!.validate()) {
        if (loginResponse.value.result == true) {
          AuthHelper().setUserData(loginResponse.value);
          AppHelperFunctions.showToast(loginResponse.value.message.toString());
          //await getUserDataByToken();
          Get.offAll(const HelloConvexAppBar());
        } else {
          AppHelperFunctions.showToast(loginResponse.value.message.toString());
        }
      }
    }
  }


  /// Google SignIn with Api
  Future<UserCredential?> onPressedGoogleLogin() async {
    try {
      FullScreenLoader.openLoadingDialog("Processing", AppImages.loading);

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // final credential = GoogleAuthProvider.credential(
      //   accessToken: googleAuth?.accessToken,
      //   idToken: googleAuth?.idToken,
      // );

      var loginResponse = await AuthRepository().getSocialLoginResponse(
          "google", googleUser?.displayName, googleUser?.email, googleUser?.id,
          accessToken: googleAuth?.accessToken);

      if (loginResponse.result == false) {
        AppHelperFunctions.showSimpleSnackBar('${loginResponse.message}');
      } else {
        AppHelperFunctions.showSimpleSnackBar('${loginResponse.message}');
        AppLocalStorage().saveDataIfNull(LocalStorageKeys.isGoogleLogIn, true);

        //AuthHelper().setUserData(loginResponse);
        Get.offAll(() => const BottomNavigation());
      }
      GoogleSignIn().disconnect();
    } on Exception catch (e) {
      AppHelperFunctions.showSimpleSnackBar(e.toString());
      print("error is ....... $e");
      // TODO
    }
    return null;
  }


  /// Login with OTP
  Future<void> sendCode() async {
    final isConnected = await NetworkManager.instance.isConnected();
    try {
      ///Check Internet
      if (!isConnected) return;

      /// Validate Form
      if (!logInFormKey.currentState!.validate()) return;

      /// Start Loading
      // FullScreenLoader.openLoadingDialog('Processing', AppImages.loading);

      ///Api Calling
      loginResponse.value = await LoginRepository().getLoginOTPResponse(
        emailController.text.toString(),
      );
      print("data: ${loginResponse.value.toString()}");
    } catch (e) {
      /// Error
      AppLoaders.errorSnackBar(title: 'oh, Snap', message: e.toString());
    } finally {
      if (logInFormKey.currentState!.validate()) {
        if (loginResponse.value.result == true) {
          AppHelperFunctions.showToast(loginResponse.value.message.toString());
          Get.to(() => const Otp());
        } else {
          AppHelperFunctions.showToast(loginResponse.value.message.toString());
        }
      }
    }
  }

  /// Get User Data By Token
  Future<UserByTokenResponse> getUserDataByToken() async {
    return userDataByToken.value = await LoginRepository()
        .getUserByTokenResponse();
  }

}
