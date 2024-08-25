import 'package:flutter/material.dart';
import 'package:kirei/src/common/widgets/containers/banner_image.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/utils/constants/image_strings.dart';

class HomeSurpriseSection extends StatelessWidget {
  const HomeSurpriseSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(children: [
      AppBannerImage(imgUrl: AppImages.surprisingSectionBg),

    ],);
  }
}

