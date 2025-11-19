import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/layout_with_drawer/layout_with_drawer.dart';
import 'package:kirei/src/common/widgets/containers/banner_image.dart';
import 'package:kirei/src/features/beauty_tips/controller/beauty_tips_controller.dart';
import 'package:kirei/src/features/web_view/web_view.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/image_strings.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:kirei/src/utils/helpers/env_config.dart';

class BeautyTipsScreen extends StatelessWidget {
  const BeautyTipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BeautyTipsController());
    final String baseUrlWeb = EnvConfig.baseUrlWeb;
    return AppLayoutWithDrawer(
      backToHome: true,
      isFromOtherPage: true,
        globalKey: controller.beautyKey,
        title: const Text('Beauty Tips', style: TextStyle(color: AppColors.backLayoutAppBarTitle),),
        backgroundColor: AppColors.white,
        leadingIconColor: AppColors.darkGrey,
        centerTitle: true,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                 AppBannerImage(
                  onPress: (){
                    Get.to(()=> WebViewScreen(
                        url: '$baseUrlWeb/blogs?app=true',
                        title: 'Blogs'));
                  },
                    imgUrl: AppImages.beautyTipsOne),
                Text('Beauty Blogs', style: Theme.of(context).textTheme.titleMedium,),
                const Gap(AppSizes.spaceBtwSections),
                 AppBannerImage(
                  onPress: (){
                    Get.toNamed('/kirei-tube');
                  },
                    imgUrl: AppImages.kireiYoutube),
                Text('KireiTube', style: Theme.of(context).textTheme.titleMedium),

              ],
            ),
          ),
        ));
  }
}

