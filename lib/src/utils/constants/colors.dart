import 'dart:math';

import 'package:flutter/material.dart';

class AppColors {
  // App theme colors
  //static const Color primary = Color(0xFF4b68ff);
  //static const Color secondary = Color(0xFFFFE24B);
  static const Color accent = Color(0xFFb0c7ff);
  static const Color primary = Color(0xffd02128);
  static const Color secondary = Color(0xff222529);
  static const Color white = Color(0xffffffff);
  static const Color darkGrey = Color(0xff707070);
  static const Color signUpWithPassword = Color(0xff254849);
  static const Color lightGrey = Color.fromRGBO(239, 239, 239, 1);
  static const Color addToCartButton = Color(0xff2a2b2d);
  static const Color facebookBg = Color(0xff4c69ba);
  static const Color googleBg = Color(0xffdd4b39);
  static const Color preorder=Color(0xff17a2be);
  static const Color inStock = Colors.green;
  static const Color backLayoutAppBarTitle = Colors.blueGrey;

  static Color request = const Color(0xffF78C2C);

  // Text colors
  static const Color textPrimary = Color(0xFF333333);
  static const Color textSecondary = Color(0xFF6C757D);
  static const Color textWhite = Colors.white;

  // Background colors
  static const Color light = Color(0xFFF6F6F6);
  static const Color dark = Color(0xFF272727);
  static const Color primaryBackground = Color(0xFFF3F5FF);

  // Background Container colors
  static const Color lightContainer = Color(0xFFF6F6F6);
  static Color darkContainer = AppColors.white.withOpacity(0.1);

  // Button colors
  static const Color buttonPrimary = Color(0xFF4b68ff);
  static const Color buttonSecondary = Color(0xFF6C757D);
  static const Color buttonDisabled = Color(0xFFC4C4C4);

  // Border colors
  static const Color borderPrimary = Color(0xFFD9D9D9);
  static const Color borderSecondary = Color(0xFFE6E6E6);

  // Error and validation colors
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xff3D9846);
  static const Color warning = Color(0xFFF57C00);
  static const Color info = Color(0xFF1976D2);

  // Neutral Shades
  static const Color black = Color(0xFF232323);
  static const Color darkerGrey = Color(0xFF4F4F4F);
 // static const Color darkGrey = Color(0xFF939393);
  static const Color grey = Color(0xFFE0E0E0);
  static const Color softGrey = Color(0xFFF4F4F4);
  //static const Color lightGrey = Color(0xFFF9F9F9);
  //static const Color white = Color(0xFFFFFFFF);


  static const Color silver = Color(0xFF808080);
  static const Color gold = Color(0xFFE6CB3F);
  static const Color platinum = Color(0xFFFFB763);


  static const Color popUpBackground = Color(0xFFDFDFF5);

  /// for fixed three color
  List<Color> colorList = [
    const Color(0xff1C2028),
    const Color(0xff2782BF),
    const Color(0xff0EA29A),
    const Color(0xffFF993D),
    const Color(0xffC01E24),
    const Color(0xffE2316B),
  ];
  getRandomColor(){
    Random random = Random();
    return colorList[random.nextInt(colorList.length)];
  }

}



