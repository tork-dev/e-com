import 'package:get/get.dart';
import 'package:torganic/src/features/cart/controllers/cart_controller.dart';
import '../../utils/local_storage/local_storage_keys.dart';
import '../../utils/local_storage/storage_utility.dart';
import '../authentication/views/log_in/view/login.dart';


class ConvexBottomNavController extends GetxController{
  static ConvexBottomNavController get instance => Get.find();

  final cartController = Get.put(CartController());

  RxInt pageIndex = 0.obs;

  void changePage(int index){
     pageIndex.value = index;
     if(pageIndex.value == 2){
       cartController.onRefresh();
     }
     if(AppLocalStorage().readData(LocalStorageKeys.isLoggedIn) == null && pageIndex.value == 3){
       Get.offAll(()=> const LogIn());
     }
  }
}