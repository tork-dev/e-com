import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:torganic/src/features/bottom_navigation/convex-bottom_navigation.dart';
import 'package:torganic/src/utils/helpers/auth_helper.dart';
import '../../../../utils/constants/colors.dart';


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
            AuthHelper().clearUserData();
            Get.offAll(()=> const HelloConvexAppBar());
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
              const Padding(
                padding: EdgeInsets.all(6.0),
                child: Text(
                  "Logout",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.secondary, fontSize: 18),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

