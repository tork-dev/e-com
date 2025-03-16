import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/features/home/model/surprize_gift_model.dart';
import 'package:kirei/src/features/shop/controller/get_shop_data_controller.dart';
import 'package:kirei/src/utils/caching/caching_keys.dart';
import 'package:kirei/src/utils/caching/caching_utility.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';
import 'package:kirei/src/utils/logging/logger.dart';
import '../../cart/model/card_add_response_model.dart';
import '../../cart/repositories/cart_repositories.dart';
import '../../details/model/products_model.dart';
import '../../details/repositories/details_repositories.dart';
import '../model/home_featured_category_model.dart';
import '../model/home_products_model.dart';
import '../model/request_stock_model.dart';
import '../repositories/home_repositories.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  final bool callApis;

  HomeController({this.callApis = true});

  ///Controller
  GetShopDataController categoryController = Get.put(GetShopDataController());

  ///TextEditingController
  TextEditingController emailController = TextEditingController();

  /// surprise number controller
  TextEditingController surprisePhoneController = TextEditingController();

  /// Key
  final GlobalKey<ScaffoldState> homeKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> surprisePhoneKey = GlobalKey<FormState>();

  // final GlobalKey<ScaffoldState> homeTwoKey = GlobalKey<ScaffoldState>();

  RxInt carouselCurrentIndex = 0.obs;
  RxList homeSliders = [].obs;
  RxList homeSlidersLink = [].obs;
  RxBool hittingApi = false.obs;

  /// Model Class Instance
  Rx<HomeProductResponse> homeProductResponse = HomeProductResponse().obs;
  RxList<FeaturedCategory> homeFeaturedCategoryResponse =
      <FeaturedCategory>[].obs;
  Rx<AddToCartResponse> addToCartResponse = AddToCartResponse().obs;
  Rx<ProductRequestResponse> requestStockResponse =
      ProductRequestResponse().obs;
  Rx<DetailsProductsResponse> recommendedProductsResponse =
      DetailsProductsResponse().obs;
  Rx<DetailsProductsResponse> trendingProductsResponse =
      DetailsProductsResponse().obs;
  Rx<DetailsProductsResponse> recommendedProductsForYouResponse =
      DetailsProductsResponse().obs;
  Rx<SurprizeGiftResponse> surpriseGiftResponse = SurprizeGiftResponse().obs;

  //Rx<DeviceTokenUpdateResponse> trendingProductsResponse = DetailsProductsResponse().obs;

  @override
  void onInit() {
    if (callApis == true) {
      getData();
    }
    if (AppLocalStorage().readData(LocalStorageKeys.isLoggedIn) == true) {
      HomeRepositories().getDeviceTokenUpdateResponse();
    }

    super.onInit();
  }

  Future<void> onRefresh() async {
  CachingUtility.clearCache(CachingKeys.allCategoryCachedData);
  CachingUtility.clearCache(CachingKeys.allCategoryNewCachedData);
  CachingUtility.clearCache(CachingKeys.featuredCategoryCachedData);
  CachingUtility.clearCache(CachingKeys.homePageCachedData);
  await getData();
  }

  Future<void> getData() async{
    homeSlidersLink.clear();
    homeSliders.clear();
    getProductData();
    fetchFeaturedCategories();
    // getRecommendedProducts();
    getRecommendedProductsForYou();
    getTrendingProducts();
  }

  Future<void> getProductData() async {
    hittingApi.value = true;
    homeProductResponse.value = await HomeRepositories.getHomeProducts();
    fetchCarouselImages();
    // homeProductResponse.value.bestsellingProducts[0].id
    Log.d(
        homeProductResponse.value.sliders![0].link.toString());
    hittingApi.value = false;
  }

  void fetchFeaturedCategories() async {
    homeFeaturedCategoryResponse.value =
        await HomeRepositories().getHomeFeaturedCategories();
  }

  Future<AddToCartResponse> getAddToCartResponse(
      int id, int quantity, dynamic preorderAvailable) async {
    return addToCartResponse.value = await CartRepositories()
        .getCartAddResponse(id, quantity, preorderAvailable);
  }

  Future<ProductRequestResponse> getRequestResponse(
      {required int productId}) async {
    return requestStockResponse.value =
        await CartRepositories().getRequestStock(productId: productId);
  }

  Future<DetailsProductsResponse> getRecommendedProducts() async {
    return recommendedProductsResponse.value =
        await DetailsRepositories.getRecommendedProduct();
  }

  Future<void> getRecommendedProductsForYou() async {
    recommendedProductsForYouResponse.value =
        await HomeRepositories.getRecommendedProductForYou();
  }

  Future<DetailsProductsResponse> getTrendingProducts() async {
    return trendingProductsResponse.value =
        await HomeRepositories.getTrendingProduct();
  }

  void updateCurrentIndex(int index) {
    carouselCurrentIndex.value = index;
  }

  fetchCarouselImages() {
    var carouselResponse = homeProductResponse.value.sliders;
    debugPrint('sliders $carouselResponse');
    carouselResponse?.forEach((slider) {
      if (slider.photo != null) {
        homeSliders.add(slider.photo);
        homeSlidersLink.add(slider.link);
      }
    });
  }

  Future<void> getSurpriseTap() async {
    if (!surprisePhoneKey.currentState!.validate()) return;
    surpriseGiftResponse.value = await HomeRepositories()
        .getSurprizResponse(surprisePhoneController.text.toString());
    AppHelperFunctions.showToast(surpriseGiftResponse.value.message!);
    surprisePhoneController.clear();
  }
}
