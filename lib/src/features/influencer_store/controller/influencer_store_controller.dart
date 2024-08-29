import 'package:get/get.dart';

class InfluencerStoreController extends GetxController{
  static InfluencerStoreController get instance => Get.find();

  Future<void> onRefresh() async{
    print('refresh');
  }

}