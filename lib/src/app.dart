import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connection_notifier/connection_notifier.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kirei/src/features/appoinment/model/appointment_model.dart';
import 'package:kirei/src/features/authentication/views/log_in/view/login.dart';
import 'package:kirei/src/features/authentication/views/sign_up/view/signup.dart';
import 'package:kirei/src/features/beauty_tips/view/beauty_tips.dart';
import 'package:kirei/src/features/bottom_navigation/convex-bottom_navigation.dart';
import 'package:kirei/src/features/checkout/model/order_create_model.dart';
import 'package:kirei/src/features/community/view/community_screen.dart';
import 'package:kirei/src/features/details/view/details.dart';
import 'package:kirei/src/features/personalization/view/profile.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:upgrader/upgrader.dart';
import 'features/ai_recommendation/view/skin_care_history/recomedation_screen_one.dart';
import 'features/appoinment/view/appointment_screen.dart';
import 'features/purchase_history/view/purchase_history_details.dart';
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
    return GlobalLoaderOverlay(
      child: GetMaterialApp(
        initialBinding: GeneralBindings(),
        title: AppTexts.appName,
        themeMode: ThemeMode.system,
        theme: MyAppTheme.lightTheme,
        //darkTheme: MyAppTheme.darkTheme,
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
              showReleaseNotes: false,
              child: const SplashScreen(),
            ),
          ),
          GetPage(name: '/login', page: () => const LogIn()),
          GetPage(name: '/register', page: () => const SignUp()),
          GetPage(name: '/home', page: () => const HelloConvexAppBar(pageIndex: 0,)),
          GetPage(name: '/shop', page: () => const HelloConvexAppBar(pageIndex: 1,)),
          GetPage(name: '/cart', page: () => const HelloConvexAppBar(pageIndex: 2,)),
          GetPage(name: '/account', page: () => const HelloConvexAppBar(pageIndex: 3,)),
          GetPage(name: '/product/:id', page: () => const DetailsPage()),
          GetPage(name: '/beauty-tips', page: () => const BeautyTipsScreen()),
          GetPage(name: '/personal-recommendation/skincare-recommendation', page: () => const SkinCareHistoryOne()),
          GetPage(name: '/community', page: () => const CommunityScreen()),
          GetPage(name: '/consult-doctor', page: () => const AppointmentScreen()),
          GetPage(name: '/order/:id', page: () => PurchaseHistoryDetails()),
        ],

        //navigatorKey: navigatorKey,
      ),
    );
  }
}
