// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get.dart';
// import 'package:torganic/src/common/widgets/appbar/sliver_app_bar.dart';
// import 'package:torganic/src/features/payment_gateway/bkash/payment_page.dart';
// import 'package:torganic/src/features/pdf_generator/view/pdf.dart';
//
// import '../../common/layouts/layout_with_drawer/layout_with_drawer.dart';
// import '../../common/widgets/buttons/app_buttons.dart';
// import '../../utils/constants/sizes.dart';
// import '../cart/controllers/cart_controller.dart';
// import '../pdf_viewer/view/pdf_screen.dart';
// import '../web_view/web_view.dart';
//
//
// class TesterScreen extends StatelessWidget {
//   const TesterScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(CartController());
//     return AppLayoutWithDrawer(
//       globalKey: controller.cartKey,
//       title: const Text('Cart'),
//       body: RefreshIndicator(
//         onRefresh: (){
//           return Future.delayed(const Duration(seconds: 5));
//         },
//         child: ListView(
//             children: [
//               AppButtons.largeFlatFilledButton(
//                   onPressed: () {
//                     Get.to(() => const PdfScreen(
//                       pdfUrl: 'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
//                     ));
//                   },
//                   buttonText: 'Show pdf'),
//               const Gap(AppSizes.spaceBtwItems),
//               AppButtons.largeFlatFilledButton(
//                   onPressed: () {
//                     Get.to(() =>  WebViewScreen(
//                       url: 'https://www.google.com/',
//                     ));
//                   },
//                   buttonText: 'Show web'),
//               const Gap(AppSizes.spaceBtwItems),
//               AppButtons.largeFlatFilledButton(
//                   onPressed: () {
//                     // Get.to(() => const VideoApp());
//                   },
//                   buttonText: 'Show video'),
//               const Gap(AppSizes.spaceBtwItems),
//               AppButtons.largeFlatFilledButton(
//                   onPressed: () {
//                     Get.to(() => const Payment());
//                   },
//                   buttonText: 'Payment'),
//
//               const Gap(AppSizes.spaceBtwItems),
//               AppButtons.largeFlatFilledButton(
//                   onPressed: () {
//                     Get.to(() => const PdfGenerate());
//                   },
//                   buttonText: 'Generated pdf'),
//
//               const Gap(AppSizes.spaceBtwItems),
//               AppButtons.largeFlatFilledButton(
//                   onPressed: () {
//                     Get.to(() => const SliverAppBarTest());
//                   },
//                   buttonText: 'Show tabs')
//             ]
//         ),
//       ),
//     );
//   }
// }
