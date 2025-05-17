import 'package:flutter/material.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

import '../constants/colors.dart';

class CustomLoader {
  static bool _isShowing = false;

  static Future<void> showLoaderDialog(BuildContext context) async {
    if (_isShowing) return;
    _isShowing = true;

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppSizes.cardRadiusSm)),
          ),
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  color: AppColors.primary,
                ),
                SizedBox(height: 20),
                Text(
                  "Please wait...",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        );
      },
    );

    _isShowing = false; // Reset after dialog is dismissed
  }

  static void hideLoader(BuildContext context) {
    if (_isShowing) {
      Navigator.of(context, rootNavigator: true).pop();
      _isShowing = false;
    }
  }

  static bool isShowing() => _isShowing;
}
