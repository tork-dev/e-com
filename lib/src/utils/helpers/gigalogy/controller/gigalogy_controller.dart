import 'package:get/get.dart';

import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';

import '../model/gaip_user_id_model.dart';
import '../repository/gigalogy_repositories.dart';

class GaipUserIdController extends GetxController{

  Rx<GaipUserIdResponse> gaipResponse = GaipUserIdResponse().obs;


  @override
  void onInit() {
    super.onInit();
    getGaipUserId();
  }

  Future<void> getGaipUserId() async{
    gaipResponse.value = await GigalogyRepository().getGaipUserId();
    AppLocalStorage().saveDataIfNull(LocalStorageKeys.gaipUserId, gaipResponse.value.detail!.response);
  }
}