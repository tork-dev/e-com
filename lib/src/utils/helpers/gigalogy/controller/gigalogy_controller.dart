// import 'package:get/get.dart';
//
// import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
// import 'package:kirei/src/utils/local_storage/storage_utility.dart';
// import 'package:kirei/src/utils/logging/logger.dart';
//
// import '../model/gaip_user_id_model.dart';
// import '../repository/gigalogy_repositories.dart';
//
// class GaipUserIdController extends GetxController{
//
//   Rx<GaipUserIdResponse> gaipResponse = GaipUserIdResponse().obs;
//
//
//   @override
//   void onInit() {
//     super.onInit();
//     getGaipUserId();
//   }
//
//   Future<void> getGaipUserId() async{
//     Log.d("gaip user api called");
//     gaipResponse.value = await GigalogyRepository().getGaipUserId();
//     Log.d(gaipResponse.value.toString());
//     AppLocalStorage().saveDataIfNull(LocalStorageKeys.gaipUserId, gaipResponse.value.detail!.response);
//   }
// }