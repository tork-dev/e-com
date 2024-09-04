import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:gap/gap.dart';
import 'package:kirei/src/common/widgets/containers/banner_image.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/home/controller/home_controller.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

class HomeImageTitleAndButtonSection extends StatelessWidget {
  const HomeImageTitleAndButtonSection(
      {super.key,
      required this.imgUrl,
      required this.title,
      required this.subTitle,
      required this.buttonName,
      required this.isNetworkImage,
        required this.isActive,
      required this.buttonWork});

  final String imgUrl, title, subTitle;
  final Widget buttonName;
  final VoidCallback buttonWork;
  final bool isNetworkImage, isActive;

  @override
  Widget build(BuildContext context) {
    final homeController = HomeController.instance;
    return Visibility(
      visible: isActive,
      child: AppCardContainer(
          child: Column(
        children: [
          AppBannerImage(
            isNetworkImage: isNetworkImage,
              imgUrl: imgUrl),
          Padding(
              padding: const EdgeInsets.all(AppSizes.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const Gap(AppSizes.spaceBtwDefaultItems),
                  HtmlWidget(
                    subTitle,
                  ),
                  const Gap(AppSizes.defaultSpace),
                  AppCardContainer(
                      onTap: buttonWork,
                      backgroundColor: AppColors.secondary,
                      applyRadius: false,
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.defaultSpace,
                          vertical: AppSizes.spaceBtwDefaultItems),
                      child: buttonName)
                ],
              )),
        ],
      )),
    );
  }
}
