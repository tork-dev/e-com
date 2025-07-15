// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get.dart';
// import '../../../../../common/styles/skeleton_style.dart';
// import '../../../../../common/widgets/buttons/app_buttons.dart';
// import '../../../../../common/widgets/containers/card_container.dart';
// import '../../../../../common/widgets/tab_bar/tabs_card.dart';
// import '../../../../../utils/constants/colors.dart';
// import '../../../../../utils/constants/sizes.dart';
// import '../../../../../utils/helpers/helper_functions.dart';
// import '../../../../../utils/responsive/responsive.dart';
// import '../../../settings/controller/theme_controller.dart';
// import '../../controller/blogs_controller.dart';
//
// class BlogFilterPart extends StatelessWidget {
//   const BlogFilterPart({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final themeController = ThemeController.instance;
//     final blogController = BlogsController.instance;
//
//     return ResponsiveWidget(
//         desktop: AppCardContainer(
//           width: AppHelperFunctions.screenWidth(),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   AppCardContainer(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: AppSizes.mobilePadding,
//                       ),
//                       height: 45,
//                       width: AppHelperFunctions.screenWidth() * 0.78,
//                       borderRadius: 32,
//                       backgroundColor: AppColors.lightGrey,
//                       child: TextFormField(
//                         controller: blogController.searchController,
//                         onChanged: (value) {
//                           blogController.searchName.value =
//                               blogController.searchController.text.toString();
//                           // coursePageController.getCoursesData();
//                         },
//                         decoration: InputDecoration(
//                             border: InputBorder.none,
//                             enabledBorder: InputBorder.none,
//                             focusedBorder: InputBorder.none,
//                             prefixIcon: const Icon(Icons.search),
//                             hintText: "Search",
//                             hintStyle: Theme.of(context).textTheme.labelLarge),
//                       )),
//                   InkWell(
//                     onTap: () {
//                       showModalBottomSheet(
//                           isScrollControlled: true,
//                           context: context,
//                           builder: (BuildContext context) {
//                             return Stack(children: [
//                               Container(
//                                   height:
//                                       AppHelperFunctions.screenHeight() * 0.83,
//                                   width: AppHelperFunctions.screenWidth(),
//                                   decoration: const BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.only(
//                                         topLeft: Radius.circular(32),
//                                         topRight: Radius.circular(32),
//                                       )),
//                                   child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Padding(
//                                           padding: const EdgeInsets.symmetric(
//                                             horizontal: AppSizes.mobilePadding,
//                                           ),
//                                           child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Text(
//                                                 "Filter",
//                                                 style: Theme.of(context)
//                                                     .textTheme
//                                                     .headlineMedium,
//                                               ),
//                                               IconButton(
//                                                   onPressed: () {
//                                                     Get.back();
//                                                   },
//                                                   icon: const Icon(Icons.close))
//                                             ],
//                                           ),
//                                         ),
//                                         AppHelperFunctions.appDivider(),
//                                         const Gap(AppSizes.mmGap),
//                                         Expanded(
//                                           child: SingleChildScrollView(
//                                             scrollDirection: Axis.vertical,
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.symmetric(
//                                                 horizontal:
//                                                     AppSizes.mobilePadding,
//                                               ),
//                                               child: Column(
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   children: [
//                                                     Text(
//                                                       "Tags",
//                                                       style: Theme.of(context)
//                                                           .textTheme
//                                                           .headlineLarge,
//                                                     ),
//                                                     const Gap(AppSizes.msGap),
//                                                     Wrap(
//                                                       spacing: 4.0,
//                                                       runSpacing: 4.0,
//                                                       children: blogController
//                                                           .blogTags.value.tags!
//                                                           .map<Widget>((tags) {
//                                                         return Obx(() {
//                                                           return ChoiceChip(
//                                                             onSelected:
//                                                                 (isSelected) {
//                                                               if (blogController
//                                                                   .selectedTagsList
//                                                                   .contains(
//                                                                       tags)) {
//                                                                 blogController
//                                                                     .selectedTagsList
//                                                                     .remove(
//                                                                         tags); // Remove if already selected
//                                                               } else {
//                                                                 blogController
//                                                                     .selectedTagsList
//                                                                     .add(
//                                                                         tags); // Add if not selected
//                                                               }
//                                                             },
//                                                             selectedColor:
//                                                                 AppColors
//                                                                     .primaryColor,
//                                                             backgroundColor:
//                                                                 AppColors
//                                                                     .cardPrimaryColor,
//                                                             disabledColor: AppColors
//                                                                 .cardPrimaryColor,
//                                                             label: Text(
//                                                               tags.toString(),
//                                                               // Display the label of each topic
//                                                               style: Theme.of(
//                                                                       context)
//                                                                   .textTheme
//                                                                   .titleSmall!
//                                                                   .apply(
//                                                                     color: blogController.selectedTagsList.contains(
//                                                                             tags)
//                                                                         ? AppColors
//                                                                             .textWhite
//                                                                         : !themeController.isDarkMode.value? AppColors
//                                                                             .textPrimaryColor : AppColors.textPrimaryColorDark,
//                                                                   ),
//                                                             ),
//                                                             selected: blogController
//                                                                 .selectedTagsList
//                                                                 .contains(tags),
//                                                             // Check if this chip is selected based on its value
//                                                             showCheckmark:
//                                                                 false,
//                                                             shape:
//                                                                 RoundedRectangleBorder(
//                                                               borderRadius:
//                                                                   BorderRadius
//                                                                       .circular(
//                                                                           20),
//                                                               side:
//                                                                   const BorderSide(
//                                                                 width: 0,
//                                                                 color: Colors
//                                                                     .transparent,
//                                                               ),
//                                                             ),
//                                                           );
//                                                         });
//                                                       }).toList(), // Convert to List<Widget>
//                                                     ),
//                                                     Gap(AppHelperFunctions
//                                                             .screenHeight() *
//                                                         0.2)
//                                                   ]),
//                                             ),
//                                           ),
//                                         ),
//                                       ])),
//                               Positioned(
//                                 bottom: 0,
//                                 child: AppCardContainer(
//                                   height:
//                                       AppHelperFunctions.screenHeight() * 0.10,
//                                   width: AppHelperFunctions.screenWidth(),
//                                   applySingleRadius: true,
//                                   topLeftRadius: 32,
//                                   topRightRadius: 32,
//                                   backgroundColor: AppColors.white,
//                                   applyShadow: true,
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Padding(
//                                         padding: const EdgeInsets.only(
//                                           left: AppSizes.mobilePadding,
//                                         ),
//                                         child: SizedBox(
//                                           height: 52,
//                                           width:
//                                               AppHelperFunctions.screenWidth() *
//                                                   0.4,
//                                           child:
//                                               AppButtons.largeFlatOutlineButton(
//                                             onPressed: () {
//                                               blogController.clearFilter();
//                                               blogController.getAllBlogData();
//                                               Get.back();
//                                             },
//                                             buttonText: "Reset filter",
//                                             isBorderRadiousSize: true,
//                                             borderRediousSize: 32,
//                                             buttonTextColor:
//                                                 AppColors.buttonTextColorBlack,
//                                             isPadding: true,
//                                           ),
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets.only(
//                                           left: AppSizes.mobilePadding,
//                                         ),
//                                         child: SizedBox(
//                                           height: 52,
//                                           width:
//                                               AppHelperFunctions.screenWidth() *
//                                                   0.4,
//                                           child:
//                                               AppButtons.largeFlatFilledButton(
//                                             onPressed: () {
//                                               blogController.getAllBlogData();
//                                               Get.back();
//                                             },
//                                             buttonText: "Apply filter",
//                                             color: AppColors.primaryColor,
//                                             buttonTextColor:
//                                                 AppColors.buttonTextColor,
//                                             isBorderRadiousSize: true,
//                                             borderRediousSize: 32,
//                                             isPadding: true,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               )
//                             ]);
//                           });
//                     },
//                     child: AppCardContainer(
//                       height: 45,
//                       width: AppHelperFunctions.screenWidth() * 0.12,
//                       borderRadius: 32,
//                       backgroundColor: AppColors.lightGrey,
//                       child: SvgPicture.asset(
//                         "assets/images/icons/Filter.svg",
//                         height: 10,
//                         width: 10,
//                         fit: BoxFit.scaleDown,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const Gap(AppSizes.msGap),
//               SizedBox(
//                 height: 32,
//                 child: Obx(() {
//                   return ListView(
//                     shrinkWrap: true,
//                     scrollDirection: Axis.horizontal,
//                     children: List<Widget>.generate(
//                       blogController.blogCategories.value.data?.length ?? 5,
//                       (int index) {
//                         return Align(
//                             alignment: Alignment.topLeft,
//                             child: blogController.categoryApiHitting.value
//                                 ? ShimmerHelper()
//                                     .buildBasicShimmer(height: 32, width: 100)
//                                 : AppTabsCard(
//                                     onTap: () {
//                                       blogController.selectedCategories.value =
//                                           blogController.blogCategories.value
//                                               .data![index].title!;
//                                       blogController.getAllBlogData();
//                                     },
//                                     isNeedPadding: true,
//                                     tabName: blogController.blogCategories.value
//                                             .data?[index].title ??
//                                         '',
//                                     backgroundColor: blogController
//                                                 .selectedCategories.value ==
//                                             blogController.blogCategories.value
//                                                 .data![index].title!
//                                         ? AppColors.primaryColor
//                                         : AppColors.cardPrimaryColor,
//                                     tabCardTextColor: blogController
//                                                 .selectedCategories.value ==
//                                             blogController.blogCategories.value
//                                                 .data![index].title!
//                                         ? AppColors.textWhite
//                                         : !themeController.isDarkMode.value? AppColors.textPrimaryColor : AppColors.textPrimaryColorDark,
//                                   ));
//                       },
//                     ).toList(),
//                   );
//                 }),
//               ),
//             ],
//           ),
//         ),
//         tablet: AppCardContainer(
//           width: AppHelperFunctions.screenWidth(),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   AppCardContainer(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: AppSizes.mobilePadding,
//                       ),
//                       height: 45,
//                       width: AppHelperFunctions.screenWidth() * 0.78,
//                       borderRadius: 32,
//                       backgroundColor: AppColors.lightGrey,
//                       child: TextFormField(
//                         controller: blogController.searchController,
//                         onChanged: (value) {
//                           blogController.searchName.value =
//                               blogController.searchController.text.toString();
//                           // coursePageController.getCoursesData();
//                         },
//                         decoration: InputDecoration(
//                             border: InputBorder.none,
//                             enabledBorder: InputBorder.none,
//                             focusedBorder: InputBorder.none,
//                             prefixIcon: const Icon(Icons.search),
//                             hintText: "Search",
//                             hintStyle: Theme.of(context).textTheme.labelLarge),
//                       )),
//                   InkWell(
//                     onTap: () {
//                       showModalBottomSheet(
//                           isScrollControlled: true,
//                           context: context,
//                           builder: (BuildContext context) {
//                             return Stack(children: [
//                               Container(
//                                   height:
//                                       AppHelperFunctions.screenHeight() * 0.83,
//                                   width: AppHelperFunctions.screenWidth(),
//                                   decoration: const BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.only(
//                                         topLeft: Radius.circular(32),
//                                         topRight: Radius.circular(32),
//                                       )),
//                                   child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Padding(
//                                           padding: const EdgeInsets.symmetric(
//                                             horizontal: AppSizes.mobilePadding,
//                                           ),
//                                           child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Text(
//                                                 "Filter",
//                                                 style: Theme.of(context)
//                                                     .textTheme
//                                                     .headlineMedium,
//                                               ),
//                                               IconButton(
//                                                   onPressed: () {
//                                                     Get.back();
//                                                   },
//                                                   icon: const Icon(Icons.close))
//                                             ],
//                                           ),
//                                         ),
//                                         AppHelperFunctions.appDivider(),
//                                         const Gap(AppSizes.mmGap),
//                                         Expanded(
//                                           child: SingleChildScrollView(
//                                             scrollDirection: Axis.vertical,
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.symmetric(
//                                                 horizontal:
//                                                     AppSizes.mobilePadding,
//                                               ),
//                                               child: Column(
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   children: [
//                                                     Text(
//                                                       "Tags",
//                                                       style: Theme.of(context)
//                                                           .textTheme
//                                                           .headlineLarge,
//                                                     ),
//                                                     const Gap(AppSizes.msGap),
//                                                     Wrap(
//                                                       spacing: 4.0,
//                                                       runSpacing: 4.0,
//                                                       children: blogController
//                                                           .blogTags.value.tags!
//                                                           .map<Widget>((tags) {
//                                                         return Obx(() {
//                                                           return ChoiceChip(
//                                                             onSelected:
//                                                                 (isSelected) {
//                                                               if (blogController
//                                                                   .selectedTagsList
//                                                                   .contains(
//                                                                       tags)) {
//                                                                 blogController
//                                                                     .selectedTagsList
//                                                                     .remove(
//                                                                         tags); // Remove if already selected
//                                                               } else {
//                                                                 blogController
//                                                                     .selectedTagsList
//                                                                     .add(
//                                                                         tags); // Add if not selected
//                                                               }
//                                                             },
//                                                             selectedColor:
//                                                                 AppColors
//                                                                     .primaryColor,
//                                                             backgroundColor:
//                                                                 AppColors
//                                                                     .cardPrimaryColor,
//                                                             disabledColor: AppColors
//                                                                 .cardPrimaryColor,
//                                                             label: Text(
//                                                               tags.toString(),
//                                                               // Display the label of each topic
//                                                               style: Theme.of(
//                                                                       context)
//                                                                   .textTheme
//                                                                   .titleSmall!
//                                                                   .apply(
//                                                                     color: blogController.selectedTagsList.contains(
//                                                                             tags)
//                                                                         ? AppColors
//                                                                             .textWhite
//                                                                         : !themeController.isDarkMode.value? AppColors
//                                                                             .textPrimaryColor : AppColors.textPrimaryColorDark,
//                                                                   ),
//                                                             ),
//                                                             selected: blogController
//                                                                 .selectedTagsList
//                                                                 .contains(tags),
//                                                             // Check if this chip is selected based on its value
//                                                             showCheckmark:
//                                                                 false,
//                                                             shape:
//                                                                 RoundedRectangleBorder(
//                                                               borderRadius:
//                                                                   BorderRadius
//                                                                       .circular(
//                                                                           20),
//                                                               side:
//                                                                   const BorderSide(
//                                                                 width: 0,
//                                                                 color: Colors
//                                                                     .transparent,
//                                                               ),
//                                                             ),
//                                                           );
//                                                         });
//                                                       }).toList(), // Convert to List<Widget>
//                                                     ),
//                                                     Gap(AppHelperFunctions
//                                                             .screenHeight() *
//                                                         0.2)
//                                                   ]),
//                                             ),
//                                           ),
//                                         ),
//                                       ])),
//                               Positioned(
//                                 bottom: 0,
//                                 child: AppCardContainer(
//                                   height:
//                                       AppHelperFunctions.screenHeight() * 0.10,
//                                   width: AppHelperFunctions.screenWidth(),
//                                   applySingleRadius: true,
//                                   topLeftRadius: 32,
//                                   topRightRadius: 32,
//                                   backgroundColor: AppColors.white,
//                                   applyShadow: true,
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Padding(
//                                         padding: const EdgeInsets.only(
//                                           left: AppSizes.mobilePadding,
//                                         ),
//                                         child: SizedBox(
//                                           height: 52,
//                                           width:
//                                               AppHelperFunctions.screenWidth() *
//                                                   0.4,
//                                           child:
//                                               AppButtons.largeFlatOutlineButton(
//                                             onPressed: () {
//                                               blogController.clearFilter();
//                                               blogController.getAllBlogData();
//                                               Get.back();
//                                             },
//                                             buttonText: "Reset filter",
//                                             isBorderRadiousSize: true,
//                                             borderRediousSize: 32,
//                                             buttonTextColor:
//                                                 AppColors.buttonTextColorBlack,
//                                             isPadding: true,
//                                           ),
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets.only(
//                                           left: AppSizes.mobilePadding,
//                                         ),
//                                         child: SizedBox(
//                                           height: 52,
//                                           width:
//                                               AppHelperFunctions.screenWidth() *
//                                                   0.4,
//                                           child:
//                                               AppButtons.largeFlatFilledButton(
//                                             onPressed: () {
//                                               blogController.getAllBlogData();
//                                               Get.back();
//                                             },
//                                             buttonText: "Apply filter",
//                                             color: AppColors.primaryColor,
//                                             buttonTextColor:
//                                                 AppColors.buttonTextColor,
//                                             isBorderRadiousSize: true,
//                                             borderRediousSize: 32,
//                                             isPadding: true,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               )
//                             ]);
//                           });
//                     },
//                     child: AppCardContainer(
//                       height: 45,
//                       width: AppHelperFunctions.screenWidth() * 0.12,
//                       borderRadius: 32,
//                       backgroundColor: AppColors.lightGrey,
//                       child: SvgPicture.asset(
//                         "assets/images/icons/Filter.svg",
//                         height: 10,
//                         width: 10,
//                         fit: BoxFit.scaleDown,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const Gap(AppSizes.msGap),
//               SizedBox(
//                 height: 32,
//                 child: Obx(() {
//                   return ListView(
//                     shrinkWrap: true,
//                     scrollDirection: Axis.horizontal,
//                     children: List<Widget>.generate(
//                       blogController.blogCategories.value.data?.length ?? 5,
//                       (int index) {
//                         return Align(
//                             alignment: Alignment.topLeft,
//                             child: blogController.categoryApiHitting.value
//                                 ? ShimmerHelper()
//                                     .buildBasicShimmer(height: 32, width: 100)
//                                 : AppTabsCard(
//                                     onTap: () {
//                                       blogController.selectedCategories.value =
//                                           blogController.blogCategories.value
//                                               .data![index].title!;
//                                       blogController.getAllBlogData();
//                                     },
//                                     isNeedPadding: true,
//                                     tabName: blogController.blogCategories.value
//                                             .data?[index].title ??
//                                         '',
//                                     backgroundColor: blogController
//                                                 .selectedCategories.value ==
//                                             blogController.blogCategories.value
//                                                 .data![index].title!
//                                         ? AppColors.primaryColor
//                                         : AppColors.cardPrimaryColor,
//                                     tabCardTextColor: blogController
//                                                 .selectedCategories.value ==
//                                             blogController.blogCategories.value
//                                                 .data![index].title!
//                                         ? AppColors
//                                         .textWhite
//                                         : !themeController.isDarkMode.value? AppColors
//                                         .textPrimaryColor : AppColors.textPrimaryColorDark,
//                                   ));
//                       },
//                     ).toList(),
//                   );
//                 }),
//               ),
//             ],
//           ),
//         ),
//         mobile: AppCardContainer(
//           width: AppHelperFunctions.screenWidth(),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   AppCardContainer(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: AppSizes.mobilePadding,
//                       ),
//                       height: 45,
//                       width: AppHelperFunctions.screenWidth() * 0.78,
//                       borderRadius: 32,
//                       backgroundColor: !themeController.isDarkMode.value
//                           ? AppColors.lightGrey
//                           : AppColors.dark,
//                       child: TextFormField(
//                         controller: blogController.searchController,
//                         onChanged: (value) {
//                           blogController.searchName.value =
//                               blogController.searchController.text.toString();
//                           // coursePageController.getCoursesData();
//                         },
//                         decoration: InputDecoration(
//                             border: InputBorder.none,
//                             enabledBorder: InputBorder.none,
//                             focusedBorder: InputBorder.none,
//                             prefixIcon: const Icon(Icons.search),
//                             hintText: "Search",
//                             hintStyle: Theme.of(context).textTheme.labelLarge),
//                       )),
//                   InkWell(
//                     onTap: () {
//                       showModalBottomSheet(
//                           isScrollControlled: true,
//                           context: context,
//                           builder: (BuildContext context) {
//                             return Stack(children: [
//                               Container(
//                                   height:
//                                       AppHelperFunctions.screenHeight() * 0.83,
//                                   width: AppHelperFunctions.screenWidth(),
//                                   decoration: BoxDecoration(
//                                       color: !themeController.isDarkMode.value
//                                           ? AppColors.white
//                                           : AppColors.dark,
//                                       borderRadius: const BorderRadius.only(
//                                         topLeft: Radius.circular(32),
//                                         topRight: Radius.circular(32),
//                                       )),
//                                   child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Padding(
//                                           padding: const EdgeInsets.symmetric(
//                                             horizontal: AppSizes.mobilePadding,
//                                           ),
//                                           child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Text(
//                                                 "Filter",
//                                                 style: Theme.of(context)
//                                                     .textTheme
//                                                     .headlineMedium,
//                                               ),
//                                               IconButton(
//                                                   onPressed: () {
//                                                     Get.back();
//                                                   },
//                                                   icon: const Icon(Icons.close))
//                                             ],
//                                           ),
//                                         ),
//                                         AppHelperFunctions.appDivider(),
//                                         const Gap(AppSizes.mmGap),
//                                         Expanded(
//                                           child: SingleChildScrollView(
//                                             scrollDirection: Axis.vertical,
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.symmetric(
//                                                 horizontal:
//                                                     AppSizes.mobilePadding,
//                                               ),
//                                               child: Column(
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   children: [
//                                                     Text(
//                                                       "Tags",
//                                                       style: Theme.of(context)
//                                                           .textTheme
//                                                           .headlineLarge,
//                                                     ),
//                                                     const Gap(AppSizes.msGap),
//                                                     Wrap(
//                                                       spacing: 4.0,
//                                                       runSpacing: 4.0,
//                                                       children: blogController
//                                                           .blogTags.value.tags!
//                                                           .map<Widget>((tags) {
//                                                         return Obx(() {
//                                                           return ChoiceChip(
//                                                             onSelected:
//                                                                 (isSelected) {
//                                                               if (blogController
//                                                                   .selectedTagsList
//                                                                   .contains(
//                                                                       tags)) {
//                                                                 blogController
//                                                                     .selectedTagsList
//                                                                     .remove(
//                                                                         tags); // Remove if already selected
//                                                               } else {
//                                                                 blogController
//                                                                     .selectedTagsList
//                                                                     .add(
//                                                                         tags); // Add if not selected
//                                                               }
//                                                             },
//                                                             selectedColor:
//                                                                 AppColors
//                                                                     .primaryColor,
//                                                             backgroundColor:
//                                                                 !themeController
//                                                                         .isDarkMode
//                                                                         .value
//                                                                     ? AppColors
//                                                                         .cardPrimaryColor
//                                                                     : AppColors
//                                                                         .containerColorDark,
//                                                             disabledColor: AppColors
//                                                                 .cardPrimaryColor,
//                                                             label: Text(
//                                                               tags.toString(),
//                                                               // Display the label of each topic
//                                                               style: Theme.of(
//                                                                       context)
//                                                                   .textTheme
//                                                                   .titleSmall!
//                                                                   .apply(
//                                                                     color: blogController.selectedTagsList.contains(tags) ||
//                                                                             themeController
//                                                                                 .isDarkMode.value
//                                                                         ? AppColors
//                                                                         .textWhite
//                                                                         : !themeController.isDarkMode.value? AppColors
//                                                                         .textPrimaryColor : AppColors.textPrimaryColorDark,
//                                                                   ),
//                                                             ),
//                                                             selected: blogController
//                                                                 .selectedTagsList
//                                                                 .contains(tags),
//                                                             // Check if this chip is selected based on its value
//                                                             showCheckmark:
//                                                                 false,
//                                                             shape:
//                                                                 RoundedRectangleBorder(
//                                                               borderRadius:
//                                                                   BorderRadius
//                                                                       .circular(
//                                                                           20),
//                                                               side:
//                                                                   const BorderSide(
//                                                                 width: 0,
//                                                                 color: Colors
//                                                                     .transparent,
//                                                               ),
//                                                             ),
//                                                           );
//                                                         });
//                                                       }).toList(), // Convert to List<Widget>
//                                                     ),
//                                                     Gap(AppHelperFunctions
//                                                             .screenHeight() *
//                                                         0.2)
//                                                   ]),
//                                             ),
//                                           ),
//                                         ),
//                                       ])),
//                               Positioned(
//                                 bottom: 0,
//                                 child: AppCardContainer(
//                                   height:
//                                       AppHelperFunctions.screenHeight() * 0.10,
//                                   width: AppHelperFunctions.screenWidth(),
//                                   applySingleRadius: true,
//                                   topLeftRadius: 32,
//                                   topRightRadius: 32,
//                                   backgroundColor:
//                                       !themeController.isDarkMode.value
//                                           ? AppColors.white
//                                           : AppColors.containerColorDark,
//                                   applyShadow:
//                                       !themeController.isDarkMode.value,
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Padding(
//                                         padding: const EdgeInsets.only(
//                                           left: AppSizes.mobilePadding,
//                                         ),
//                                         child: SizedBox(
//                                           height: 52,
//                                           width:
//                                               AppHelperFunctions.screenWidth() *
//                                                   0.4,
//                                           child:
//                                               AppButtons.largeFlatOutlineButton(
//                                             onPressed: () {
//                                               blogController.clearFilter();
//                                               blogController.getAllBlogData();
//                                               Get.back();
//                                             },
//                                             buttonText: "Reset filter",
//                                             isBorderRadiousSize: true,
//                                             borderRediousSize: 32,
//                                             borderColor: !themeController
//                                                     .isDarkMode.value
//                                                 ? AppColors.buttonPrimaryColor
//                                                 : AppColors.light,
//                                             buttonTextColor: !themeController
//                                                     .isDarkMode.value
//                                                 ? AppColors.buttonTextColorBlack
//                                                 : AppColors.light,
//                                             isPadding: true,
//                                           ),
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets.only(
//                                           left: AppSizes.mobilePadding,
//                                         ),
//                                         child: SizedBox(
//                                           height: 52,
//                                           width:
//                                               AppHelperFunctions.screenWidth() *
//                                                   0.4,
//                                           child:
//                                               AppButtons.largeFlatFilledButton(
//                                             onPressed: () {
//                                               blogController.getAllBlogData();
//                                               Get.back();
//                                             },
//                                             buttonText: "Apply filter",
//                                             color: AppColors.primaryColor,
//                                             buttonTextColor:
//                                                 AppColors.buttonTextColor,
//                                             isBorderRadiousSize: true,
//                                             borderRediousSize: 32,
//                                             isPadding: true,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               )
//                             ]);
//                           });
//                     },
//                     child: AppCardContainer(
//                       height: 45,
//                       width: AppHelperFunctions.screenWidth() * 0.12,
//                       borderRadius: 32,
//                       backgroundColor: !themeController.isDarkMode.value
//                           ? AppColors.lightGrey
//                           : AppColors.dark,
//                       child: SvgPicture.asset(
//                         "assets/images/icons/Filter.svg",
//                         height: 10,
//                         width: 10,
//                         color: !themeController.isDarkMode.value
//                             ? AppColors.dark
//                             : AppColors.light,
//                         fit: BoxFit.scaleDown,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const Gap(AppSizes.msGap),
//               SizedBox(
//                 height: 32,
//                 child: Obx(() {
//                   return ListView(
//                     shrinkWrap: true,
//                     scrollDirection: Axis.horizontal,
//                     children: List<Widget>.generate(
//                       blogController.blogCategories.value.data?.length ?? 5,
//                       (int index) {
//                         return Align(
//                             alignment: Alignment.topLeft,
//                             child: blogController.categoryApiHitting.value
//                                 ? ShimmerHelper()
//                                     .buildBasicShimmer(height: 32, width: 100)
//                                 : AppTabsCard(
//                                     onTap: () {
//                                       blogController.selectedCategories.value =
//                                           blogController.blogCategories.value
//                                               .data![index].title!;
//                                       blogController.getAllBlogData();
//                                     },
//                                     isNeedPadding: true,
//                                     tabName: blogController.blogCategories.value
//                                             .data?[index].title ??
//                                         '',
//                                     backgroundColor: blogController
//                                                 .selectedCategories.value ==
//                                             blogController.blogCategories.value
//                                                 .data![index].title!
//                                         ? AppColors.primaryColor
//                                         : !themeController.isDarkMode.value? AppColors.cardPrimaryColor : AppColors.dark,
//                                     tabCardTextColor: blogController
//                                                 .selectedCategories.value ==
//                                             blogController.blogCategories.value
//                                                 .data![index].title!
//                                         ? AppColors
//                                         .textWhite
//                                         : !themeController.isDarkMode.value? AppColors
//                                         .textPrimaryColor : AppColors.textPrimaryColorDark,
//                                   ));
//                       },
//                     ).toList(),
//                   );
//                 }),
//               ),
//             ],
//           ),
//         ));
//   }
// }
