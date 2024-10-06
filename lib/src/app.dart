import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kirei/src/features/authentication/views/log_in/view/login.dart';
import 'package:kirei/src/features/authentication/views/sign_up/view/signup.dart';
import 'package:kirei/src/features/beauty_tips/view/beauty_tips.dart';
import 'package:kirei/src/features/bottom_navigation/convex-bottom_navigation.dart';
import 'package:kirei/src/features/community/view/community_screen.dart';
import 'package:kirei/src/features/details/view/details.dart';
import 'package:kirei/src/features/group_shopping/view/group_shopping_screen.dart';
import 'package:kirei/src/features/influencer_store/view/influencer_screen.dart';
import 'package:kirei/src/features/web_view/web_view.dart';
import 'package:kirei/src/update_controller.dart';
import 'package:upgrader/upgrader.dart';
import 'features/ai_recommendation/view/skin_care_history/recomedation_screen_one.dart';
import 'features/appoinment/view/appointment_screen.dart';
import 'features/details/bindings/details_bindings.dart';
import 'features/group_shopping/view/group_shopping_payment_screen.dart';
import 'features/kirei_tube/view/kirei_tube_details.dart';
import 'features/kirei_tube/view/kirei_tube_screen.dart';
import 'features/purchase_history/view/purchase_history_details.dart';
import 'features/reward_point/view/point_history_screen.dart';
import 'features/reward_point/view/point_level_screen.dart';
import 'features/reward_point/view/point_redemption_screen.dart';
import 'features/reward_point/view/reward_screen.dart';
import 'features/splash/view/splash_screen.dart';
import './utils/theme/theme.dart';
import './utils/constants/text_strings.dart';
import 'common/bindings/general_bindings.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Create an instance of FirebaseAnalytics
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        // navigatorKey: navigatorKey,
        initialBinding: GeneralBindings(),
        title: AppTexts.appName,
        themeMode: ThemeMode.light,
        theme: MyAppTheme.lightTheme,
        darkTheme: MyAppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        locale: const Locale('en'),
        localizationsDelegates: const [
          AppLocalizations.delegate, // Add this line
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'), // English
          Locale('es'), // Spanish
        ],
        initialRoute: '/',
        navigatorObservers: [observer],
        getPages: [
          GetPage(
            name: '/',
            page: () => UpgradeAlert(
              upgrader: Upgrader(
                storeController: CustomUpgraderStoreController(),
                // debugDisplayAlways: true, // Always show upgrade dialog for testing
                // debugLogging: true, // Enable logging to see more details
              ),
              showReleaseNotes: false,
              child: const SplashScreen(),
            ),
          ),
          GetPage(name: '/login/:prevRoute', page: () => const LogIn()),
          GetPage(name: '/register', page: () => const SignUp()),
          GetPage(name: '/home', page: () => const HelloConvexAppBar(pageIndex: 0,)),
          GetPage(name: '/shop', page: () => const HelloConvexAppBar(pageIndex: 1,)),
          GetPage(name: '/cart', page: () => const HelloConvexAppBar(pageIndex: 2,)),
          GetPage(name: '/account', page: () => const HelloConvexAppBar(pageIndex: 3,)),
          GetPage(name: '/product/:id', page: () => const DetailsPage() ),
          GetPage(name: '/beauty-tips', page: () => const BeautyTipsScreen()),
          GetPage(name: '/personal-recommendation', page: () => const SkinCareHistoryOne()),
          GetPage(name: '/community', page: () => const CommunityScreen()),
          GetPage(name: '/consult-doctor', page: () => const AppointmentScreen()),
          GetPage(name: '/order/:id', page: () => const PurchaseHistoryDetails()),
          GetPage(name: '/blogs', page: () => const WebViewScreen(url: 'https://kireibd.com/blogs?type=app', title: 'Bogs')),
          GetPage(name: '/about-us', page: () => const WebViewScreen(url: 'https://kireibd.com/about-us?type=app', title: 'Who We Are?')),
          GetPage(name: '/faq', page: () => const WebViewScreen(url: 'https://kireibd.com/faq?type=app', title: 'FAQs')),
          GetPage(name: '/contact-us', page: () => const WebViewScreen(url: 'https://kireibd.com/contact-us?type=app', title: 'Contact Us')),
          GetPage(name: '/testimonials', page: () => const WebViewScreen(url: 'https://kireibd.com/testimonials?type=app', title: 'Testimonials')),
          GetPage(name: '/testimonials', page: () => const WebViewScreen(url: 'https://kireibd.com/testimonials?type=app', title: 'Testimonials')),
          GetPage(name: '/privacy-policy', page: () => const WebViewScreen(url: 'https://kireibd.com/privacy-policy?type=app', title: 'Privacy & Policy')),
          GetPage(name: '/term-condition', page: () => const WebViewScreen(url: 'https://kireibd.com/term-condition?type=app', title: 'Terms & Conditions')),
          GetPage(name: '/return-refund', page: () => const WebViewScreen(url: 'https://kireibd.com/return-refund?type=app', title: 'Returns & Refunds')),
          GetPage(name: '/responsible-disclosure', page: () => const WebViewScreen(url: 'https://kireibd.com/responsible-disclosure?type=app', title: 'Responsible Disclosure')),
          GetPage(name: '/responsible-disclosure', page: () => const WebViewScreen(url: 'https://kireibd.com/responsible-disclosure?type=app', title: 'Responsible Disclosure')),
          GetPage(name: '/reward', page: ()=> const RewardScreen()),
          GetPage(name: '/point-redemption', page: ()=> const PointRedemption()),
          GetPage(name: '/reward-levels', page: ()=> const RewardPointLevelScreen()),
          GetPage(name: '/point-history', page: ()=> const RewardPointHistoryScreen()),
          GetPage(name: '/kirei-tube', page: ()=> const KireiTubeScreen()),
          GetPage(name: '/kirei-tube/:id', page: ()=> const KireiTubeDetailsScreen()),
          GetPage(name: '/group-shopping', page: ()=> const GroupShoppingScreen()),
          GetPage(name: '/group-shopping/:id', page: ()=> const GroupShoppingPaymentScreen()),
          GetPage(name: '/influencer-store', page: ()=> const InfluencerStore())
        ],

        //navigatorKey: navigatorKey,
    );
  }
}
