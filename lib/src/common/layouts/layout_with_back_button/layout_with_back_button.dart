import 'package:flutter/material.dart';
import 'package:torganic/src/common/drawer/view/drawer.dart';
import 'package:torganic/src/common/widgets/appbar/custom_app_bar.dart';
import 'package:torganic/src/utils/constants/colors.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../styles/spacing_style.dart';

class AppLayoutWithBackButton extends StatelessWidget {
  const AppLayoutWithBackButton({
  required this.padding,
    this.title,
    required this.body,
    this.centerTitle = false,
    this.action,
    this.backgroundColor,
    this.showBackButton = true,
    this.leadingIconColor,
    super.key,  });

  final Widget? title, body;
  final bool centerTitle;
  final Color? backgroundColor, leadingIconColor;
  final List<Widget>? action;
  final bool showBackButton;
  final double padding;


  @override
  Widget build(BuildContext context) {
    //final isDark = AppHelperFunctions.isDarkMode(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
        title: title,
        showBackArrow: showBackButton,
        leadingIconColor: leadingIconColor,
        centerTitle: centerTitle,
        backgroundColor: backgroundColor,
        actions: action,
      ),
      body: Padding(padding: EdgeInsets.symmetric(horizontal: padding), child: body),
    );
  }
}

