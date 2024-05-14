import 'package:get/get.dart';
import 'package:torganic/src/features/details/repositories/details_repositories.dart';

import '../model/product_details_model.dart';

class DetailsPageController extends GetxController{
  static DetailsPageController  get instance => Get.find();

  DetailsPageController({
    required this.productSlug ,
});
  final int productSlug;

  RxInt pictureIndex = 0.obs;
  Rx<ProductDetailsResponse> productDetails = ProductDetailsResponse().obs;

  @override
  void onInit() {
    super.onInit();
    print('slug is $productSlug');
    getProductDetails();
    Future.delayed(Duration(seconds: 5)).then((value) => print(productDetails.value.detailedProducts));

  }

  Future<void> onRefresh()async{
    print('refresh');
  }

  void getLargePicture(index){
    pictureIndex.value = index;
  }


  Future<ProductDetailsResponse> getProductDetails() async{
    return productDetails.value = await DetailsRepositories.getProductDetails(productSlug);
  }

}