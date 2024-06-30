import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/features/shop/controller/get_shop_data_controller.dart';
import 'package:kirei/src/utils/constants/colors.dart';

class AppLayoutWithRefresher extends StatelessWidget {
  const AppLayoutWithRefresher({
    super.key, required this.onRefresh, required this.children, this.scrollController
  });


  final dynamic onRefresh;
  final List<Widget> children;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
        RefreshIndicator(
          color: AppColors.primary,
        onRefresh: onRefresh,
        child: CustomScrollView(
            controller: scrollController,
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            slivers: [
            SliverList(
            delegate: SliverChildListDelegate(
              children
            ))]))]
    );
  }
}
