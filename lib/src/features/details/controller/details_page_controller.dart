import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:torganic/src/features/details/repositories/details_repositories.dart';
import 'package:torganic/src/features/home/controller/home_controller.dart';
import 'package:torganic/src/utils/helpers/helper_functions.dart';

import '../model/product_details_model.dart';

class DetailsPageController extends GetxController {
  static DetailsPageController get instance => Get.find();

  final homeController = HomeController.instance;

  DetailsPageController({
    required this.productSlug,
  });

  final String productSlug;

  /// Image SwapPing
  RxInt pictureIndex = 0.obs;
  RxBool viewMore = false.obs;

  RxInt productCount = 1.obs;
  RxBool isAddedToCart = false.obs;

  Rx<ProductDetailsResponse> productDetails = ProductDetailsResponse().obs;

  @override
  void onInit() {
    super.onInit();
    print('slug is $productSlug');
    getProductDetails();
  }

  Future<void> onRefresh() async {
    print('refresh');
    getProductDetails();
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
}
