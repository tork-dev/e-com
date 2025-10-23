import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kirei/main.dart';
import 'package:kirei/src/features/authentication/views/log_in/view/login.dart';
import 'package:kirei/src/features/authentication/views/sign_up/view/signup.dart';
import 'package:kirei/src/features/beauty_tips/view/beauty_tips.dart';
import 'package:kirei/src/features/blogs/view/blogs.dart';
import 'package:kirei/src/features/bottom_navigation/convex_bottom_navigation.dart';
import 'package:kirei/src/features/bottom_navigation/google_nav_bar.dart';
import 'package:kirei/src/features/community/view/community_screen.dart';
import 'package:kirei/src/features/details/view/details.dart';
import 'package:kirei/src/features/group_shopping/view/group_shopping_screen.dart';
import 'package:kirei/src/features/reward_point/view/reward_details_screen.dart';
import 'package:kirei/src/features/web_view/web_view.dart';
import 'package:kirei/src/utils/helpers/dependency_injection/di_helper.dart';
import 'features/ai_recommendation/view/kaira_chat_bot.dart';
import 'features/ai_recommendation/view/recommended_products.dart';
import 'features/ai_recommendation/view/skin_care_history/recomedation_screen_one.dart';
import 'features/appoinment/view/appointment_screen.dart';
import 'features/group_shopping/view/group_shopping_payment_screen.dart';
import 'features/home/bindings/home_bindings.dart';
import 'features/kirei_tube/view/kirei_tube_screen.dart';
import 'features/kirei_tube/view/kirei_tube_shorts_screen.dart';
import 'features/personalization/view/account_details.dart';
import 'features/purchase_history/view/purchace_history.dart';
import 'features/purchase_history/view/purchase_history_details.dart';
import 'features/reward_point/view/point_history_screen.dart';
import 'features/reward_point/view/point_level_screen.dart';
import 'features/reward_point/view/point_redemption_screen.dart';
import 'features/reward_point/view/reward_screen.dart';
import 'features/shop/view/hot_deals_screen.dart';
import 'features/splash/view/splash_screen.dart';
import './utils/theme/theme.dart';
import './utils/constants/text_strings.dart';
import 'features/wishlist/view/wishlist.dart';
import 'l10n/app_localizations.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Create an instance of FirebaseAnalytics
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    final String baseUrlWeb = dotenv.env["BASE_URL_WEB"]!;
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      initialBinding: DependencyInjection(),
      title: AppTexts.appName,
      themeMode: ThemeMode.light,
      theme: MyAppTheme.lightTheme,
      darkTheme: MyAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      locale: const Locale('en'),
      localizationsDelegates: const [
        ...AppLocalizations.localizationsDelegates,// Add this line
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
          page: () => const SplashScreen(),
        ),
        GetPage(name: '/login', page: () => const LogIn()),
        GetPage(name: '/register', page: () => const SignUp()),
        GetPage(
            name: '/home',
            binding: HomeBinding(),
            page: () => const GoogleNavBar(
                  pageIndex: 0,
                )),
        GetPage(
            name: '/shop',
            page: () => const GoogleNavBar(
                  pageIndex: 1,
                )),
        GetPage(
            name: '/cart',
            page: () => const GoogleNavBar(
                  pageIndex: 2,
                )),
        GetPage(
            name: '/account',
            page: () => const GoogleNavBar(
                  pageIndex: 3,
                )),
        GetPage(name: '/account-details', page: () => const AccountDetailsScreen()),
        GetPage(name: '/product/:slug', page: () => const DetailsPage()),
        GetPage(name: '/beauty-tips', page: () => const BeautyTipsScreen()),
        GetPage(
            name: '/personal-recommendation',
            page: () => const AppKairaChatBot()),
        GetPage(name: "/community", page: () => const CommunityScreen()),
        GetPage(name: '/consult-doctor', page: () => const AppointmentScreen()),
        GetPage(name: '/orders-details', page: () => const PurchaseHistory()),
        GetPage(name: '/order/:id', page: () => const PurchaseHistoryDetails()),
        GetPage(
            name: '/about-us',
            page: () => WebViewScreen(
                url: '$baseUrlWeb/about-us?type=app', title: 'Who We Are?')),
        GetPage(
            name: '/faq',
            page: () =>
                WebViewScreen(url: '$baseUrlWeb/faq?type=app', title: 'FAQs')),
        GetPage(
            name: '/contact-us',
            page: () => WebViewScreen(
                url: '$baseUrlWeb/contact?type=app', title: 'Contact Us')),
        GetPage(
            name: '/testimonials',
            page: () => WebViewScreen(
                url: '$baseUrlWeb/testimonials?type=app',
                title: 'Testimonials')),
        GetPage(
            name: '/privacy-policy',
            page: () => WebViewScreen(
                url: '$baseUrlWeb/privacy-policy?type=app',
                title: 'Privacy & Policy')),
        GetPage(
            name: '/term-condition',
            page: () => WebViewScreen(
                url: '$baseUrlWeb/term-condition?type=app',
                title: 'Terms & Conditions')),
        GetPage(
            name: '/return-refund',
            page: () => WebViewScreen(
                url: '$baseUrlWeb/return-refund?type=app',
                title: 'Returns & Refunds')),
        GetPage(
            name: '/responsible-disclosure',
            page: () => WebViewScreen(
                url: '$baseUrlWeb/responsible-disclosure?type=app',
                title: 'Responsible Disclosure')),
        GetPage(
            name: '/reward-details',
            page: () => const RewardDetailsPage()),
        GetPage(name: '/reward', page: () => const RewardScreen()),
        GetPage(name: '/point-redemption', page: () => const PointRedemption()),
        GetPage(
            name: '/reward-levels', page: () => const RewardPointLevelScreen()),
        GetPage(
            name: '/point-history',
            page: () => const RewardPointHistoryScreen()),
        GetPage(name: '/kirei-tube', page: () => const KireiTubeScreen()),
        GetPage(
            name: '/group-shopping', page: () => const GroupShoppingScreen()),
        GetPage(
            name: '/group-shopping/:id',
            page: () => const GroupShoppingPaymentScreen()),
        // GetPage(
        //     name: '/recommended-products',
        //     page: () => const RecommendedProducts()),
        GetPage(
            name: '/kirei-tube/:id',
            page: () => const KireiTubeShortsDetailsScreen()),
        GetPage(
            name: '/wishlist', page: () => const WishlistScreen()),
        GetPage(
            name: '/hot-deals', page: () => const HotDealsScreen()),
        GetPage(
            name: '/blogs', page: () => const Blogs()),
        // GetPage(name: '/influencer-store', page: ()=> const InfluencerStore())
      ],
    );
  }
}
