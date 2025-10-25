import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:kirei/src/common/widgets/search_bar/search_widget.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class AppBarSearch extends StatelessWidget {
  final Widget? Function(String txt) onSubmit;
  final FocusNode focusOn;
  final String prevRoute;

  const AppBarSearch(
      {super.key, required this.onSubmit, required this.focusOn, required this.prevRoute});

  @override
  Widget build(BuildContext context) {
    return AppSearchWidget(
      builder: (context, controller, focusNode) =>
          TextFormField(
            onFieldSubmitted: onSubmit,
            controller: controller,
            focusNode: focusNode,
            cursorColor: AppColors.white,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(AppSizes.md),
                  child: HugeIcon(
                    icon: HugeIcons.strokeRoundedSearch01,
                    size: AppSizes.iconMd,
                    color: AppColors.grey,
                  ),
                ), 
                hintText: 'Search Products...',
                hintStyle: Theme.of(context)
                .textTheme
                .bodySmall!
                .apply(color: AppColors.darkerGrey),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(AppSizes.inputFieldRadius)),
                borderSide: BorderSide(color: AppColors.lightGrey,)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(AppSizes.inputFieldRadius)),
                borderSide: BorderSide(color: AppColors.lightGrey)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(AppSizes.inputFieldRadius)),
                borderSide: BorderSide(color: AppColors.lightGrey)),
          ),
    ),prevRoute
    :
    prevRoute
    ,
    );
  }
}
