import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';

import '../model/shop_data_model.dart';
import '../model/skin_type_model.dart';
import '../model/sub_category_model.dart';
import '../repositories/shop_repositories.dart';

class GetShopDataController extends GetxController {
  static GetShopDataController get instance => Get.find();

  RxBool hittingApi = false.obs;
  RxBool hittingSubCategoryApi = false.obs;
  RxBool isFromCategory = false.obs;
  RxBool isFromSearch = false.obs;
  final searchOn = Rx<FocusNode>(FocusNode());

  /// Model
  Rx<ShopPageResponse> shopPageProduct = ShopPageResponse().obs;
  RxList<Product> allProducts = <Product>[].obs; // Accumulated products list
  RxList<ProductSubCategoryItem> subCategoryResponse =
      <ProductSubCategoryItem>[].obs;
  Rx<SkinTypesResponse> skinTypeResponse = SkinTypesResponse().obs;

  /// Controllers
  final TextEditingController minimumPriceController = TextEditingController();
  final TextEditingController maximumPriceController = TextEditingController();
  final ScrollController scrollController = ScrollController();

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

  @override
  void onInit() {
    super.onInit();
    final uri = Uri.parse(Get.currentRoute);
    print('this is the url ${uri.path}');

    if (uri.queryParameters.containsKey('type')) {
      type.value = uri.queryParameters['type'] ?? '';
    }
    if (uri.queryParameters.containsKey('order_by')) {
      sortKey.value = uri.queryParameters['order_by'] ?? 'default';
    }
    if (uri.queryParameters.containsKey('page')) {
      pageNumber.value = int.tryParse(uri.queryParameters['page'] ?? '1') ?? 1;
    }
    if (uri.queryParameters.containsKey('search_name')) {
      searchName.value = uri.queryParameters['search_name'] ?? '';
    }
    if (uri.queryParameters.containsKey('tag')) {
      tag.value = uri.queryParameters['tag'] ?? '';
    }
    if (uri.queryParameters.containsKey('skin_type')) {
      skinType.value = uri.queryParameters['skin_type'] ?? '';
    }
    if (uri.queryParameters.containsKey('search')) {
      search.value = uri.queryParameters['search'] ?? '';
    }
    if (uri.queryParameters.containsKey('key_ingredients')) {
      keyIngredients.value = uri.queryParameters['key_ingredients'] ?? '';
    }
    if (uri.queryParameters.containsKey('good_for')) {
      goodFor.value = uri.queryParameters['good_for'] ?? '';
    }
    if (uri.queryParameters.containsKey('category')) {
      categories.value = uri.queryParameters['category'] ?? '';
    }
    if (uri.queryParameters.containsKey('max_price')) {
      maximumPriceController.text = uri.queryParameters['max_price'] ?? '';
    }
    if (uri.queryParameters.containsKey('min_price')) {
      minimumPriceController.text = uri.queryParameters['min_price'] ?? '';
    }
    if(uri.path == '/shop'){
      getShopData();
    }
    }



  Rx<int?> selectedCategoryIndex = Rx<int?>(null);
  RxList<String> selectedSkinTypes = <String>[].obs;
  // RxInt selectedSortIndex = 0.obs;

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
    selectedCategoryIndex.value = null; // Correct this line
    isFromCategory.value = false;
    allProducts.clear();
    isFromSearch.value = false;
  }

  void updateCategory(String category) {
    categories.value = category;
  }

  void updateSelectedCategoryIndex(int index, String value) {
    selectedCategoryIndex.value = index; // Update this observable
    categories.value = value;
  }

  void updateSortKey(String value) {
    sortKey.value = value;
  }

  Future<void> getShopData() async {
    hittingApi.value = true;
    // Fetch products for the current page
    shopPageProduct.value = await ShopRepositories().getFilteredProducts(
      searchName: searchName.value,
      tag: tag.value,
      sortKey: sortKey.value,
      skinType: selectedSkinTypes.isEmpty
          ? skinType.value
          : selectedSkinTypes.join(",").toString(),
      search: search.value,
      min: minimumPriceController.text,
      max: maximumPriceController.text,
      keyIngredients: keyIngredients.value,
      goodFor: goodFor.value,
      categories: categories.value,
      pageNumber: pageNumber.value,
      type: type.value,
    );

    // print(shopPageProduct.value.meta!.lastPage);
    print('this is response: ${shopPageProduct.value.data!.length}');
    print('this is last page: ${shopPageProduct.value.meta!.lastPage}');


    if (shopPageProduct.value.data != null) {
      allProducts.addAll(shopPageProduct.value.data ?? []);
      print('all products : ${allProducts.length}');
    }
    hittingApi.value = false;
  }

  Future getSubCategory() async {
    isFromCategory.value = true;
    hittingSubCategoryApi.value = true;
    subCategoryResponse.value =
        await ShopRepositories().getSubCategories(categories.value);
    hittingSubCategoryApi.value = false;
    if (subCategoryResponse.isEmpty) {
      isFromCategory.value = false;
    }
  }

  Future<SkinTypesResponse> getSkinTypesData() async {
    return skinTypeResponse.value =
        await ShopRepositories().getFilterPageSkinTypes();
  }

  void selectSkinTypes(String title) {
    if (selectedSkinTypes.contains(title)) {
      selectedSkinTypes.remove(title);
    } else {
      selectedSkinTypes.add(title);
    }
  }

  void addItems() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.minScrollExtent &&
          pageNumber.value < 1) {
        if (!hittingApi.value) {
          AppHelperFunctions.showToast('Loading more...');
          print('Reached end of list, loading more...');
          pageNumber.value--;
          getShopData();
          update();
          return;
        }
      }

      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (!hittingApi.value && pageNumber.value < shopPageProduct.value.meta!.lastPage!) {
          AppHelperFunctions.showToast('Loading more...');
          pageNumber.value++;
          getShopData();
          update();
        }else{
          AppHelperFunctions.showToast('No more product in this category');
        }
      }
    });
  }
}
