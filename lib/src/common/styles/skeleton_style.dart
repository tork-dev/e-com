import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/helpers/helper_functions.dart';

class ShimmerHelper {

  Widget buildBasicShimmer({
    double? height,
    double? width,
    double radius = AppSizes.borderRadiusMd,
    isDark,
  }) {
    return Shimmer.fromColors(
      baseColor: AppColors.grey,
      highlightColor: AppColors.lightGrey.withAlpha((0.5 * 255).toInt()),
      child: SizedBox(
        height: height ?? AppHelperFunctions.screenHeight(),
        width: width ?? AppHelperFunctions.screenWidth(),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget buildAddressLoadingShimmer(
      {double height = double.infinity, double width = double.infinity, bool? isDark}) {
    return Shimmer.fromColors(
      baseColor: AppColors.white,
      highlightColor: AppColors.white,
      child: Container(
        height: height,
        width: width,
        color: Colors.white,
      ),
    );
  }

  Widget buildListShimmer({int  itemCount = 10, double itemHeight = 100,  bool? isDark}) {
    return ListView.builder(
      itemCount: itemCount,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(
              top: 0, left: 16, right: 16, bottom: 16),
          child: ShimmerHelper().buildBasicShimmer(height: itemHeight, isDark: isDark),
        );
      },
    );
  }

  Widget buildProductGridShimmer({ScrollController? sController, int itemCount = 10,  bool? isDark}) {
    return GridView.builder(
      itemCount: itemCount,
      controller: sController,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.7),
      padding: const EdgeInsets.all(8),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Shimmer.fromColors(
            baseColor: AppColors.grey,
            highlightColor: AppColors.grey,
            child: Container(
              height: 120,
              width: double.infinity,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }

  Widget buildHomeProductGridShimmer({ScrollController? sController, int itemCount = 10,  bool? isDark}) {
    return GridView.builder(
      itemCount: itemCount,
      controller: sController,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.85),
      padding: const EdgeInsets.all(8),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Shimmer.fromColors(
            baseColor: AppColors.primary.withAlpha((0.04 * 255).toInt()),
            highlightColor: AppColors.primary.withAlpha((0.08 * 255).toInt()),
            child: Container(
              height: 120,
              width: double.infinity,
              color: AppColors.primary,
            ),
          ),
        );
      },
    );
  }

  // buildHomeProductGridShimmer({scontroller, item_count = 10}) {
  //   return ListView.builder(
  //     scrollDirection: Axis.horizontal,
  //     itemCount: item_count,
  //     controller: scontroller,
  //     // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //     //     crossAxisCount: 2,
  //     //     crossAxisSpacing: 10,
  //     //     mainAxisSpacing: 10,
  //     //     childAspectRatio: 0.85),
  //     padding: EdgeInsets.all(8),
  //     physics: NeverScrollableScrollPhysics(),
  //     shrinkWrap: true,
  //     itemBuilder: (context, index) {
  //       return Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: Shimmer.fromColors(
  //           baseColor: MyTheme.light_grey,
  //           highlightColor: MyTheme.light_grey,
  //           child: Container(
  //             height: 120,
  //             width: 60,
  //             color: Colors.white,
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  Widget buildSquareGridShimmer({ScrollController? sController, int itemCount = 10,  required bool isDark}) {
    return GridView.builder(
      itemCount: itemCount,
      controller: sController,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1
      ),
      padding: const EdgeInsets.all(8),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Shimmer.fromColors(
            baseColor: isDark? AppColors.dark : AppColors.grey,
            highlightColor: isDark? AppColors.darkGrey : AppColors.lightGrey,
            child: Container(
              height: 120,
              width: double.infinity,
              color: isDark? AppColors.dark : AppColors.light,
            ),
          ),
        );
      },
    );
  }
}