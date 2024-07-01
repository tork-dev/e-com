import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/features/bottom_navigation/convex_controller.dart';
import 'package:kirei/src/features/shop/controller/get_shop_data_controller.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';
import '../../cart/model/card_add_response_model.dart';
import '../../cart/repositories/cart_repositories.dart';
import '../../details/model/products_model.dart';
import '../../details/repositories/details_repositories.dart';
import '../model/all_category_model.dart';
import '../model/device_token_model.dart';
import '../model/home_featured_category_model.dart';
import '../model/home_products_model.dart';
import '../model/home_sliders_model.dart';
import '../model/request_stock_model.dart';
import '../repositories/home_repositories.dart';


class HomeController extends GetxController{
  static HomeController get instance => Get.find();

  RxBool callApis = true.obs;

  ///Controller
  final categoryController = Get.put(GetShopDataController());


  /// Key
  final GlobalKey<ScaffoldState> homeKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> homeTwoKey = GlobalKey<ScaffoldState>();

  RxInt carousalCurrentIndex = 0.obs;

  /// Model Class Instance
  Rx<HomeProductResponse> homeProductResponse = HomeProductResponse().obs;
  RxList<FeaturedCategory>homeFeaturedCategoryResponse = <FeaturedCategory>[].obs;
  RxList<AllCategory> allCategories = <AllCategory>[].obs;
  Rx<HomeSlidersResponse> homeSliders = HomeSlidersResponse().obs;
  Rx<AddToCartResponse> addToCartResponse = AddToCartResponse().obs;
  Rx<ProductRequestResponse> requestStockResponse = ProductRequestResponse().obs;
  Rx<DetailsProductsResponse> recommendedProductsResponse = DetailsProductsResponse().obs;
  Rx<DetailsProductsResponse> trendingProductsResponse = DetailsProductsResponse().obs;
  //Rx<DeviceTokenUpdateResponse> trendingProductsResponse = DetailsProductsResponse().obs;


  @override
  void onInit(){
    if(callApis.value == true) {
      fetchFeaturedCategories();
      getProductData();
      getRecommendedProducts();
      getTrendingProducts();
    }
      fetchAllCategories();

    if(AppLocalStorage().readData(LocalStorageKeys.isLoggedIn) == true){
      HomeRepositories().getDeviceTokenUpdateResponse();
    }
    super.onInit();
  }

  Future<void> onRefresh()async{
    getProductData();
    fetchFeaturedCategories();
    fetchAllCategories();
    getRecommendedProducts();
    getTrendingProducts();
  }


  Future<HomeProductResponse> getProductData() async {
   return homeProductResponse.value = await HomeRepositories.getHomeProducts();
  }

  void fetchFeaturedCategories() async {
    homeFeaturedCategoryResponse.value = await HomeRepositories().getHomeFeaturedCategories();
  }

  void fetchAllCategories() async {
      allCategories.value = await HomeRepositories().getAllCategories();
  }

  Future<AddToCartResponse> getAddToCartResponse(int id, int quantity, dynamic preorderAvailable) async {
    return addToCartResponse.value = await CartRepositories().getCartAddResponse(id, quantity, preorderAvailable);
  }

  Future<ProductRequestResponse> getRequestResponse({required int productId}) async {
    return requestStockResponse.value = await CartRepositories().getRequestStock(productId: productId);
  }

  Future<DetailsProductsResponse> getRecommendedProducts() async{
    return recommendedProductsResponse.value = await DetailsRepositories.getRecommendedProduct();
  }

  Future<DetailsProductsResponse> getTrendingProducts() async{
    return trendingProductsResponse.value = await HomeRepositories.getTrendingProduct();
  }


}