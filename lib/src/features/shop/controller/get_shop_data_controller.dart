import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
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

  void getValuesFromUrl(String url) {
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
      pageNumber.value =
          int.tryParse(uri.queryParameters['per_page'] ?? '24') ?? 24;
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

  void setValuesFromUrl() {
    Map<dynamic, dynamic> parameters = {'page': pageNumber};

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
      parameters['min_price'] = int.tryParse(
        minimumPriceController.text.toString(),
      );
    }
    if (maximumPriceController.text.toString() != "") {
      parameters['max_price'] = int.tryParse(
        maximumPriceController.text.toString(),
      );
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
        .map(
          (entry) =>
              '${entry.key}=${Uri.encodeComponent(entry.value.toString())}',
        )
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
    hasMoreProducts.value = true;
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

  Future<void> getShopData({bool isInitialLoad = true}) async {
    // Only show shimmer loading for initial load, not for pagination
    if (isInitialLoad) {
      hittingApi.value = true;
    }
    setValuesFromUrl();

    if (categories.value != '') {
      getSubCategory();
    }
    shopPageProduct.value = await ShopRepositories().getFilteredProducts(
      queryString: queryStringValue.value,
    );

    if (shopPageProduct.value.data != null) {
      allProducts.addAll(shopPageProduct.value.data ?? []);
      Log.i('all products : ${allProducts.length}');
    }

    if (isInitialLoad) {
      hittingApi.value = false;
    }
  }

  Future<void> getSubCategory() async {
    isFromCategory.value = true;
    hittingSubCategoryApi.value = true;
    subCategoryResponse.value = await ShopRepositories().getSubCategories(
      categories.value,
    );
    hittingSubCategoryApi.value = false;
    if (subCategoryResponse.isEmpty) {
      isFromCategory.value = false;
    }
  }

  Future<SkinTypesResponse> getSkinTypesData() async {
    return skinTypeResponse.value = await ShopRepositories()
        .getFilterPageSkinTypes();
  }

  void selectSkinTypes(String title) {
    if (selectedSkinTypes.contains(title)) {
      selectedSkinTypes.remove(title);
    } else {
      selectedSkinTypes.add(title);
      skinType.value = selectedSkinTypes.join(',');
    }
  }

  RxBool isLoadingMore = false.obs;
  RxBool hasMoreProducts = true.obs;

  void addItems() {
    scrollController.addListener(() {
      // Only trigger when scrolling near the bottom
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 200 &&
          !isLoadingMore.value &&
          !hittingApi.value &&
          hasMoreProducts.value) {
        loadMoreProducts();
      }
    });
  }

  /// Load more products when scrolling to bottom
  Future<void> loadMoreProducts() async {
    // Check if there are more pages
    if (shopPageProduct.value.meta?.lastPage == null ||
        pageNumber.value >= shopPageProduct.value.meta!.lastPage!) {
      hasMoreProducts.value = false;
      return;
    }

    isLoadingMore.value = true;
    pageNumber.value++;

    // Use isInitialLoad: false to avoid showing shimmer
    await getShopData(isInitialLoad: false);

    // Check again after loading
    if (shopPageProduct.value.meta != null) {
      hasMoreProducts.value =
          pageNumber.value < shopPageProduct.value.meta!.lastPage!;
    }

    isLoadingMore.value = false;
  }

  @override
  void onClose() {
    scrollController.dispose();
    minimumPriceController.dispose();
    maximumPriceController.dispose();
    super.onClose();
  }
}
