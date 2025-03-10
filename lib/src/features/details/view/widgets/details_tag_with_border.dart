import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/shop/controller/get_shop_data_controller.dart';
import 'package:kirei/src/utils/constants/colors.dart';

class AppDetailsTagBorderWidget extends StatelessWidget {
  const AppDetailsTagBorderWidget(
      {super.key,
      required this.title,
      required this.onTap,
      required this.types});

  final String title;
  final VoidCallback onTap;
  final List types;

  @override
  Widget build(BuildContext context) {
    GetShopDataController categoryPassingController = GetShopDataController.instance;
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
              color: AppColors.darkGrey,
              fontSize: 14,
              fontWeight: FontWeight.w600),
        ),
        ...List.generate(types.length, (index) {
          final value = types[index];
          return InkWell(
            onTap: () {
              categoryPassingController.resetAll();
              if(title == 'Skin Types: '){
                Get.offAllNamed('shop?skin_type=${value.slug!}');
              }else if(title == 'Good For: '){
                Get.offAllNamed('shop?good_for=${value.slug!}');
              }
            },
            child: AppCardContainer(
              margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
              padding: const EdgeInsets.symmetric(horizontal: 5),
              hasBorder: true,
              applyRadius: false,
              child: Text(
                "${types[index].name!.substring(0, 1).toUpperCase()}${types[index].name!.substring(1)}",
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              ),
            );
        }),
      ],
    );
  }
}
