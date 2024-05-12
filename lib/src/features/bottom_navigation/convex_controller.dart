import 'package:get/get.dart';
import '../../utils/local_storage/local_storage_keys.dart';
import '../../utils/local_storage/storage_utility.dart';
import '../authentication/views/log_in/view/login.dart';


class ConvexBottomNavController extends GetxController{
  static ConvexBottomNavController get instance => Get.find();

  RxInt pageIndex = 0.obs;

  void changePage(int index){
     pageIndex.value = index;
     if(AppLocalStorage().readData(LocalStorageKeys.isLoggedIn) == null && pageIndex.value == 3){
       Get.offAll(()=> const LogIn());
     }
  }
}