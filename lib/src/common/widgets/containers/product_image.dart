import 'package:flutter/material.dart';
import 'package:torganic/src/common/widgets/containers/card_container.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class AppProductImage extends StatelessWidget {
  const AppProductImage({
    this.height,
    this.width,
    this.border,
    this.onPress,
    this.onCartPress,
    required this.imgUrl,
    this.fit = BoxFit.contain,
    this.boarderRadius = AppSizes.md,
    required this.isNetworkImage ,
    required this.buttonName ,
    required this.backgroundColor,
    super.key,
  });

  final double? height, width;
  final String imgUrl, buttonName;
  final BoxBorder? border;
  final Color backgroundColor;
  final BoxFit? fit;
  final bool isNetworkImage;
  final double boarderRadius;
  final VoidCallback? onPress, onCartPress;

  @override
  Widget build(BuildContext context) {
    return AppCardContainer(
      //height: 200,
     // width: 150,
      applyRadius: false,
      //backgroundColor: Colors.black,
      child: Column(
        children: [
          InkWell(
            onTap: onPress,
            child: AppCardContainer(
              width: 150,
              height: 145,
              applyRadius: false,
              //backgroundColor: Colors.red,
                child: ClipRRect(
                    child: Image(
                      image: isNetworkImage
                          ? NetworkImage(imgUrl)
                          : AssetImage(imgUrl) as ImageProvider,
                      fit: BoxFit.fill,
                    )),
              ),
            ),
           InkWell(
             onTap: onCartPress,
            child: AppCardContainer(
              applyRadius: false,
              height: 40,
              backgroundColor: backgroundColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                const Icon(Icons.shopping_bag_outlined, size: 17, color: AppColors.white,),
                Text(' $buttonName', style: Theme.of(context).textTheme.bodyMedium!.apply(color: AppColors.white))
              ],),
            ),
          )
        ],
      ),
    );
  }
}
