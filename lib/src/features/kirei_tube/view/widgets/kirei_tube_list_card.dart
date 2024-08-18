import 'package:flutter/material.dart';
import 'package:kirei/src/common/widgets/containers/banner_image.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/kirei_tube/controller/kirei_tube_controller.dart';
import 'package:kirei/src/features/kirei_tube/view/kirei_tube_screen.dart';
import 'package:kirei/src/utils/constants/colors.dart';

class KireiTubeListCard extends StatelessWidget {
  const KireiTubeListCard({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    final kireiTubeController = KireiTubeController.instance;
    return AppCardContainer(
      backgroundColor: AppColors.addToCartButton,
        applyRadius: false,
        child: Column(
          children: [
            Stack(
              children: [
                AppBannerImage(
                  applyImageRadius: false,
                  // height: 88,
                    fit: BoxFit.cover,
                    isNetworkImage: true,
                    imgUrl: kireiTubeController.videoList.value.data![index].banner),
              ],
            )
          ],
        ));
  }
}
