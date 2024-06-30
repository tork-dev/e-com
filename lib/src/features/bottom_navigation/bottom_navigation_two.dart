// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
// import 'package:kirei/src/features/home/views/product_page.dart';
// import 'package:kirei/src/features/authentication/views/log_in/widgets/login_forms&button.dart';
//
//
// PersistentTabController _controller = PersistentTabController(initialIndex: 0);
//
// class BottomNavigationTwo extends StatelessWidget {
//   const BottomNavigationTwo({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return PersistentTabView(
//         tabs: [
//           PersistentTabConfig(
//             screen: Home(),
//             item: ItemConfig(
//               icon: Icon(Icons.home),
//               title: "Home",
//             ),
//           ),
//           PersistentTabConfig(
//             screen: LogInFormsAndButton(),
//             item: ItemConfig(
//               icon: Icon(Icons.message),
//               title: "Messages",
//             ),
//           ),
//         ],
//         navBarBuilder:(navBarConfig) => Style1BottomNavBar(
//     navBarConfig: navBarConfig));
//   }
// }
//
// // List<Widget> _buildScreens() {
// //   return [
// //     const Home(),
// //     const LogIn(),
// //   ];
// // }
// //
// // List<PersistentBottomNavBarItem> _navBarsItems() {
// //   return [
// //     PersistentBottomNavBarItem(
// //       icon: const Icon(CupertinoIcons.home),
// //       title: ("Home"),
// //       activeColorPrimary: CupertinoColors.activeBlue,
// //       inactiveColorPrimary: CupertinoColors.systemGrey,
// //     ),
// //     PersistentBottomNavBarItem(
// //       icon: const Icon(CupertinoIcons.settings),
// //       title: ("Settings"),
// //       activeColorPrimary: CupertinoColors.activeBlue,
// //       inactiveColorPrimary: CupertinoColors.systemGrey,
// //     ),
// //   ];
// // }
