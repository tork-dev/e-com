//
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:torganic/src/common/styles/spacing_style.dart';
// import 'package:torganic/src/common/widgets/appbar/custom_app_bar.dart';
// import 'package:torganic/src/common/widgets/search_bar/search_bar.dart';
// import 'package:torganic/src/common/widgets/tab_bar/custom_tab_bar.dart';
// import 'package:torganic/src/utils/constants/sizes.dart';
//
// class SliverAppBarTest extends StatelessWidget {
//   const SliverAppBarTest({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         appBar: const CustomAppBar(
//           showBackArrow: true,
//         ),
//         body: NestedScrollView(
//           headerSliverBuilder: (_, innerBoxIsScrolled) {
//             return [
//               SliverAppBar(
//                 pinned: true,
//                 floating: true,
//                 expandedHeight: 440,
//                 automaticallyImplyLeading: false,
//                 //backgroundColor: Colors.red,
//                 flexibleSpace: Padding(
//                   padding: AppSpacingStyle.defaultSpacing,
//                   child: ListView(
//                     children: const [
//                       Gap(AppSizes.spaceBtwSections),
//                       AppSearchBar()
//                     ],
//                   ),
//                 ),
//                 bottom: const AppTabBar(
//                   tabs: [
//                     Tab(
//                       child: Text('sports'),
//                     ),
//                     Tab(
//                       child: Text('sports2'),
//                     ),
//                     Tab(
//                       child: Text('sports3'),
//                     ),
//                   ],
//                 )
//               )
//             ];
//           },
//           body: const TabBarView(
//             children: [
//             Center(child: Text('this is Tab')),
//             Center(child: Text('this is Tab')),
//             Center(child: Text('this is Tab')),
//           ],),
//         ),
//       ),
//     );
//   }
// }
