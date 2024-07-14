import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/layout_with_drawer/layout_with_drawer.dart';
import 'package:kirei/src/common/widgets/containers/banner_image.dart';
import 'package:kirei/src/features/beauty_tips/controller/beauty_tips_controller.dart';
import 'package:kirei/src/features/bottom_navigation/convex-bottom_navigation.dart';
import 'package:kirei/src/features/web_view/web_view.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/image_strings.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:kirei/src/utils/device/device_utility.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';

class BeautyTipsScreen extends StatelessWidget {
  const BeautyTipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BeautyTipsController());
    return AppLayoutWithDrawer(
      backToHome: true,
      isFromOtherPage: true,
        globalKey: controller.beautyKey,
        title: const Text('Beauty Tips', style: TextStyle(color: Colors.blueGrey),),
        backgroundColor: AppColors.white,
        leadingIconColor: AppColors.darkGrey,
        centerTitle: true,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                 AppBannerImage(
                  onPress: (){
                    Get.to(()=> const WebViewScreen(
                        url: 'https://kireibd.com/blogs?type=app',
                        title: 'Blogs'));
                  },
                    imgUrl: AppImages.beautyTipsOne),
                Text('Beauty Blogs', style: Theme.of(context).textTheme.titleMedium,),
                const Gap(AppSizes.spaceBtwSections),
                 AppBannerImage(
                  onPress: (){
                    AppDeviceUtils.browseUrl('https://www.youtube.com/@j-beautybykirei213');
                  },
                    imgUrl: AppImages.kireiYoutube),
                Text('Kirei Youtube', style: Theme.of(context).textTheme.titleMedium),

              ],
            ),
          ),
        ));
  }
}

