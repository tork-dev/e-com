import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:torganic/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:torganic/src/common/widgets/buttons/app_buttons.dart';
import 'package:torganic/src/common/widgets/containers/card_container.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../styles/spacing_style.dart';

class AppProductImage extends StatelessWidget {
  const AppProductImage({
    this.height,
    this.width,
    this.border,
    this.onPress,
    required this.imgUrl,
    this.fit = BoxFit.contain,
    this.boarderRadius = AppSizes.md,
    this.isNetworkImage = false,
    this.backgroundColor = AppColors.light,
    super.key,
  });

  final double? height, width;
  final String imgUrl;
  final BoxBorder? border;
  final Color backgroundColor;
  final BoxFit? fit;
  final bool isNetworkImage;
  final double boarderRadius;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return AppCardContainer(
      //height: 200,
      width: 150,
      applyRadius: false,
      backgroundColor: Colors.black,
      child: Column(
        children: [
          InkWell(
            onTap: onPress,
            child: AppCardContainer(
              padding: const EdgeInsets.all(AppSizes.sm),
              width: 150,
              height: 145,
              applyRadius: false,
              backgroundColor: Colors.red,
                child: ClipRRect(
                    child: Image(
                      image: isNetworkImage
                          ? NetworkImage(imgUrl)
                          : AssetImage(imgUrl) as ImageProvider,
                      fit: fit,
                    )),
              ),
            ),
          AppButtons.largeFlatFilledButton(onPressed: (){}, buttonText: 'Add To Cart')
        ],
      ),
    );
  }
}
