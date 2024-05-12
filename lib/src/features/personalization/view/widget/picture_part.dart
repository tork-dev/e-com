import 'package:flutter/material.dart';
import 'package:torganic/src/common/widgets/containers/banner_image.dart';
import 'package:torganic/src/common/widgets/containers/card_container.dart';
import 'package:torganic/src/utils/constants/colors.dart';
import 'package:torganic/src/utils/local_storage/local_storage_keys.dart';
import 'package:torganic/src/utils/local_storage/storage_utility.dart';

import 'custom_shape.dart';

class PicturePart extends StatelessWidget {
  const PicturePart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 170,
        child: Stack(
          children: [
            ClipPath(
              clipper: CustomShape(),
              child: Container(
                height: 215, //150
                color: AppColors.primary,
              ),
            ),
            const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children:[
                  AppCardContainer(
                    width: 140,
                    height: 140,
                    applyRadius: false,
                    borderColor: AppColors.white,
                    borderWidth: 2 * 0.8,
                    hasBorder: true,
                    isCircle: true,
                    child:
                    AppBannerImage(
                      boarderRadius: 100,
                      isNetworkImage: true,
                      fit: BoxFit.fill,
                      imgUrl:
                          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=1587&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
       Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Text(
          "${AppLocalStorage().readData(LocalStorageKeys.userName)}",
          style: TextStyle(
              fontSize: 14,
              color: AppColors.secondary,
              fontWeight: FontWeight.w600),
        ),
      )
    ]);
  }
}
