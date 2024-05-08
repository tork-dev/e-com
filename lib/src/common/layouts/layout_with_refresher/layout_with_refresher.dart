import 'package:flutter/material.dart';
import 'package:torganic/src/utils/constants/colors.dart';

class AppLayoutWithRefresher extends StatelessWidget {
  const AppLayoutWithRefresher({super.key, required this.onRefresh, required this.children});


  final dynamic onRefresh;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
        RefreshIndicator(
          color: AppColors.primary,
        onRefresh: onRefresh,
        child: CustomScrollView(
            controller: ScrollController(),
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
