import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:torganic/src/common/drawer/view/widgets/drawer_bottom_button.dart';
import 'package:torganic/src/common/styles/app_dividers.dart';
import 'package:torganic/src/common/widgets/buttons/app_buttons.dart';
import 'package:torganic/src/common/widgets/containers/card_container.dart';
import 'package:torganic/src/features/authentication/views/log_in/view/login.dart';
import 'package:torganic/src/features/authentication/views/sign_up/view/signup.dart';
import 'package:torganic/src/features/bottom_navigation/convex-bottom_navigation.dart';
import 'package:torganic/src/features/feedback/view/feedback_form.dart';
import 'package:torganic/src/features/home/controller/home_controller.dart';
import 'package:torganic/src/features/web_view/web_view.dart';
import 'package:torganic/src/utils/constants/image_strings.dart';
import 'package:torganic/src/utils/constants/sizes.dart';
import 'package:torganic/src/utils/helpers/helper_functions.dart';
import 'package:torganic/src/utils/local_storage/local_storage_keys.dart';
import 'package:torganic/src/utils/local_storage/storage_utility.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/auth_helper.dart';
import 'widgets/common_drawer_card.dart';
import 'widgets/drawer_card.dart';
import 'widgets/header_part.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = HomeController.instance;
    return AppCardContainer(
      padding: const EdgeInsets.only(bottom: 50),
      width: 300,
      backgroundColor: AppColors.white,
      applyRadius: false,
      child: ListView(
        children: [
          const AppDrawerHeaderPart(),
          AppDrawerCard(
            title: 'HOME',
            onPress: ()=> Get.offAll(()=> const HelloConvexAppBar()),
          ),
          AppDrawerCard(
            title: 'new arrivals',
            onPress: ()=> Get.offAll(()=> const HelloConvexAppBar()),
          ),
          ExpansionTile(
                  title: Row(
                    children: [
                      Text(
                        "Categories".toUpperCase(),
                        style: const TextStyle(
                          fontSize: 13,
                        ),
                      ),

                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                      ),

                      Stack(
                        children: [
                          Transform.rotate(
                            angle: pi/5,
                            child: Container(
                              margin: const EdgeInsets.only(
                                  top: 3
                              ),
                              height: 15,
                              width: 15,
                              decoration: const BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.pinkAccent,
                              ),
                            ),
                          ),
                          Container(
                            height: 22,
                            width: 45,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.pinkAccent,
                                borderRadius: BorderRadius.circular(2)
                            ),
                            child: const Text("New!",
                              style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  children: homeController.allCategories.map((category) {
                    return category.children != null &&
                        category.children!.isNotEmpty
                        ? Padding(
                      padding:  const EdgeInsets.only(left: 8.0),
                      child: ExpansionTile(
                        title: GestureDetector(
                            onTap: (){
                              // value.setCategoryKey(category.slug);
                              // Navigator.push(context,
                              //     MaterialPageRoute(builder: (context) {
                              //       return Main(pageIndex: 1,);
                              //     }));
                            },
                            child: Text(category.name)
                        ),
                        children: category.children!.map((child) {
                          return Padding(
                            padding:  const EdgeInsets.only(left: 8.0),
                            child: AppDrawerCard(
                              title: child.name,
                              onPress: ()=> Get.offAll(()=> const HelloConvexAppBar()),
                            ),
                          );
                        }).toList(),
                      ),
                    )
                        : Padding(
                      padding:  const EdgeInsets.only( left: 8.0),
                      child: AppDrawerCard(
                        title: category.name,
                        onPress: ()=> Get.offAll(()=> const HelloConvexAppBar()),
                      ),

                    );
                  }).toList(),
          ),
          ListTile(
              visualDensity:
              const VisualDensity(horizontal: -4, vertical: -4),
              title: Row(
                children: [
                  const Text('BRANDS',
                      style: TextStyle(fontSize: 13)),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),

                  Stack(
                    children: [
                      Transform.rotate(
                        angle: pi/5,
                        child: Container(
                          margin: const EdgeInsets.only(
                              top: 3
                          ),
                          height: 15,
                          width: 15,
                          decoration: const BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.pinkAccent,
                          ),
                        ),
                      ),
                      Container(
                        height: 22,
                        width: 45,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.pinkAccent,
                            borderRadius: BorderRadius.circular(2)
                        ),
                        child: const Text("Top!",
                          style: TextStyle(
                              color: AppColors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              onTap: () {
                Get.to(()=> WebViewScreen(
                  title: 'Brands',
                    url: "https://kireibd.com/brands?type=app"));
              }),
          AppDrawerCard(
            title: 'beauty tips',
            onPress: ()=> Get.offAll(()=> const HelloConvexAppBar()),
          ),
          AppDrawerCard(
            title: 'ai recomendation',
            onPress: ()=> Get.offAll(()=> const HelloConvexAppBar()),
          ),
          AppDrawerCard(
            title: 'community',
            onPress: ()=> Get.offAll(()=> const HelloConvexAppBar()),
          ),
          AppDrawerCard(
            title: 'appointment',
            onPress: ()=> Get.offAll(()=> const HelloConvexAppBar()),
          ),
          AppDrawerCard(
            title: 'blog',
            onPress: ()=> Get.offAll(()=> const HelloConvexAppBar()),
          ),
          ExpansionTile(
            title: Row(
              children: [
                Text(
                  "kirei".toUpperCase(),
                  style: const TextStyle(
                    fontSize: 13,
                  ),
                ),

                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),

                Stack(
                  children: [
                    Transform.rotate(
                      angle: pi/5,
                      child: Container(
                        margin: const EdgeInsets.only(
                            top: 3
                        ),
                        height: 15,
                        width: 15,
                        decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: AppColors.preorder,
                        ),
                      ),
                    ),
                    Container(
                      height: 22,
                      width: 45,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: AppColors.preorder,
                          borderRadius: BorderRadius.circular(2)
                      ),
                      child: const Text("INFO",
                        style: TextStyle(
                            color: AppColors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            children: [
              AppDrawerCard(
                title: 'who we are?',
                onPress: ()=> Get.offAll(()=> const HelloConvexAppBar()),
              ),
              AppDrawerCard(
                title: 'faqs',
                onPress: ()=> Get.offAll(()=> const HelloConvexAppBar()),
              ),
              AppDrawerCard(
                title: 'contact us',
                onPress: ()=> Get.offAll(()=> const HelloConvexAppBar()),
              ),
              AppDrawerCard(
                title: 'testimonials',
                onPress: ()=> Get.offAll(()=> const HelloConvexAppBar()),
              ),
              AppDrawerCard(
                title: 'privacy & policy',
                onPress: ()=> Get.offAll(()=> const HelloConvexAppBar()),
              ),
              AppDrawerCard(
                title: 'terms & condition',
                onPress: ()=> Get.offAll(()=> const HelloConvexAppBar()),
              ),
              AppDrawerCard(
                title: 'returns & refunds',
                onPress: ()=> Get.offAll(()=> const HelloConvexAppBar()),
              ),
              AppDrawerCard(
                title: 'responsibility disclosure',
                onPress: ()=> Get.offAll(()=> const HelloConvexAppBar()),
              ),
            ]
          ),
          Visibility(
            visible: AppLocalStorage().readData(LocalStorageKeys.isLoggedIn) == true,
              child: Column(
                children: [
                  AppDrawerCard(
                    title: 'profile',
                    onPress: ()=> Get.offAll(()=> const HelloConvexAppBar()),
                  ),
                  AppDrawerCard(
                    title: 'orders',
                    onPress: ()=> Get.offAll(()=> const HelloConvexAppBar()),
                  ),
                  AppDrawerCard(
                    title: 'logout',
                    onPress: ()=> Get.offAll(()=> const HelloConvexAppBar()),
                  ),
                ],
              )
          ),
          const Gap(AppSizes.xs),
          AppDividersStyle.fullFlatAppDivider,
          const Gap(AppSizes.xs),
          const AppDrawerBottomButton()

        ],
      ),
    );
  }
}




