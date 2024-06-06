import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/local_storage/local_storage_keys.dart';
import '../../../../utils/local_storage/storage_utility.dart';
import '../../../styles/app_dividers.dart';

class AppDrawerHeaderPart extends StatelessWidget {
  const AppDrawerHeaderPart({
    super.key,});


  @override
  Widget build(BuildContext context) {
    final userImage = AppLocalStorage().readData(LocalStorageKeys.avatarOriginal);
    final userName = AppLocalStorage().readData(LocalStorageKeys.userName);
    final userPhone = AppLocalStorage().readData(LocalStorageKeys.userEmail);
    return Column(
      children: [
        AppLocalStorage().readData(LocalStorageKeys.isLoggedIn) == true ?
        ListTile(
          leading: CircleAvatar(
            backgroundImage: userImage != null? NetworkImage(userImage) as ImageProvider
                : const AssetImage(AppImages.profileIcon) as ImageProvider ,
          ),
            title: Text(userName),
            subtitle: Text(userPhone)
        ): const Center(
          child: Text(
              'Not Logged In',
              style: TextStyle(fontSize: 13)),
        ),
        const Gap(AppSizes.xs),
        AppDividersStyle.fullFlatAppDivider,
      ],
    );
  }
}