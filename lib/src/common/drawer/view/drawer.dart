import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:torganic/src/features/authentication/views/log_in/view/login.dart';
import 'package:torganic/src/features/feedback/view/feedback_form.dart';
import 'widgets/drawer_card.dart';
import 'widgets/header_part.dart';

class AppDrawer extends StatelessWidget {
  final String userName, email;

  const AppDrawer({required this.userName, required this.email, super.key});

  void _showDialog() {
    //final controller = Get.put(AuthRepositories());
    showDialog(
        context: Get.overlayContext!,
        builder: (context) {
          return AlertDialog(
            icon: const Icon(Icons.info),
            title: Text(AppLocalizations.of(context)!.logout),
            content: Text(AppLocalizations.of(context)!.logoutWarning),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                      onPressed: () async {
                        Get.offAll(const LogIn());
                      },
                      child: Text(
                        AppLocalizations.of(context)!.yes,
                      )),
                  CupertinoButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(AppLocalizations.of(context)!.no)),
                ],
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            DrawerHeaderPart(userName: userName, email: email),
            DrawerCard(
              onTap: () {
                Get.to(()=> const FeedbackForm());
              },
              title: AppLocalizations.of(context)!.feedback,
              icon: Icons.feedback,
            ),
            DrawerCard(
              onTap: ()=> _showDialog(),
              title: AppLocalizations.of(context)!.logout,
              icon: Icons.logout,
            ),
          ],
        ),
      ],
    ));
  }
}
