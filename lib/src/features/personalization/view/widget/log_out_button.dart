import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/features/bottom_navigation/convex_bottom_navigation.dart';
import 'package:kirei/src/utils/helpers/auth_helper.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';

class ProfileLogOutButton extends StatelessWidget {
  const ProfileLogOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            AppHelperFunctions.showAlert(
                message: 'Are you sure you want to logout?',
                leftButtonName: 'Yes',
                rightButtonName: 'No',
                onRightPress: () {
                  Get.back();
                },
                onLeftPress: () {
                  AuthHelper().clearUserData();
                  Get.offAll(() => const HelloConvexAppBar());
                },
                rightButtonTextColor: AppColors.secondary,
                rightButtonColor: Colors.transparent);
          },
          child: Row(
            children: [
              Container(
                  height: 30,
                  width: 30,
                  decoration: const BoxDecoration(
                    color: Colors.redAccent,
                    shape: BoxShape.circle,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.login,
                      color: Colors.white,
                      size: 14,
                    ),
                  )),
               Padding(
                padding: EdgeInsets.all(6.0),
                child: Text(
                  "Logout",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
