//
//
// import 'package:flutter/material.dart';
// import 'package:kirei/src/features/details/view/details.dart';
// import 'package:kirei/src/features/personalization/view/profile.dart';
// import 'package:kirei/src/features/shop/view/shop.dart';
// import 'package:kirei/src/features/splash/view/splash_screen.dart';
//
// class RouteGenerator {
//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     ReceivedAction? receiveAction;
//     if (settings.arguments != null && settings.arguments is ReceivedAction) {
//       receiveAction = settings.arguments as ReceivedAction;
//     }
//     switch (settings.name) {
//       case '/':
//         return MaterialPageRoute(builder: (context) => const SplashScreen());
//       case '/shop':
//         return MaterialPageRoute(builder: (context) => const ShopScreen());
//       case '/profile':
//         return MaterialPageRoute(builder: (context) => const ProfileScreen());
//       case '/productDetails':
//         return MaterialPageRoute(
//             builder: (context) => DetailsPage(
//                   productSlug: receiveAction!.body ?? '',
//                 ));
//       default:
//         return _errorRoute();
//     }
//   }
//
//
//   static Route<dynamic> _errorRoute() {
//     return MaterialPageRoute(
//         builder: (context) => Scaffold(
//               body: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text(
//                     'No Page Found 404',
//                     style: Theme.of(context).textTheme.titleLarge,
//                   ),
//                   Text(
//                     'Sorry No Page Found as of Now',
//                     style: Theme.of(context).textTheme.bodyLarge,
//                   )
//                 ],
//               ),
//             ));
//   }
// }
