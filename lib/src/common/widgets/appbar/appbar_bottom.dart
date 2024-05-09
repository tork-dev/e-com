import 'package:flutter/material.dart';
import 'package:torganic/src/common/widgets/containers/card_container.dart';
import 'package:torganic/src/utils/constants/colors.dart';

class AppBarBottom extends StatelessWidget{
  const AppBarBottom({super.key, required this.onFilterTap, required this.onSortTap});

  final VoidCallback onFilterTap, onSortTap;

  @override
  Widget build(BuildContext context) {
    return  AppCardContainer(
      backgroundColor: AppColors.white,
      height: 45,
      applyShadow: true,
      applyRadius: false,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: onFilterTap,
            child: Row(
              children: [
                const Icon(Icons.filter_alt_outlined, size: 13,),
                Text(' Filter', style: Theme.of(context).textTheme.labelLarge,)
              ],
            ),
          ),
          InkWell(
            onTap: onSortTap,
            child: Row(
              children: [
                const Icon(Icons.swap_vert, size: 13,),
                Text(' Sort', style: Theme.of(context).textTheme.labelLarge)
              ],
            ),
          )
        ],
      ),
    );
  }
}

