import 'package:get/get.dart';
import 'package:kirei/src/features/wishlist/model/wishlist_model.dart';
import 'package:kirei/src/features/wishlist/model/wishlist_remove_model.dart';
import 'package:kirei/src/features/wishlist/repositories/wishlist_repositories.dart';

import '../../../utils/logging/logger.dart';

class WishlistController extends GetxController {
  static WishlistController get instance => Get.find();

  Rx<WishlistResponse> wishlistProducts = WishlistResponse().obs;
  Rx<WishlistRemoveResponse> removeWishlistProductsResponse =
      WishlistRemoveResponse().obs;
  RxBool isAddedToCart = false.obs;
  RxBool apiHitting = false.obs;

  @override
  void onInit() {
    super.onInit();
    onRefresh();
  }

  Future<void> onRefresh() async {
    getWishlistData();
    Log.d('refresh');
  }

  Future<void> getWishlistData() async {
    apiHitting.value = true;
     wishlistProducts.value =
        await WishlistRepositories().getWishlistProduct();
     apiHitting.value = false;
  }

  Future<WishlistRemoveResponse> deleteWishlistProducts(int id) async {
    return removeWishlistProductsResponse.value = await WishlistRepositories()
        .deleteFromWishlist(id);
  }
}
