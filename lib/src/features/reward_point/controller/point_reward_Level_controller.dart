import 'package:get/get.dart';

class RewardPointLevelController extends GetxController{
  static RewardPointLevelController get instance => Get.find();

  Future<void> onRefresh() async{
    print('refresh');
  }
}