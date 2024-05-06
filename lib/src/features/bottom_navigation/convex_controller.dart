import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ConvexBottomNavController extends GetxController{
  static ConvexBottomNavController get instance => Get.find();

  RxInt pageIndex = 0.obs;

  void changePage(int index){
     pageIndex.value = index;
  }
}