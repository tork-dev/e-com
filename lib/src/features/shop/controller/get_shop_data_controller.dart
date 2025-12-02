import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';
import 'package:kirei/src/utils/logging/logger.dart';
import '../../home/model/home_products_model.dart';
import '../../../utils/local_storage/local_storage_keys.dart';
import '../../../utils/local_storage/storage_utility.dart';
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
  RxString queryStringValue = ''.obs;
  final searchOn = Rx<FocusNode>(FocusNode());
  RxList<String> categoryRouteList = <String>[].obs;
  RxInt currentRouteIndex = 0.obs;

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
  RxString sortKey = 'Default'.obs;
  RxString tag = ''.obs;
  RxString skinType = ''.obs;
  RxString search = ''.obs;
  RxString keyIngredients = ''.obs;
  RxString goodFor = ''.obs;
  RxString categories = ''.obs;
  RxInt pageNumber = 1.obs;
  RxInt perPage = 24.obs;
  RxString type = ''.obs;
  RxString brand = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getValuesFromUrl(Get.currentRoute);
  }

  void getValuesFromUrl(String url){
    Uri uri = Uri.parse(url);
    Log.d('this is the url ${uri.path}');
    if (uri.queryParameters.containsKey('type')) {
      type.value = uri.queryParameters['type'] ?? '';
    }
    if (uri.queryParameters.containsKey('order_by')) {
      sortKey.value = uri.queryParameters['order_by'] ?? 'default';
    }
    if (uri.queryParameters.containsKey('page')) {
      pageNumber.value = int.tryParse(uri.queryParameters['page'] ?? '1') ?? 1;
    }
    if (uri.queryParameters.containsKey('per_page')) {
      pageNumber.value = int.tryParse(uri.queryParameters['per_page'] ?? '24') ?? 24;
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
    if (uri.queryParameters.containsKey('brand')) {
      brand.value = uri.queryParameters['brand'] ?? '';
    }
  }


  void setValuesFromUrl(){
    Map<dynamic, dynamic> parameters = {
      'page': pageNumber,
    };

    if (searchName.value != "") parameters['search'] = searchName;
    if (categories.value != "") {
      parameters['category'] = categories;
    }
    if (sortKey.value != "") {
      // parameters['order_by'] = sortKey.toLowerCase().replaceAll(' ', '-');
      parameters['order_by'] = sortKey;
    }
    if (skinType.value != "") {
      // parameters['skin_type'] = skinType.toLowerCase().replaceAll(' ', '-');
      parameters['skin_type'] = skinType;
    }
    if (minimumPriceController.text.toString() != "") {
      parameters['min_price'] =
          int.tryParse(minimumPriceController.text.toString());
    }
    if (maximumPriceController.text.toString() != "") {
      parameters['max_price'] =
          int.tryParse(maximumPriceController.text.toString());
    }
    if (keyIngredients.value != "") {
      parameters['key_ingredients'] = keyIngredients;
    }
    if (goodFor.value != "") {
      parameters['good_for'] = goodFor;
    }
    if (tag.value != "") {
      parameters['tag'] = tag;
    }
    if (type.value != "") {
      parameters['type'] = type;
    }
    if (search.value != "") {
      parameters['search'] = search;
    }
    if (brand.value != "") {
      parameters['brand'] = brand;
    }

    // Constructing the query string manually
    String queryString = parameters.entries
        .map((entry) =>
    '${entry.key}=${Uri.encodeComponent(entry.value.toString())}')
        .join('&');

    // Append gaip_user_id=null at the end
    queryString +=
    '&gaip_user_id=${AppLocalStorage().readData(LocalStorageKeys.gaipUserId)}';
    // Fetch products for the current page

    queryStringValue.value = queryString;
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
    brand.value = '';
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
  void updatePerPage(int value) {
    perPage.value = value;
  }

  Future<void> getShopData() async {
    hittingApi.value = true;
      setValuesFromUrl();

    if(categories.value != ''){
      getSubCategory();
    }
    shopPageProduct.value =
        await ShopRepositories().getFilteredProducts(queryString: queryStringValue.value);

    if (shopPageProduct.value.data != null) {
      allProducts.addAll(shopPageProduct.value.data ?? []);
      Log.i('all products : ${allProducts.length}');
    }
    hittingApi.value = false;
  }

  Future<void> getSubCategory() async {
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
      skinType.value = selectedSkinTypes.join(',');
    }
  }

  bool isLoadingMore = false; // Prevents continuous loading

  void addItems() {
    scrollController.addListener(() {
      if (scrollController.position.pixels <=
              scrollController.position.minScrollExtent + 50 &&
          pageNumber.value > 1 &&
          !isLoadingMore &&
          !hittingApi.value) {
        isLoadingMore = true; // Set loading flag to true

        AppHelperFunctions.showToast('Loading more...');
        Log.d('Reached the top of the list, loading previous page...');
        pageNumber.value--;
        getShopData().then((_) {
          isLoadingMore = false; // Reset loading flag
          update(); // Trigger UI update
        });
      }
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 50 &&
          pageNumber.value < shopPageProduct.value.meta!.lastPage! &&
          !isLoadingMore &&
          !hittingApi.value) {
        isLoadingMore = true; // Set loading flag to true

        AppHelperFunctions.showToast('Loading more...');
        Log.d('Loading more data for page number: ${pageNumber.value}');

        // Save current scroll position and content height before loading more data
        double currentScrollPosition = scrollController.position.pixels;
        double maxScrollExtentBeforeLoad =
            scrollController.position.maxScrollExtent;

        pageNumber.value++;
        hittingApi.value = true;

        getShopData();
        hittingApi.value = false;
        isLoadingMore = false; // Reset loading flag

        double newMaxScrollExtent = scrollController.position.maxScrollExtent;
        double scrollOffsetDifference =
            newMaxScrollExtent - maxScrollExtentBeforeLoad;
        scrollController.jumpTo(currentScrollPosition +
            scrollOffsetDifference); // Maintain position after loading
      } else if (pageNumber.value >= shopPageProduct.value.meta?.lastPage &&
          scrollController.position.pixels >=
              scrollController.position.maxScrollExtent &&
          !isLoadingMore) {
        isLoadingMore = true;
        AppHelperFunctions.showToast('No more products in this category');
      }
    });
  }
}
