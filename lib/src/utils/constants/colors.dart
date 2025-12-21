import 'dart:math';

import 'package:flutter/material.dart';

class AppColors {
  // App theme colors
  //static const Color primary = Color(0xFF4b68ff);
  //static const Color secondary = Color(0xFFFFE24B);
  static const Color accent = Color(0xFFb0c7ff);
  static const Color primary = Color(0xffE5456D);
  static const Color secondary = Color(0xff222529);
  static const Color contentInversePrimary = Color(0xffE1DCFA);
  static const Color white = Color(0xffffffff);
  static const Color darkGrey = Color(0xff707070);
  static const Color signUpWithPassword = Color(0xff254849);
  static const Color lightGrey = Color.fromRGBO(239, 239, 239, 1);
  static const Color addToCartButton = Color(0xff2a2b2d);
  static const Color greenButton = Color(0xff198754);
  static const Color facebookBg = Color(0xff4c69ba);
  static const Color googleBg = Color(0xffdd4b39);
  static const Color preorder=Color(0xff17a2be);
  static const Color inStock = Colors.green;
  static const Color backLayoutAppBarTitle = Colors.blueGrey;
  static const Color whitePink = Color(0xffFFF5F9);
  static const Color headerBackground = Color(0xFFF5F5FF);
  static Color request = const Color(0xffF78C2C);

  // Text colors
  static const Color textPrimary = Color(0xFF2D2B3A);
  static const Color textSecondary = Color(0xFF6C757D);
  static const Color textWhite = Colors.white;

  // Background colors
  static const Color light = Color(0xFFF6F6F6);
  static const Color dark = Color(0xFF272727);
  static const Color primaryBackground = Color(0xFFF3F5FF);
  static const Color secondaryBackground = Color(0xFFF8F7FC);

  // Background Container colors
  static const Color lightContainer = Color(0xFFF6F6F6);
  static Color darkContainer = AppColors.white.withAlpha((0.1 * 255).toInt());

  // Button colors
  static const Color buttonPrimary = AppColors.primary;
  static const Color buttonSecondary = AppColors.secondary;
  // static const Color buttonDisabled = Color(0xFF6C757D);
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
  static const Color linkColor = Color(0xFFF4F4F4);
  //static const Color lightGrey = Color(0xFFF9F9F9);
  //static const Color white = Color(0xFFFFFFFF);


  static const Color silver = Color(0xFF808080);
  static const Color gold = Color(0xFFE6CB3F);
  static const Color platinum = Color(0xFFFFB763);


  static const Color popUpBackground = Color(0xFFDFDFF5);
  static const Color drawerBackground = Color(0xFF1E1F22);
  static const Color drawerPrimary = Color(0xFF232529);
  Color drawerExpanded = Colors.white.withAlpha((0.3 * 255).toInt());


  /// for fixed three color
  List<Color> colorList = [
    const Color(0xFF2563EB), // Blue
    const Color(0xFF16A34A), // Green
    const Color(0xFFF59E0B), // Amber
    const Color(0xFF8B5CF6), // Purple
    const Color(0xFFDC2626), // Red
    const Color(0xFF0EA5E9), // Sky Blue
    const Color(0xFF84CC16), // Lime
    const Color(0xFFF97316), // Orange
    const Color(0xFF6366F1), // Indigo
    const Color(0xFFF43F5E), // Pink
    const Color(0xFF14B8A6), // Teal
    const Color(0xFFEAB308), // Yellow
    const Color(0xFF9333EA), // Violet
    const Color(0xFF22C55E), // Fresh Green
    const Color(0xFFEA580C), // Deep Orange
    const Color(0xFF06B6D4), // Cyan
    const Color(0xFFBE123C), // Rose Red
    const Color(0xFF64748B), // Neutral Gray
  ];

  Color getRandomColor(int index) {
    final hue = (index * 47) % 360; // prime gap → repeat কম
    return HSLColor.fromAHSL(
      1,
      hue.toDouble(),
      0.65,
      0.55,
    ).toColor();
  }

}



