import 'package:flutter/material.dart';

import '../../features/authentication/views/log_in/repository/login_repository.dart';
import '../local_storage/local_storage_keys.dart';
import '../local_storage/storage_utility.dart';


class AuthHelper{

  setUserData(loginResponse) async{
    print(loginResponse);
    if(loginResponse.result == true){
      AppLocalStorage().saveDataIfNull(LocalStorageKeys.isLoggedIn, true);
      AppLocalStorage().saveDataIfNull(LocalStorageKeys.accessToken, loginResponse.accessToken ?? "");
      AppLocalStorage().saveDataIfNull(LocalStorageKeys.userId, loginResponse.user.id);
      AppLocalStorage().saveDataIfNull(LocalStorageKeys.userName, loginResponse.user.name ?? "");
      AppLocalStorage().saveDataIfNull(LocalStorageKeys.userEmail, loginResponse.user.email );
      AppLocalStorage().saveDataIfNull(LocalStorageKeys.userPhone, loginResponse.user.phone );
      AppLocalStorage().saveDataIfNull(LocalStorageKeys.userHavePassword, loginResponse.user.passwordSaved);
      AppLocalStorage().saveDataIfNull(LocalStorageKeys.avatarOriginal, loginResponse.user.avatarOriginal ?? "");
    }
  }


  fetch_and_set() async {
    var userByTokenResponse = await LoginRepository().getUserByTokenResponse();

    if (userByTokenResponse.result == true) {
      AppLocalStorage().saveDataIfNull(LocalStorageKeys.isLoggedIn, true);
      AppLocalStorage().saveDataIfNull(LocalStorageKeys.userId, userByTokenResponse.id);
      AppLocalStorage().saveDataIfNull(LocalStorageKeys.userName, userByTokenResponse.name ?? "");
      AppLocalStorage().saveDataIfNull(LocalStorageKeys.userEmail, userByTokenResponse.email );
      AppLocalStorage().saveDataIfNull(LocalStorageKeys.userPhone, userByTokenResponse.phone );
      AppLocalStorage().saveDataIfNull(LocalStorageKeys.userHavePassword, userByTokenResponse.passwordSaved);
      AppLocalStorage().saveDataIfNull(LocalStorageKeys.avatarOriginal, userByTokenResponse.avatarOriginal ?? "");
    } else
    {
      AppLocalStorage().saveDataIfNull(LocalStorageKeys.isLoggedIn, false);
      AppLocalStorage().saveDataIfNull(LocalStorageKeys.userId, 0);
      AppLocalStorage().saveDataIfNull(LocalStorageKeys.userName, "");
      AppLocalStorage().saveDataIfNull(LocalStorageKeys.userEmail, "");
      AppLocalStorage().saveDataIfNull(LocalStorageKeys.userPhone, "");
      AppLocalStorage().saveDataIfNull(LocalStorageKeys.userHavePassword, "");
      AppLocalStorage().saveDataIfNull(LocalStorageKeys.avatarOriginal, "");
    }
  }





}