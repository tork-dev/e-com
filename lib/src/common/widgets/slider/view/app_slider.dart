import 'package:carousel_slider/carousel_slider.dart' as cw;
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/features/home/controller/home_controller.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:kirei/src/utils/helpers/routing_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';
import '../../containers/banner_image.dart';

class CustomSlider extends StatelessWidget {
  const CustomSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    HomeController controller = HomeController.instance;
    return AppCardContainer(
      child: Obx(() {
        return controller.homeSliders.isEmpty
            ? ShimmerHelper().buildBasicShimmer(height: 190)
            : InkWell(
                child: Stack(
                  children: [
                    InkWell(
                      onTap: () => RoutingHelper.urlRouting(
                          controller.homeSlidersLink[
                              controller.carouselCurrentIndex.value]),
                      child: cw.CarouselSlider(
                          items: controller.homeSliders
                              .map((dynamic url) => AppBannerImage(
                                  width: AppHelperFunctions.screenWidth(),
                                  isNetworkImage: true,
                                  fit: BoxFit.cover,
                                  imgUrl: url))
                              .toList(),
                          options: cw.CarouselOptions(
                            //aspectRatio: 3.37,
                            viewportFraction: 1,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 5),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 1000),
                            autoPlayCurve: Curves.easeInCubic,
                            enlargeCenterPage: true,
                            scrollDirection: Axis.horizontal,
                            onPageChanged: (index, _) =>
                                controller.updateCurrentIndex(index),
                          )),
                    ),
                    Obx(() => Positioned.fill(
                      bottom: 10,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child:
                        AnimatedSmoothIndicator(
                          activeIndex: controller.carouselCurrentIndex.value,
                          count:  controller.homeSliders.length,
                          axisDirection: Axis.horizontal,
                          effect:  CustomizableEffect(
                            activeColorOverride: (index) => AppColors.primary,
                              dotDecoration: DotDecoration(
                                height: 8,
                                width: 8,
                                dotBorder: DotBorder(padding: 3, color: AppColors.lightGrey, width: 1),
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.transparent,
                              ),
                              activeDotDecoration: DotDecoration(
                                height: 8,
                                width: 8,
                                dotBorder: DotBorder(padding: 3, color: AppColors.primary, width: 1),
                                borderRadius: BorderRadius.circular(100),
                                color: AppColors.primary,
                              ))
                        )
                      ),
                    ))
                  ],
                ),
              );
      }),
    );
  }
}
