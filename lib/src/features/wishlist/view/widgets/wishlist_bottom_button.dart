import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/features/bottom_navigation/convex_controller.dart';
import 'package:kirei/src/features/wishlist/controller/wishlist_controller.dart';
import '../../../../common/widgets/containers/card_container.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';


class AppWishlistBottomButton extends StatelessWidget {
  const AppWishlistBottomButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bottomNavController = ConvexBottomNavController.instance;
    final wishlistController = WishlistController.instance;
      return  Row(
        children: [
          AppCardContainer(
              onTap: (){
                Get.back();
                bottomNavController.jumpToTab(0);
              },
              height: 50,
              width: AppHelperFunctions.screenWidth() / 2,
              applyRadius: false,
              backgroundColor: AppColors.secondary,
              child: Center(
                  child: Text('HOME',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .apply(color: AppColors.white)))),
          Obx(() {
              return AppCardContainer(
                  onTap: (){
                    Get.back();
                   if(wishlistController.isAddedToCart.value == true){
                     bottomNavController.jumpToTab(2);
                   }
                  },
                  height: 50,
                  width: AppHelperFunctions.screenWidth() / 2,
                  applyRadius: false,
                  backgroundColor: !wishlistController.isAddedToCart.value? AppColors.primary : Colors.orange,
                  child: Center(
                      child: Text(
                        !wishlistController.isAddedToCart.value?
                          'PROFILE' : 'GO TO CART',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .apply(color: AppColors.white))));
            }
          ),
        ],
      );
  }
}
