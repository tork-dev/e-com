import 'package:get/get.dart';
import 'package:kirei/src/features/bottom_navigation/convex_controller.dart';
import 'package:kirei/src/features/shop/controller/get_shop_data_controller.dart';

class AppSearchController extends GetxController{
  static AppSearchController get instance => Get.find();

  ConvexBottomNavController bottomController = ConvexBottomNavController.instance;
  GetShopDataController shopDataController = Get.put(GetShopDataController());


  //RxBool isLoading = false.obs;

  // final ImagePicker _picker = ImagePicker();
  // XFile? _file;

  // chooseAndUploadImage() async {
  //   // var status = await Permission.photos.request();
  //   _file = await _picker.pickImage(source: ImageSource.gallery);
  //
  //   //return;
  //   String base64Image = FileHelper.getBase64FormatedFile(_file!.path);
  //   String fileName = _file!.path.split("/").last;
  //   await SearchRepositories().getImageSearch(
  //       image: base64Image,
  //       filename: fileName
  //   );

  }

  // Future<ShopPageResponse> getSearchResponse(String searchKey) async{
  //   return shopDataController.shopPageProduct.value = await SearchRepositories().getSearchResponse(searchKey);
  // }




  // Future<void> searchByImage() async {
  //   _file = await _picker.pickImage(source: ImageSource.gallery);
  //
  //   if (_file != null) {
  //    // isLoading(true);
  //     shopDataController.hittingApi.value = true;
  //     bottomController.jumpToTab(1);
  //     File imageFile = File(_file!.path);
  //     Uint8List imageBytes = await imageFile.readAsBytes();
  //     String imageName = _file!.path.split("/").last;
  //
  //     try {
  //       shopDataController.shopPageProduct.value = await SearchRepositories().getSearchByImage(
  //         imageBytes: imageBytes,
  //         imageName: imageName,
  //       );
  //       shopDataController.allProducts.addAll(shopDataController.shopPageProduct.value.data!);
  //       Log.d('Image search successful');
  //       shopDataController.hittingApi.value = false;
  //
  //     } catch (e) {
  //       Log.d('Image search failed: $e');
  //     } finally {
  //       //isLoading(false);
  //     }
  //   }
  // }