import 'package:flutter/material.dart';
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
            //onTapLogout(context);
            //logout();
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

