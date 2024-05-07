import 'package:flutter/material.dart';

class AppLayoutWithRefresher extends StatelessWidget {
  const AppLayoutWithRefresher({super.key, this.onRefresh, required this.children});


  final dynamic onRefresh;
  final Widget children;

  @override
  Widget build(BuildContext context) {
    return  Stack(
        children: [
        RefreshIndicator(
        onRefresh: onRefresh,
        child: CustomScrollView(
            controller: ScrollController(),
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            slivers: [
            SliverList(
            delegate: SliverChildListDelegate([
              children
            ]))]))]
    );
  }
}
