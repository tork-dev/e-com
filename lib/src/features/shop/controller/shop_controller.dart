
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:torganic/src/features/bottom_navigation/convex_controller.dart';
import 'package:torganic/src/features/shop/model/shop_data_model.dart';
import 'package:torganic/src/features/shop/repositories/shop_repositories.dart';

import '../model/skin_type_model.dart';

class ShopController extends GetxController{
  static ShopController get instance => Get.find();

  RxBool callApis = false.obs;

  final bottomController = ConvexBottomNavController.instance;

  /// Key
  final GlobalKey<ScaffoldState> shopKey = GlobalKey<ScaffoldState>();

  ///Controllers
  final TextEditingController minimumPriceController = TextEditingController();
  final TextEditingController maximumPriceController = TextEditingController();

  /// Model
  Rx<ShopPageResponse> shopPageProduct = ShopPageResponse().obs;
  Rx<SkinTypesResponse> skinTypeResponse = SkinTypesResponse().obs;


  /// Searching params
  RxString searchName = ''.obs;
  RxString sortKey = 'default'.obs;
  RxString tag = ''.obs;
  RxString skinType = ''.obs;
  RxString search = ''.obs;
  RxString keyIngredients = ''.obs;
  RxString goodFor = ''.obs;
  RxString categories = ''.obs;
  RxInt pageNumber = 1.obs;
  RxString type = ''.obs;
  Rx<int?> selectedCategoryIndex = Rx<int?>(null);
  RxList<String> selectedSkinTypes = <String>[].obs;
  RxInt selectedSortIndex = 0.obs;



  @override
  void onInit() {
    if(bottomController.pageIndex.value == 1 || callApis.value == true) {
      getShopData();
      getSkinTypesData();
    }
    super.onInit();
  }

  void updateSelectedCategoryIndex(int index, String value) {
    selectedSortIndex.value = index;
    categories.value = value;
  }
  updateCategory(String category){
    categories.value = category;
  }

  void updateSortKey(String value) {
    sortKey.value = value;
  }

  Future<SkinTypesResponse> getSkinTypesData() async{
    return skinTypeResponse.value = await ShopRepositories().getFilterPageSkinTypes();
  }

  void selectSkinTypes(String title) {
    if (selectedSkinTypes.contains(title)) {
      selectedSkinTypes.remove(title);
    } else {
      selectedSkinTypes.add(title);
    }
  }

  void resetAll(){
    searchName.value = '';
    sortKey.value = '';
    tag.value = '';
    skinType.value = '';
    search.value = '';
    minimumPriceController.text = '';
    maximumPriceController.text = '';
    keyIngredients.value = '';
    goodFor.value = '';
    categories.value = '';
    pageNumber.value = 1;
    type.value = '';
    selectedSkinTypes.clear();
    selectedCategoryIndex =  Rx<int?>(null);
  }

  Future<ShopPageResponse> getShopData() async {
    return shopPageProduct.value = await ShopRepositories().getFilteredProducts(
      searchName: searchName.value,
      tag: tag.value,
      sortKey: sortKey.value,
      skinType: selectedSkinTypes.isEmpty ? skinType.value : selectedSkinTypes.join(",").toString(),
      search: search.value,
      min: minimumPriceController.text,
      max: maximumPriceController.text,
      keyIngredients: keyIngredients.value,
      goodFor: goodFor.value,
      categories: categories.value,
      pageNumber: pageNumber.value,
      type:type.value
    );
  }
}