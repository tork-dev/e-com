import 'package:flutter/material.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';

class HeaderLogoPart extends StatelessWidget {
  const HeaderLogoPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 80,
          width: 80,
          child: Image(
            image: AssetImage(AppImages.lightAppLogo),
            width: AppSizes.imageThumbSize,
          ),
        ),
        SizedBox(
          width: 250,
            child: Text(
              textAlign: TextAlign.center,
              "Your reliable care partner for authentic beauty", style: Theme.of(context).textTheme.titleLarge,))
      ],
    );
  }
}

