import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:torganic/src/common/styles/app_dividers.dart';
import 'package:torganic/src/common/widgets/containers/card_container.dart';
import 'package:torganic/src/features/details/controller/details_page_controller.dart';
import 'package:torganic/src/features/details/model/product_details_model.dart';
import 'package:torganic/src/utils/constants/colors.dart';
import 'package:torganic/src/utils/constants/sizes.dart';

class AppDetailsTagUnderlineWidget extends StatelessWidget {
  const AppDetailsTagUnderlineWidget(
      {super.key,
      required this.title,
      required this.onTap,
      required this.types,
        this.haveColor = false,
        this.haveUnderLine = true});

  final String title;
  final VoidCallback onTap;
  final List types;
  final bool haveColor, haveUnderLine;

  @override
  Widget build(BuildContext context) {
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
          return InkWell(
            onTap: () {
              onTap;
              // value.setSkinTypesKey(skinType);
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) {
              //       // return Filter(
              //       //   selected_skin: skinType,
              //       // );
              //       return Main(pageIndex: 1,);
              //     }));
            },
            child: Text(
                "${types[index].name!.substring(0, 1).toUpperCase()}${types[index].name!.substring(1)},  ",
                style: TextStyle(
                    fontSize: 14,
                    color: haveColor? AppColors.primary : AppColors.secondary,
                    fontWeight: FontWeight.w600,
                    decoration: haveUnderLine? TextDecoration.underline : null)),
          );
        }),
      ],
    );
  }
}
