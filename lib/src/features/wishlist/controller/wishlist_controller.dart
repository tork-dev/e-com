import 'package:get/get.dart';
import 'package:torganic/src/features/wishlist/model/wishlist_model.dart';
import 'package:torganic/src/features/wishlist/model/wishlist_remove_model.dart';
import 'package:torganic/src/features/wishlist/repositories/wishlist_repositories.dart';
import 'package:torganic/src/utils/helpers/helper_functions.dart';

class WishlistController extends GetxController {
  static WishlistController get instance => Get.find();

  Rx<WishlistResponse> wishlistProducts = WishlistResponse().obs;
  Rx<WishlistRemoveResponse> removeWishlistProductsResponse =
      WishlistRemoveResponse().obs;

  @override
  void onInit() {
    super.onInit();
    onRefresh();
  }

  Future<void> onRefresh() async {
    getWishlistData();
    print('refresh');
  }

  Future<WishlistResponse> getWishlistData() async {
    return wishlistProducts.value =
        await WishlistRepositories().getWishlistProduct();
  }

  Future<WishlistRemoveResponse> deleteWishlistProducts(int id) async {
    return removeWishlistProductsResponse.value = await WishlistRepositories()
        .deleteFromWishlist(id);
  }
}
