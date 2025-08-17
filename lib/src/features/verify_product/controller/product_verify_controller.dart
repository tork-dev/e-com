import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../../utils/popups/custom_loader.dart';
import '../model/product_verify_list_model.dart';
import '../repository/product_verify_repository.dart';

class ProductVerifyController extends GetxController{
  static ProductVerifyController get instance => Get.find();

  final Rx<ProductVerifyListResponse> productVerifyListResponse = ProductVerifyListResponse().obs;
  final ProductVerifyRepository _productVerifyRepository = ProductVerifyRepository();
  RxInt pageNumber = 1.obs;
  RxBool isLoading = false.obs;
  RxInt isAuthentic = 1.obs;
  TextEditingController noteController = TextEditingController();


  @override
  void onInit() {
    super.onInit();
    getVerifyProductList();
  }

  Future<void> getVerifyProductList() async {
    try {
      isLoading.value = true;
      final response = await _productVerifyRepository.getVerifyProductList(pageNumber.value);
      productVerifyListResponse.value = response;
    } catch (e) {
      print('Error fetching products: $e');
    }finally{
      isLoading.value = false;
    }
  }

  Future<void> submitFeedback({
    required int index,
  }) async {
    try{
      if(isAuthentic.value == 0 && noteController.text.isEmpty){
        AppHelperFunctions.showToast("Note is required");
        return;
      }
      CustomLoader.showLoaderDialog(Get.overlayContext!);
      print("product id${productVerifyListResponse.value.data![index].productId}");
      await _productVerifyRepository.submitFeedback(
        productID: productVerifyListResponse.value.data![index].productId!,
        orderId: productVerifyListResponse.value.data![index].orderId!,
        isAuthentic: isAuthentic.value,
        note: noteController.text.toString(),
      );
      print("product id${productVerifyListResponse.value.data![index].productId}");
      productVerifyListResponse.value.data![index].isAuthenticReview = true;
      AppHelperFunctions.showToast("Submitted successfully");
      noteController.clear();
      isAuthentic.value = 1;
      Get.back();
    }catch(e){
      throw Exception(e);
    }finally{
      update();
      CustomLoader.hideLoader(Get.overlayContext!);
    }

  }
}