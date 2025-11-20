import 'package:kirei/src/features/authentication/views/log_in/model/login_response.dart';
import 'package:kirei/src/utils/firebase/gtm_events.dart';
import '../local_storage/local_storage_keys.dart';
import '../local_storage/storage_utility.dart';
import '../logging/logger.dart';

class AuthHelper{

  void setUserData(AppLoginResponse loginResponse) async{
      AppLocalStorage().saveDataIfNull(LocalStorageKeys.isLoggedIn, true);
      AppLocalStorage().saveDataIfNull(LocalStorageKeys.accessToken, loginResponse.accessToken);
      AppLocalStorage().saveDataIfNull(LocalStorageKeys.userId, loginResponse.user?.id);
      AppLocalStorage().saveDataIfNull(LocalStorageKeys.userName, loginResponse.user?.name);
      AppLocalStorage().saveDataIfNull(LocalStorageKeys.userEmail, loginResponse.user?.email );
      AppLocalStorage().saveDataIfNull(LocalStorageKeys.userPhone, loginResponse.user?.phone );
      AppLocalStorage().saveDataIfNull(LocalStorageKeys.userHavePassword, loginResponse.user?.passwordSaved);
      AppLocalStorage().saveDataIfNull(LocalStorageKeys.avatarOriginal, loginResponse.user?.avatarOriginal);
      AppLocalStorage().saveData(LocalStorageKeys.sowedSpinner, true);
      EventLogger().logUserDataEvent();
  }


  void clearUserData() {
    AppLocalStorage().removeData(LocalStorageKeys.isLoggedIn, );
    AppLocalStorage().removeData(LocalStorageKeys.accessToken,);
    AppLocalStorage().removeData(LocalStorageKeys.userId);
    AppLocalStorage().removeData(LocalStorageKeys.userName);
    AppLocalStorage().removeData(LocalStorageKeys.userEmail);
    AppLocalStorage().removeData(LocalStorageKeys.userPhone);
    AppLocalStorage().removeData(LocalStorageKeys.userHavePassword);
    AppLocalStorage().removeData(LocalStorageKeys.avatarOriginal);
  }


  void saveUserDataByToken(dynamic userData){
      // AppLocalStorage().saveDataIfNull(LocalStorageKeys.isLoggedIn, true);
      // AppLocalStorage().saveDataIfNull(LocalStorageKeys.userId, userData.id);
      // AppLocalStorage().saveDataIfNull(LocalStorageKeys.userName, userData.name);
      // AppLocalStorage().saveDataIfNull(LocalStorageKeys.userEmail, userData.email );
      // AppLocalStorage().saveDataIfNull(LocalStorageKeys.userPhone, userData.phone );
      // AppLocalStorage().saveDataIfNull(LocalStorageKeys.userHavePassword, userData.passwordSaved);
      // AppLocalStorage().saveDataIfNull(LocalStorageKeys.avatarOriginal, userData.avatar);

      AppLocalStorage().saveData(LocalStorageKeys.isLoggedIn, true);
      AppLocalStorage().saveData(LocalStorageKeys.userId, userData.id);
      AppLocalStorage().saveData(LocalStorageKeys.userName, userData.name );
      AppLocalStorage().saveData(LocalStorageKeys.userEmail, userData.email );
      AppLocalStorage().saveData(LocalStorageKeys.userPhone, userData.phone );
      AppLocalStorage().saveData(LocalStorageKeys.userHavePassword, userData.passwordSaved);
      AppLocalStorage().saveData(LocalStorageKeys.avatarOriginal, userData.avatarOriginal);

      Log.d(AppLocalStorage().readData(LocalStorageKeys.userId));
      EventLogger().logUserDataEvent();
  }





}