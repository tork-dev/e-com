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
import 'package:kirei/src/utils/helpers/network_manager.dart';

class DependencyInjection {
  static Future init() async{
    Get.lazyPut(()=>OnBoardingController());
    Get.lazyPut(()=>NetworkManager());
    Get.lazyPut(()=>CommonController());
    Get.lazyPut(()=>SplashController());
    Get.lazyPut(()=>LogInPageController());
    Get.lazyPut(()=>SignUpPageController());
    Get.lazyPut(()=>ForgotPasswordController());
    Get.lazyPut(()=>OtpController());
    Get.lazyPut(()=>ConvexBottomNavController());
    Get.lazyPut(()=>HomeController());
    Get.lazyPut(()=>ShopController());
    Get.lazyPut(()=>GetShopDataController());
    Get.lazyPut(()=>CartController());
    Get.lazyPut(()=>UserController());
    Get.lazyPut(()=>AccountDetailsController());
    Get.lazyPut(()=>DetailsPageController());
    Get.lazyPut(()=>RecommendationController());
    Get.lazyPut(()=>AppointmentController());
    Get.lazyPut(()=>CommunityController());
    Get.lazyPut(()=>GroupShoppingController());
    Get.lazyPut(()=>InfluencerStoreController());
    Get.lazyPut(()=>KireiTubeController());
    Get.lazyPut(()=>PurchaseHistoryController());

  }
}