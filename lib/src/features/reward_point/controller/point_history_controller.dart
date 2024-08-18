import 'package:get/get.dart';

class RewardPointHistoryController extends GetxController{
  static RewardPointHistoryController get instance => Get.find();


  Future<void> onRefresh() async{
    print('refresh');
  }
}