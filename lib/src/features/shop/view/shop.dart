import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:torganic/src/common/layouts/layout_with_drawer/layout_with_drawer.dart';
import 'package:torganic/src/common/layouts/layout_with_refresher/layout_with_refresher.dart';
import 'package:torganic/src/common/widgets/appbar/appbar_bottom.dart';
import 'package:torganic/src/common/widgets/buttons/app_buttons.dart';
import 'package:torganic/src/common/widgets/containers/card_container.dart';
import 'package:torganic/src/features/shop/controller/shop_controller.dart';
import 'package:torganic/src/utils/constants/colors.dart';
import 'package:torganic/src/utils/constants/sizes.dart';
import 'package:torganic/src/utils/helpers/helper_functions.dart';

import '../../../common/widgets/containers/grid_scroll_card.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  Future<void> _onRefresh() async {
    debugPrint('_onRefresh');
  }

  @override
  Widget build(BuildContext context) {
    final shopController = Get.put(ShopController());
    return AppLayoutWithDrawer(
      padding: 0,
        globalKey: shopController.shopKey,
        backgroundColor: AppColors.primary,
        leadingIconColor: AppColors.white,
        hasEndDrawer: true,
        action: const [
          Icon(
            Icons.search,
            color: AppColors.white,
          ),
          Gap(AppSizes.sm),
        ],
        title: TextFormField(
          cursorColor: AppColors.white,
          decoration: InputDecoration(
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
        body: Stack(
          clipBehavior: Clip.none,
          // fit: StackFit.expand,

          children: [

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppLayoutWithRefresher(
                onRefresh: _onRefresh,
                  children:  [
                    const Gap(55),
                    // AppGridScrollCard(
                    //   onTap: (){},
                    //   itemCount: 20,
                    // )
                  ]),
            ),
             AppBarBottom(
              onFilterTap: ()=> shopController.shopKey.currentState!.openEndDrawer(),
               onSortTap: ()=> print('sort'),
            ),
          ],
        ));
  }
}
