import 'package:flutter/material.dart';
import 'package:kirei/src/common/widgets/search_bar/search_widget.dart';
import '../../../utils/constants/colors.dart';

class AppBarSearch extends StatelessWidget {
  final Widget? Function(String txt) onSubmit;
  final FocusNode focusOn;
  final String prevRoute;
  const AppBarSearch({super.key, required this.onSubmit, required this.focusOn, required this.prevRoute});

  @override
  Widget build(BuildContext context) {
   // final ValueNotifier<FocusNode?> currentFocusNode = ValueNotifier<FocusNode?>(focusOn);
    return AppSearchWidget(
      builder: (context, controller, focusNode)=>
      TextFormField(
        onFieldSubmitted: onSubmit,
        controller: controller,
        focusNode: focusNode,
        cursorColor: AppColors.white,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(right: 0),
          suffixIcon: const Icon(Icons.search, color: AppColors.white,),
          hintText: 'Search with AI (EX: Facewash for acne)',
          hintStyle: Theme.of(context)
              .textTheme
              .bodySmall!
              .apply(color: AppColors.white),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent)),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent)),
        ),
      ),
      prevRoute: prevRoute,
    );
  }
}
