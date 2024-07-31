import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/authentication/views/log_in/view/login.dart';
import 'package:kirei/src/features/cart/view/widgets/cart_screen_card.dart';
import 'package:kirei/src/features/community/controller/community_controller.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';

class CommunityHeader extends StatelessWidget {
  const CommunityHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final communityController = CommunityController.instance;
    return AppCardContainer(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.all(AppSizes.md),
        applyShadow: true,
        child: Column(
          children: [
            Text(
              'Community Post',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .apply(color: Colors.blue),
            ),
            TextFormField(
              controller: communityController.communityFieldController,
              keyboardType: TextInputType.multiline,
              onChanged: (value) {
                if (AppLocalStorage().readData(LocalStorageKeys.isLoggedIn) !=
                    true) {
                  Get.to(() => const LogIn());
                }
              },
              onFieldSubmitted: (value) {
                if (AppLocalStorage().readData(LocalStorageKeys.isLoggedIn) !=
                    true) {
                  Get.to(() => const LogIn());
                }
              },
              minLines: 3,
              maxLines: 5,
              cursorColor: AppColors.primary,
              decoration: const InputDecoration(
                  hintText: 'Share your mind on community..',
                  hintStyle: TextStyle(color: AppColors.darkGrey),
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.primary, width: 2))),
              validator: (v) {
                if (v!.trim().isEmpty) {
                  return 'Please enter something';
                }
                return null;
              },
            ),
            const Gap(
              AppSizes.spaceBtwItems,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 100,
                  child: Obx(() {
                    return Text(
                      communityController.imageName.value,
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .apply(overflow: TextOverflow.ellipsis),
                    );
                  }),
                ),
                AppCardContainer(
                  height: 40,
                  applyRadius: false,
                  padding: const EdgeInsets.symmetric(horizontal: AppSizes.xl),
                  backgroundColor: AppColors.backLayoutAppBarTitle,
                  child: InkWell(
                    onTap: () {
                      if (AppLocalStorage()
                              .readData(LocalStorageKeys.isLoggedIn) ==
                          true) {
                        communityController.pickImage();
                      } else {
                        Get.to(() => const LogIn());
                      }
                    },
                    child: const Icon(Icons.add_photo_alternate_outlined,
                        color: Colors.white),
                    // color: Colors.blueGrey,
                  ),
                ),
                const Gap(AppSizes.md),
                AppCardContainer(
                  height: 40,
                  borderRadius: AppSizes.xs,
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.xl, vertical: AppSizes.xs),
                  gradient: const LinearGradient(colors: [
                    Colors.teal,
                    Colors.lightBlue,
                    Colors.deepPurple
                  ]),
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        if (AppLocalStorage()
                                .readData(LocalStorageKeys.isLoggedIn) ==
                            true) {
                          communityController.createCommunityPost();
                        } else {
                          Get.to(() => const LogIn());
                        }
                      },
                      child: Text(
                        "Add",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.ubuntu(
                            color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),

                // const SizedBox(width: 20),
                // InkWell(
                //   onTap: () async {
                //     if (AppLocalStorage().readData(LocalStorageKeys.isLoggedIn) ==
                //         true) {
                //      // await addCommunityPost(context);
                //     } else {
                //       Get.to(()=> const LogIn());
                //     }
                //   },
                //   // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
                //   // padding: const EdgeInsets.all(0.0),
                //   child: Ink(
                //     decoration: BoxDecoration(
                //       //gradient: FlutterGradients.denseWater(type: GradientType.linear, center: Alignment.center),
                //       borderRadius: BorderRadius.circular(10.0),
                //     ),
                //     child: Container(
                //       constraints: const BoxConstraints(maxWidth: 100.0, minHeight: 36.0),
                //       alignment: Alignment.center,
                //       child: Text(
                //         "Add",
                //         textAlign: TextAlign.center,
                //         style: GoogleFonts.ubuntu(color: Colors.white, fontSize: 16),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            )
          ],
        ));
  }
}
