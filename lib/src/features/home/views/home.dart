// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:kirei/src/common/styles/spacing_style.dart';
// import 'package:kirei/src/common/widgets/search_bar/search_bar.dart';
// import '../../../common/widgets/appbar/custom_app_bar.dart';
// import '../../../common/widgets/tab_bar/tab_bar.dart';
// import '../../drawer/view/drawer.dart';
//
// class Home extends StatefulWidget {
//   const Home({super.key});
//
//   @override
//   State<Home> createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         showBackArrow: false,
//         leadingIcon: Icons.menu,
//           leadingOnPress: () => _globalKey.currentState!.openDrawer()
//       ),
//         resizeToAvoidBottomInset: true,
//         key: _globalKey,
//         drawer: const NavBar(
//           userName: 'User Name',
//           roll: 'example@email.com',
//         ),
//         body: const Padding(
//           padding: AppSpacingStyle.paddingWithAppBarHeight,
//           child:
//         ));
//   }
// }
