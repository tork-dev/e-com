import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kirei/src/features/details/repositories/details_repositories.dart';
import 'package:kirei/src/features/home/controller/home_controller.dart';
import 'package:kirei/src/features/home/repositories/home_repositories.dart';
import 'package:kirei/src/features/wishlist/model/wishlist_remove_model.dart';
import 'package:kirei/src/features/wishlist/repositories/wishlist_repositories.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';

import '../../wishlist/model/wish_list_add_model.dart';
import '../model/product_details_model.dart';
import '../model/products_model.dart';

class DetailsPageController extends GetxController {
  static DetailsPageController get instance => Get.find();

  final homeController = HomeController.instance;

  DetailsPageController({
    required this.productSlug
  });

  final String productSlug;

  /// Image SwapPing
  RxInt pictureIndex = 0.obs;
  RxBool viewMore = false.obs;
  RxBool apiHitting = true.obs;

  RxInt productCount = 1.obs;
  RxBool isAddedToCart = false.obs;

  Rx<ProductDetailsResponse> productDetails = ProductDetailsResponse().obs;
  Rx<WishListAddResponse> addToWishlist = WishListAddResponse().obs;
  Rx<WishListAddResponse> checkWishList = WishListAddResponse().obs;
  Rx<WishListAddResponse> removeFromWishList = WishListAddResponse().obs;
  Rx<DetailsProductsResponse> relatedProductsResponse = DetailsProductsResponse().obs;
  Rx<DetailsProductsResponse> recommendedProductsResponse = DetailsProductsResponse().obs;


  @override
  void onInit() {
    super.onInit();
    onRefresh();
  }

  Future<void> onRefresh() async{
     await getProductDetails();
     await getRelatedProducts();
     await getRecommendedProducts();
    if(AppLocalStorage().readData(LocalStorageKeys.isLoggedIn) == true) {
      await checkWishListAdd();
    }
  }

  void getLargePicture(index) {
    pictureIndex.value = index;
  }

  Future<ProductDetailsResponse> getProductDetails() async {
    return productDetails.value =
        await DetailsRepositories.getProductDetails(productSlug);
  }

  void onAddButtonTap() {
    if(productCount.value < productDetails.value.detailedProducts!.stock!) {
      productCount.value++;
    }else{
      AppHelperFunctions.showToast("Can't order more than ${productDetails.value.detailedProducts!.stock!}");
    }
  }

  void onRemoveButtonTap() {
    if(productCount.value > 1) {
      productCount.value--;
    }else{
      AppHelperFunctions.showToast("Minimum order value is 1");
    }
  }

  Future<void> onAddToCart() async {
    homeController
        .getAddToCartResponse(
            productDetails.value.detailedProducts!.id!,
            productCount.value,
            productDetails.value.detailedProducts!.preorderAvailable!)
        .then((value) => {
          isAddedToCart.value = true,
          AppHelperFunctions.showToast(homeController.addToCartResponse.value.message!),
            });
  }

  Future<WishListAddResponse> getWishListAdd()async{
    return addToWishlist.value = await WishlistRepositories().addToWishList(productId: productDetails.value.detailedProducts!.id!);
  }
  Future<WishListAddResponse> checkWishListAdd()async{
    return checkWishList.value = await WishlistRepositories().isProductInUserWishList(productId: productDetails.value.detailedProducts!.id!);
  }
  Future<WishListAddResponse> wishListRemove()async{
    return removeFromWishList.value = await WishlistRepositories().removeResponse(productDetails.value.detailedProducts!.id!);
  }

  Future<DetailsProductsResponse> getRelatedProducts() async{
    return relatedProductsResponse.value = await DetailsRepositories.getRelatedProducts(productSlug);
  }
  Future<DetailsProductsResponse> getRecommendedProducts() async{
    return recommendedProductsResponse.value = await DetailsRepositories.getRecommendedProduct();
  }

}
