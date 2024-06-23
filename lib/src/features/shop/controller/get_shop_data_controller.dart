import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../model/shop_data_model.dart';
import '../model/skin_type_model.dart';
import '../model/sub_category_model.dart';
import '../repositories/shop_repositories.dart';

class GetShopDataController extends GetxController {
  static GetShopDataController get instance => Get.find();

  RxBool hittingApi = false.obs;
  RxBool isFromCategory = false.obs;

  /// Model
  Rx<ShopPageResponse> shopPageProduct = ShopPageResponse().obs;
  RxList<ProductSubCategoryItem> subCategoryResponse = <ProductSubCategoryItem>[
  ].obs;
  Rx<SkinTypesResponse> skinTypeResponse = SkinTypesResponse().obs;

  ///Controllers
  final TextEditingController minimumPriceController = TextEditingController();
  final TextEditingController maximumPriceController = TextEditingController();
  ScrollController scrollController = ScrollController();

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


  void resetAll() {
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
    selectedCategoryIndex = Rx<int?>(null);
    isFromCategory.value = false;
  }

  updateCategory(String category) {
    categories.value = category;
  }

  void updateSelectedCategoryIndex(int index, String value) {
    selectedSortIndex.value = index;
    categories.value = value;
  }
  void updateSortKey(String value) {
    sortKey.value = value;
  }

  Future<ShopPageResponse> getShopData() async {
    return shopPageProduct.value = await ShopRepositories().getFilteredProducts(
        searchName: searchName.value,
        tag: tag.value,
        sortKey: sortKey.value,
        skinType: selectedSkinTypes.isEmpty ? skinType.value : selectedSkinTypes
            .join(",").toString(),
        search: search.value,
        min: minimumPriceController.text,
        max: maximumPriceController.text,
        keyIngredients: keyIngredients.value,
        goodFor: goodFor.value,
        categories: categories.value,
        pageNumber: pageNumber.value,
        type: type.value
    );
  }

  Future getSubCategory() async {
    isFromCategory.value = true;
    hittingApi.value = true;
    subCategoryResponse.value = await ShopRepositories().getSubCategories(categories.value);
    hittingApi.value = false;
    if(subCategoryResponse.isEmpty){
      isFromCategory.value = false;
      return;
    }
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

   scrollListener(){
    print('listening');
  }
}