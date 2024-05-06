import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:torganic/src/utils/constants/image_strings.dart';
import 'package:torganic/src/utils/helpers/network_manager.dart';
import 'package:torganic/src/utils/popups/loaders.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../utils/popups/full_screen_loader.dart';

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

  Future<void> signUp() async {
    final isConnected = await NetworkManager.instance.isConnected();
    try {
      /// Start Loading
      FullScreenLoader.openLoadingDialog(
          AppLocalizations.of(Get.overlayContext!)!.processing,
          AppImages.loaderAnimation);

      ///Check Internet
      if (!isConnected) return;

      /// Validate Form
      if (!signupFormKey.currentState!.validate()) return;
    } catch (e) {
      /// Error
      AppLoaders.errorSnackBar(title: 'oh, Snap', message: e.toString());
    } finally {
      FullScreenLoader.stopLoading();
    }
  }
}
