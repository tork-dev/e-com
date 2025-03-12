import 'package:get/get.dart';

import '../../../utils/logging/logger.dart';

class InfluencerStoreController extends GetxController{
  static InfluencerStoreController get instance => Get.find();

  Future<void> onRefresh() async{
    Log.d('refresh');
  }

}