import 'package:flutter/material.dart';
import 'package:kirei/src/common/widgets/appbar/custom_app_bar.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../styles/spacing_style.dart';

class AppLayoutWithoutAppBar extends StatelessWidget {
  const AppLayoutWithoutAppBar({
    this.title,
    required this.body,
    this.centerTitle = false,
    this.action,
    this.backgroundColor,
    super.key});

  final Widget? title, body;
  final bool centerTitle;
  final Color? backgroundColor;
  final List<Widget>? action;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
        title: title,
        showBackArrow: false,
        showLeadingIcon: false,
        centerTitle: centerTitle,
        actions: action,
        backgroundColor: backgroundColor,
      ),
      body: Padding(padding: AppSpacingStyle.defaultSpacing, child: body),
    );
  }
}

