import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:kirei/src/features/influencer_store/view/widgets/influencer_header_part.dart';
import '../../../common/layouts/layout_with_refresher/layout_with_refresher.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../controller/influencer_store_controller.dart';
import '../../../common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'widgets/influencer_products.dart';



class InfluencerStore extends StatelessWidget {
  const InfluencerStore({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InfluencerStoreController());
    return AppLayoutWithBackButton(
      padding: 0,
        title: const Text(
          'Influencer store',
          style: TextStyle(color: AppColors.primary),
        ),
        centerTitle: true,
        backToHome: true,
        showBackButton: false,
        showCustomLeading: true,
        customLeadingIcon: Icons.arrow_back,
        leadingOnPress: ()=> Get.offAllNamed('/home'),

        body: AppLayoutWithRefresher(
          onRefresh: controller.onRefresh,
          children:  [
            const InfluencerHeaderPart(),
             Gap(AppSizes.lg),
            InfluencerProducts(sectionName: "Best Selling Products",),
            Gap(AppSizes.lg),
            InfluencerProducts(sectionName: "New Arrivals",),

          ],
        ));
  }
}




