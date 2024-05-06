import 'package:flutter/material.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';

class HeaderLogoPart extends StatelessWidget {
  const HeaderLogoPart({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 100,
      width: 100,
      child: Image(
        image: AssetImage(AppImages.darkAppLogo),
        width: AppSizes.imageThumbSize,
      ),
    );
  }
}

