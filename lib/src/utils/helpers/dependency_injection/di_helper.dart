import 'package:get/get.dart';
import 'package:kirei/src/common/controller/common_controller.dart';
import 'package:kirei/src/features/ai_recommendation/controller/recommendation_controller.dart';
import 'package:kirei/src/features/appoinment/controller/appointment_controller.dart';
import 'package:kirei/src/features/authentication/views/forgot_password/controllers/forgot_password_controllers.dart';
import 'package:kirei/src/features/authentication/views/forgot_password/controllers/otp_controller.dart';
import 'package:kirei/src/features/authentication/views/log_in/controllers/login_controller.dart';
import 'package:kirei/src/features/authentication/views/sign_up/controllers/signup_controller.dart';
import 'package:kirei/src/features/bottom_navigation/convex_controller.dart';
import 'package:kirei/src/features/cart/controllers/cart_controller.dart';
import 'package:kirei/src/features/community/controller/community_controller.dart';
import 'package:kirei/src/features/details/controller/details_page_controller.dart';
import 'package:kirei/src/features/group_shopping/controller/group_shopping_controller.dart';
import 'package:kirei/src/features/home/controller/home_controller.dart';
import 'package:kirei/src/features/influencer_store/controller/influencer_store_controller.dart';
import 'package:kirei/src/features/kirei_tube/controller/kirei_tube_controller.dart';
import 'package:kirei/src/features/on_boarding/controllers/on_boarding_controller.dart';
import 'package:kirei/src/features/personalization/controller/account_details_controller.dart';
import 'package:kirei/src/features/personalization/controller/user_controller.dart';
import 'package:kirei/src/features/purchase_history/controller/purchase_history_controller.dart';
import 'package:kirei/src/features/shop/controller/get_shop_data_controller.dart';
import 'package:kirei/src/features/shop/controller/shop_controller.dart';
import 'package:kirei/src/features/splash/controller/splash_controller.dart';
import '../../../features/spinner_wheel/controller/spinner_controller.dart';
import '../network_manager.dart';

class DependencyInjection extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<OnBoardingController>(()=>OnBoardingController());
    Get.lazyPut<NetworkManager>(()=>NetworkManager());
    Get.put(CommonController());
    Get.lazyPut<SplashController>(()=>SplashController());
    Get.lazyPut<SpinnerController>(()=>SpinnerController());
    Get.lazyPut<LogInPageController>(()=>LogInPageController());
    Get.lazyPut<SignUpPageController>(()=>SignUpPageController());
    Get.lazyPut<ForgotPasswordController>(()=>ForgotPasswordController());
    Get.lazyPut<OtpController>(()=>OtpController());
    Get.lazyPut<ConvexBottomNavController>(()=>ConvexBottomNavController());
    Get.lazyPut<HomeController>(()=>HomeController());
    Get.lazyPut<ShopController>(()=>ShopController());
    Get.lazyPut<GetShopDataController>(()=>GetShopDataController());
    Get.lazyPut<CartController>(()=>CartController());
    Get.lazyPut<UserController>(()=>UserController());
    Get.lazyPut<AccountDetailsController>(()=>AccountDetailsController());
    Get.lazyPut<DetailsPageController>(()=>DetailsPageController());
    Get.lazyPut<RecommendationController>(()=>RecommendationController());
    Get.lazyPut<AppointmentController>(()=>AppointmentController());
    Get.lazyPut<CommunityController>(()=>CommunityController());
    Get.lazyPut<GroupShoppingController>(()=>GroupShoppingController());
    Get.lazyPut<InfluencerStoreController>(()=>InfluencerStoreController());
    Get.lazyPut<KireiTubeController>(()=>KireiTubeController());
    Get.lazyPut<PurchaseHistoryController>(()=>PurchaseHistoryController());

  }
}