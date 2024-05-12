import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:torganic/src/common/layouts/listview_layout/listview_layout.dart';
import '../../../../common/widgets/containers/banner_image.dart';
import '../../../../common/widgets/containers/card_container.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';


class AppCartProductCard extends StatelessWidget {
  const AppCartProductCard({required this.onTap,super.key});

  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return AppListViewLayout(
      itemCount: 10,
      builderFunction: (context, index) => AppCardContainer(
        onTap: onTap,
        backgroundColor: AppColors.white,
        applyRadius: false,
        padding: const EdgeInsets.all(AppSizes.sm),
        child:  Row(
          children: [
            const AppBannerImage(
                height: 100,
                width: 100,
                applyImageRadius: false,
                isNetworkImage: true,
                imgUrl: 'https://appbeta.kireibd.com/storage/all/Mentham-Medicated-Moisturizing-Lipstick-Sakura-10.png'),
            const Gap(AppSizes.spaceBtwRowItem),
            AppCardContainer(
                width: 200,
                height: 100,
                //backgroundColor: AppColors.secondary,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Mentham Medicated Moisturizing Lipstick Sakura',
                      style: TextStyle(
                          fontSize: 16
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis, ),
                    const Gap(AppSizes.spaceBtwRowItem),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('৳850.00', style: Theme.of(context).textTheme.titleMedium,),
                        const Icon(Icons.delete_forever_outlined)
                      ],
                    )
                  ],
                )),
            const Gap(AppSizes.spaceBtwSections),
            const AppCardContainer(
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.add),
                    AppCardContainer(
                        height: 25,
                        width: 25,
                        applyRadius: false,
                        borderWidth: 1,
                        hasBorder: true,
                        borderColor: AppColors.secondary,
                        child: Center(child: Text('1'))),
                    Icon(Icons.remove),
                  ],
                ))
        
          ],
        ),
      ),
    );
  }
}



