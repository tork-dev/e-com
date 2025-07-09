import 'package:flutter/material.dart';
import 'package:kirei/src/common/widgets/containers/vertical_product_card.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import '../../../../common/layouts/gridview_layout/gridview_layout.dart';
import '../../../../common/widgets/texts/section_title_text.dart';
import '../../../../utils/constants/colors.dart';

class InfluencerProducts extends StatelessWidget {
  const InfluencerProducts({
    super.key, required this.sectionName,
  });

  final String sectionName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
      child: Column(
        children: [
           AppSectionTitleText(sectionTitle: sectionName, haveTxtButton: false,),
          AppGridViewLayout(
              itemCount: 5,
              mobileAspect: .70,
              tabletAspect: .70,
              desktopAspect: .70,
              builderFunction: (context, index){
                return AppVerticalProductCard(
                    height: 150,
                    width: 150,
                    imgHeight: 150,
                    imgWidth: 150,
                    productName: 'Product Name',
                    buttonColor: AppColors.white,
                    imgUrl: 'https://appbeta.kireibd.com/storage/2022/02/Kojie-San-Facial-Beauty-Soap.jpg',
                    buttonName: 'Add to cart',
                    backgroundColor: AppColors.addToCartButton,
                    isDiscountAvailable: true,
                    discount: 10,
                    ratings: .2,
                    reviews: 10,
                    price: 2500,
                    salePrice: 200,
                    isStockAvailable: true, onTap: () {  }, onCartTap: () {  }, isNetworkImage: true,);
              }
          ),
        ],
      ),
    );
  }
}