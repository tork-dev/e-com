import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../common/styles/skeleton_style.dart';
import '../../../../common/widgets/buttons/app_buttons.dart';
import '../../../../common/widgets/containers/card_container.dart';
import '../../../../common/widgets/tab_bar/tab_card.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../controller/blogs_controller.dart';

class BlogFilterPart extends StatelessWidget {
  const BlogFilterPart({super.key});

  @override
  Widget build(BuildContext context) {
    // final themeController = ThemeController.instance;
    final blogController = BlogsController.instance;

    return AppCardContainer(
          width: AppHelperFunctions.screenWidth(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppCardContainer(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.md,
                      ),
                      height: 52,
                      width: AppHelperFunctions.screenWidth() * 0.78,
                      borderRadius: AppSizes.cardRadiusMd,
                      backgroundColor: AppColors.light,
                      child: TextFormField(
                        controller: blogController.searchController,
                        onChanged: (value) {

                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(AppSizes.md),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            prefixIcon: const Icon(Icons.search),
                            hintText: "Search",
                            hintStyle: Theme.of(context).textTheme.labelLarge),
                      )),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) {
                            return Stack(children: [
                              Container(
                                  height:
                                      AppHelperFunctions.screenHeight() * 0.83,
                                  width: AppHelperFunctions.screenWidth(),
                                  decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(32),
                                        topRight: Radius.circular(32),
                                      )),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: AppSizes.md,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Filter",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineMedium,
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  icon: const Icon(Icons.close))
                                            ],
                                          ),
                                        ),
                                        // AppHelperFunctions.appDivider(),
                                        const Gap(AppSizes.md),
                                        Expanded(
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.vertical,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal:
                                                    AppSizes.md,
                                              ),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Categories",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headlineSmall,
                                                    ),
                                                    const Gap(AppSizes.sm),
                                                    Wrap(
                                                      spacing: 4.0,
                                                      runSpacing: 4.0,
                                                      children: blogController.blogsResponseData.value.data!.blogCategoryList
                                                          !.map<Widget>((item) {
                                                        return Obx(() {
                                                          return ChoiceChip(
                                                            onSelected: (isSelected) {
                                                              if (isSelected) {
                                                                blogController.selectedCategories.value = item.name!;
                                                              }
                                                            },
                                                            selectedColor: AppColors.primary,
                                                            backgroundColor: AppColors.lightGrey,
                                                            disabledColor: AppColors.lightGrey,
                                                            label: Text(
                                                              item.name!,
                                                              style: Theme.of(context).textTheme.titleSmall!.apply(
                                                                color: blogController.selectedCategories.value == item.name
                                                                    ? AppColors.textWhite
                                                                    : AppColors.textPrimary,
                                                              ),
                                                            ),
                                                            selected: blogController.selectedCategories.value == item.name,
                                                            showCheckmark: false,
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(20),
                                                              side: const BorderSide(
                                                                width: 0,
                                                                color: Colors.transparent,
                                                              ),
                                                            ),
                                                          );
                                                        });
                                                      }).toList(), // Convert to List<Widget>
                                                    ),
                                                    Gap(AppHelperFunctions
                                                            .screenHeight() *
                                                        0.2)
                                                  ]),
                                            ),
                                          ),
                                        ),
                                      ])),
                              Positioned(
                                bottom: 0,
                                child: AppCardContainer(
                                  height:
                                      AppHelperFunctions.screenHeight() * 0.10,
                                  width: AppHelperFunctions.screenWidth(),
                                  topLeftRadius: 32,
                                  topRightRadius: 32,
                                  backgroundColor: AppColors.white,
                                  applyShadow: true,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: AppSizes.md,
                                        ),
                                        child: SizedBox(
                                          height: 52,
                                          width:
                                              AppHelperFunctions.screenWidth() *
                                                  0.4,
                                          child:
                                              AppButtons.largeFlatOutlineButton(
                                            onPressed: () {
                                              blogController.clearFilter();
                                              blogController.getAllBlogData();
                                              Get.back();
                                            },
                                            buttonText: "Reset filter",
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: AppSizes.md,
                                        ),
                                        child: SizedBox(
                                          height: 52,
                                          width:
                                              AppHelperFunctions.screenWidth() *
                                                  0.4,
                                          child:
                                              AppButtons.largeFlatFilledButton(
                                            onPressed: () {
                                              blogController.getAllBlogData();
                                              Get.back();
                                            },
                                            buttonText: "Apply filter",
                                            buttonTextColor:
                                                AppColors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ]);
                          });
                    },
                    child: AppCardContainer(
                      padding: EdgeInsets.all(AppSizes.sm),
                      height: 45,
                      width: AppHelperFunctions.screenWidth() * 0.12,
                      borderRadius: AppSizes.cardRadiusMd,
                      backgroundColor:  AppColors.lightGrey,
                      child: Icon(Icons.filter_alt_rounded),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
  }
}
