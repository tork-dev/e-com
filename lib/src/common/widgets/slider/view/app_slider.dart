import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/common/widgets/slider/controller/slider_controller.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../containers/banner_image.dart';


class CustomSlider extends StatelessWidget {
  const CustomSlider({
   // required this.items,
    //required this.width,
    super.key,
  });



  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SliderController());
    return AppCardContainer(
      height: 150,
      //backgroundColor: Colors.black,
      child: Obx(() {
        return controller.homeSliders.isEmpty ?  ShimmerHelper().buildBasicShimmer() :
           Stack(
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Positioned.fill(
                child: CarouselSlider(
                     //items: items,
                    items: controller.homeSliders.map((url) => AppBannerImage(
                      width: AppHelperFunctions.screenWidth(),
                      isNetworkImage: true,
                        fit: BoxFit.cover,
                        imgUrl: url)).toList(),

                    options: CarouselOptions(
                        //aspectRatio: 3.37,
                        viewportFraction: 1,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 5),
                        autoPlayAnimationDuration: const Duration(milliseconds: 1000),
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
                  child: AnimatedSmoothIndicator(
                    activeIndex: controller.carouselCurrentIndex.value,
                    count: controller.homeSliders.length,
                    effect: const WormEffect(
                      activeDotColor: AppColors.primary,
                      dotHeight: 6
                    ),
                  ),
                ),
              ) )

              //SmoothPageIndicator(controller: controller.pageController, count: items.length)
            ],
          );
        }
      ),
    );
  }
}
