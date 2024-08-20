import 'package:get/get.dart';
import 'package:kirei/src/utils/helpers/gaip_user_id/repository/gaip_user_id_repositories.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';

import '../model/gaip_user_id_model.dart';

class GaipUserIdController extends GetxController{

  Rx<GaipUserIdResponse> gaipResponse = GaipUserIdResponse().obs;


  @override
  void onInit() {
    super.onInit();
    getGaipUserId();
  }

  Future<void> getGaipUserId() async{
    gaipResponse.value = await GaipUserIdRepository().getGaipUserId();
    AppLocalStorage().saveDataIfNull(LocalStorageKeys.gaipUserId, gaipResponse.value.detail!.response);
  }
}