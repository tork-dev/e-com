// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import 'package:kirei/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
// import 'package:kirei/src/common/styles/spacing_style.dart';
// import 'package:kirei/src/features/home/controller/home_controller.dart';
// import 'package:kirei/src/utils/constants/image_strings.dart';
// import 'package:kirei/src/utils/constants/sizes.dart';
// import '../../../common/widgets/images/banner_image.dart';
// import 'package:carousel_slider/carousel_slider.dart';
//
// import '../../../common/widgets/slider/view/app_slider.dart';
//
// class HomeTwo extends StatelessWidget {
//   const HomeTwo({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(HomeController());
//     return  const AppLayoutWithBackButton(
//       title: Text('back'),
//       body: CustomSlider(
//         items: [
//           AppBannerImage(
//               imgUrl: AppImages.banner1),
//           AppBannerImage(
//               imgUrl: AppImages.banner2),
//           AppBannerImage(
//               imgUrl: AppImages.banner3),
//         ],
//       ),
//     );
//   }
// }
