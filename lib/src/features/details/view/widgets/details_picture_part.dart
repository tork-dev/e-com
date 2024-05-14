import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:torganic/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:torganic/src/common/styles/skeleton_style.dart';
import 'package:torganic/src/features/details/controller/details_page_controller.dart';

import '../../../../common/widgets/containers/banner_image.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';

class DetailsPicturePart extends StatelessWidget {
  const DetailsPicturePart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final detailsController = DetailsPageController.instance;
    // print('produts' +detailsController.productDetails.value.detailedProducts.toString());
    return Obx(() {
      return SizedBox(
        height: 200,
        width: AppHelperFunctions.screenWidth() * 1,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 50,
              child: AppListViewLayout(
                  isScrollVertically: true,
                  itemCount:
                      detailsController.productDetails.value.detailedProducts ==
                              null
                          ? 5
                          : detailsController.productDetails.value
                              .detailedProducts!.pictures!.length,
                  builderFunction: (context, index) => detailsController
                              .productDetails.value.detailedProducts ==
                          null
                      ? ShimmerHelper().buildBasicShimmer(height: 50, width: 50)
                      : InkWell(
                          onTap: () {},
                          child: AppBannerImage(
                              height: 50,
                              width: 50,
                              fit: BoxFit.fill,
                              hasBorder: true,
                              borderWidth: 2,
                              borderColor: AppColors.secondary,
                              boarderRadius: 8,
                              isNetworkImage: true,
                              imgUrl: detailsController.productDetails.value
                                  .detailedProducts!.pictures![index].url!),
                        )),
            ),
            AppBannerImage(
                width: MediaQuery.of(context).size.width - 96,
                fit: BoxFit.scaleDown,
                applyImageRadius: false,
                isNetworkImage: true,
                imgUrl: detailsController
                    .productDetails.value.detailedProducts!.pictures![0].url!)
          ],
        ),
      );
    });
  }
}
