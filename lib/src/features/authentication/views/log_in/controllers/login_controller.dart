import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:kirei/src/features/authentication/data/repositories/auth_repositories.dart';
import 'package:kirei/src/features/authentication/views/log_in/model/login_response.dart';
import 'package:kirei/src/features/authentication/views/log_in/model/user_by_token_response.dart';
import 'package:kirei/src/features/authentication/views/log_in/repository/login_repository.dart';
import 'package:kirei/src/utils/firebase/gtm_events.dart';
import 'package:kirei/src/utils/helpers/auth_helper.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';
import 'package:kirei/src/utils/helpers/network_manager.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';
import 'package:kirei/src/utils/logging/logger.dart';
import 'package:kirei/src/utils/popups/loaders.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../../model/resend_code_model.dart';
import '../../forgot_password/view/otp.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../model/social_option_model.dart';

class LogInPageController extends GetxController {
  static LogInPageController get instance => Get.find();
  final String? previousRoute;
  LogInPageController({this.previousRoute = '/home'});

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
  Rx<bool> hittingApi = false.obs;
  Rx<AppLoginResponse> loginResponse = AppLoginResponse().obs;
  Rx<UserByTokenResponse> userDataByToken = UserByTokenResponse().obs;
  Rx<SendOtpCodeResponse> sendOtpResponse = SendOtpCodeResponse().obs;
  Rx<SocialOptionsResponse> socialOptionResponse = SocialOptionsResponse().obs;


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
      AppLoggerHelper.info(loginResponse.value.toString());
      ///Save
      AppLocalStorage()
          .saveData(LocalStorageKeys.isRememberMe, rememberMe.value);
      EventLogger().logLoginEvent('email and Password');
    } catch (e) {
      /// Error
      AppLoaders.errorSnackBar(title: 'oh, Snap', message: e.toString());
      print('login error' + e.toString());
    } finally {
      //FullScreenLoader.stopLoading();
      if (logInFormKey.currentState!.validate()) {
        if (loginResponse.value.result == true) {
          AuthHelper().setUserData(loginResponse.value);
          AppHelperFunctions.showToast(loginResponse.value.message.toString());
          //await getUserDataByToken();
          Get.offAllNamed(previousRoute!);
        } else {
          AppHelperFunctions.showToast(loginResponse.value.message.toString());
        }
      }
    }
  }

  /// Google SignIn with Api
  Future<UserCredential?> onPressedGoogleLogin() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      loginResponse.value = await AuthRepository().getSocialLoginResponse(
          "google", googleUser?.displayName, googleUser?.email, googleUser?.id,
          accessToken: googleAuth?.accessToken);

      if (loginResponse.value.result == false) {
        AppHelperFunctions.showToast('${loginResponse.value.message}');
      } else {
        AppHelperFunctions.showToast('${loginResponse.value.message}');
        AppLocalStorage().saveDataIfNull(LocalStorageKeys.isSocialLogIn, true);

        AuthHelper().setUserData(loginResponse.value);
        Get.offAllNamed(previousRoute!);
        EventLogger().logLoginEvent('Google');
      }
      GoogleSignIn().disconnect();
    } on Exception catch (e) {
      AppHelperFunctions.showSimpleSnackBar(e.toString());
      // TODO
    }
    return null;
  }

////////////////////////facebook login //////////////////////
  Future<UserCredential?> onPressedFacebookLogin() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final AccessToken? accessToken = result.accessToken;
        final userData = await FacebookAuth.instance.getUserData();
        loginResponse.value = await AuthRepository().getSocialLoginResponse(
            "facebook",
            userData["name"].toString(),
            userData["email"].toString(),
            userData["id"].toString(),
            accessToken: accessToken?.tokenString);
        if (loginResponse.value.result == true) {
          EventLogger().logLoginEvent('Facebook');
          Get.offAllNamed(previousRoute!);
          AuthHelper().setUserData(loginResponse.value);
        }
        AppHelperFunctions.showToast(loginResponse.value.message!);
      } else {
        AppHelperFunctions.showToast(result.message!);
      }
    } on Exception catch (e) {
      AppHelperFunctions.showSimpleSnackBar(e.toString());
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
      sendOtpResponse.value = await LoginRepository().getLoginOTPResponse(
        emailController.text.toString(),
      );
    } catch (e) {
      /// Error
      AppLoaders.errorSnackBar(title: 'oh, Snap', message: e.toString());
    } finally {
      if (logInFormKey.currentState!.validate()) {
        if (sendOtpResponse.value.result == true) {
          AppHelperFunctions.showToast(
              sendOtpResponse.value.message.toString());
          Get.to(() => const Otp());
        } else {
          AppHelperFunctions.showToast(
              sendOtpResponse.value.message.toString());
        }
      }
    }
  }

  /// Get User Data By Token
  Future<UserByTokenResponse> getUserDataByToken() async {
    return userDataByToken.value =
        await LoginRepository().getUserByTokenResponse();
  }

  ///////////////////////// Apple Log In /////////////////////////////////////////
  Future<UserCredential?> onPressAppleLogin() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      print(credential);
      loginResponse.value = await AuthRepository().getSocialLoginResponse(
          'apple',
          credential.givenName,
          credential.email,
          credential.authorizationCode,
          accessToken: credential.identityToken);

      if (loginResponse.value.result == true) {
        EventLogger().logLoginEvent('Apple');
        Get.offAllNamed(previousRoute!);
        AuthHelper().setUserData(loginResponse.value);
      }
      AppHelperFunctions.showToast(loginResponse.value.message!);
    } on Exception catch (e) {
      AppHelperFunctions.showSimpleSnackBar(e.toString());
      print("error is ....... $e");
      // TODO
    }
    return null;
  }

// Future<UserCredential> onPressAppleLogin() async {
//   print('apple');
//   try {
//     final rawNonce = generateNonce();
//     final nonce = sha256ofString(rawNonce);
//
//     final appleCredential = await SignInWithApple.getAppleIDCredential(
//       scopes: [
//         AppleIDAuthorizationScopes.email,
//         AppleIDAuthorizationScopes.fullName,
//       ],
//       // webAuthenticationOptions: WebAuthenticationOptions(
//       //   clientId: '6502335026', // Replace with your Client ID
//       //   redirectUri: Uri.parse(
//       //     'https://com.thetork.kirei.firebaseapp.com/__/auth/handler', // Replace with your redirect URI
//       //   ),
//       // ),
//       nonce: nonce,
//     );
//
//
//     final oauthCredential = OAuthProvider("apple.com").credential(
//       idToken: appleCredential.identityToken,
//       rawNonce: rawNonce,
//     );
//
//
//
//     var loginResponse = await AuthRepository().getSocialLoginResponse(
//         "apple", appleCredential.givenName, appleCredential.email, appleCredential.authorizationCode,
//         access_token: appleCredential.identityToken);
//
//     if (loginResponse.result == false) {
//       ToastComponent.showDialog(loginResponse.message, context,
//           gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
//     } else if(loginResponse.result == true) {
//       ToastComponent.showDialog(loginResponse.message, context,
//           gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
//       AuthHelper().setUserData(loginResponse);
//       Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return Main();
//       }));
//     }
//     // GoogleSignIn().disconnect();
//
//     final userCredential = await FirebaseAuth.instance.signInWithCredential(oauthCredential);
//     return userCredential;
//   } catch (e) {
//     print("Error during Apple Sign-In: $e");
//     throw e;
//   }
// }
//
// String generateNonce([int length = 32]) {
//   final charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
//   final random = Random.secure();
//   return List.generate(length, (_) => charset[random.nextInt(charset.length)]).join();
// }
//
// String sha256ofString(String input) {
//   final bytes = utf8.encode(input);
//   final digest = sha256.convert(bytes);
//   return digest.toString();
// }
}
