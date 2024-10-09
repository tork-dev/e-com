import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/widgets/buttons/app_buttons.dart';
import 'package:kirei/src/common/widgets/containers/banner_image.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/address/view/widgets/address_text_field.dart';
import 'package:kirei/src/features/group_shopping/controller/group_shopping_controller.dart';
import 'package:kirei/src/utils/constants/image_strings.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';
import '../../../../utils/constants/colors.dart';


class GroupCheckoutAlert extends StatelessWidget {
  const GroupCheckoutAlert({super.key, required this.buttonName, required this.buttonWork});

  final String buttonName;
  final VoidCallback buttonWork;


  @override
  Widget build(BuildContext context) {
    final groupShoppingController = GroupShoppingController.instance;
    final SuggestionsController citySuggestion = SuggestionsController();
    final SuggestionsController zoneSuggestion = SuggestionsController();
    final SuggestionsController areaSuggestion = SuggestionsController();
    FocusNode areaNode = FocusNode();
    FocusNode zoneNode = FocusNode();
    FocusNode cityNode = FocusNode();
    return SingleChildScrollView(
      child: AppCardContainer(
        applyRadius: false,
        width: AppHelperFunctions.screenWidth(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            AppAddressTextField(
              controller: groupShoppingController.nameController,
              fieldTitle: 'Name*',
              hintText: 'Enter name',
            ),
            const Gap(AppSizes.spaceBtwSmallItem),
            AppAddressTextField(
              controller: groupShoppingController.phoneController,
              fieldTitle: 'Phone*',
              hintText: 'Enter Phone',
            ),
            const Gap(AppSizes.spaceBtwSmallItem),
            AppAddressTextField(
              controller: groupShoppingController.emailController,
              fieldTitle: 'Email',
              hintText: 'Enter email',
            ),
            const Gap(AppSizes.spaceBtwSmallItem),
            AppAddressTextField(
              controller: groupShoppingController.addressController,
              verticalPadding: 20,
              fieldTitle: 'Address*',
              hintText: 'Enter address',
            ),
            const Gap(AppSizes.spaceBtwSmallItem),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'City*',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const Gap(AppSizes.xs),
                TypeAheadField(
                  focusNode: cityNode,
                  direction: VerticalDirection.up,
                  itemBuilder: (context, dataItem) {
                    return dataItem.name == null
                        ? const AppCardContainer(
                        height: 50,
                        child: Center(
                          child: Text('Loading...'),
                        ))
                        : ListTile(
                        dense: true, title: Text(dataItem.name ?? 'Not found'));
                  },
                  onSelected: (value)  {
                    groupShoppingController.selectedCityId.value = value.id!;
                    groupShoppingController.selectedCityName.text = value.name!;
                    groupShoppingController.selectedZoneName.clear();
                    groupShoppingController.selectedAreaName.clear();
                    groupShoppingController.selectedZoneId.value = 0;
                    groupShoppingController.selectedAreaId.value = 0;
                    groupShoppingController.zoneList.value.data?.zones?.clear();
                    groupShoppingController.areaList.value.areas?.clear();
                    areaNode.unfocus();
                    zoneNode.unfocus();
                    zoneSuggestion.unfocus();
                    areaSuggestion.unfocus();
                    zoneSuggestion.refresh();
                    groupShoppingController.getZoneList(value.id!);
                  },
                  controller: groupShoppingController.selectedCityName,
                  suggestionsCallback: (value) async {
                    if (groupShoppingController.cityList.value.cities == null) {
                      await groupShoppingController.getCityList();
                    }
                    return groupShoppingController.cityList.value.cities!.where((element) => element.name!
                        .toLowerCase()
                        .contains(value.toLowerCase()))
                        .toList();
                  },
                  loadingBuilder: (context) {
                    return const AppCardContainer(
                        height: 50,
                        child: Center(
                          child: Text('Loading...'),
                        ));
                  },
                  builder: (context, controller, focusNode) {
                    return TextFormField(
                      controller: controller,
                      focusNode: focusNode,
                      onTap: (){
                        print('city');
                        areaSuggestion.refresh();
                        areaNode.unfocus();
                        controller.clear();
                      },
                      cursorColor: AppColors.primary,
                      decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.arrow_drop_down_rounded),
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                        hintText: 'Select city',
                        hintStyle: TextStyle(
                            color: AppColors.grey, fontWeight: FontWeight.w400),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide:
                            BorderSide(color: AppColors.grey, width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide:
                            BorderSide(color: AppColors.grey, width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide:
                            BorderSide(color: AppColors.grey, width: 2)),
                      ),
                    );
                  },
                ),
                const Gap(AppSizes.sm),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Zone*',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const Gap(AppSizes.xs),
                InkWell(
                  onTap: (){
                    print('zone suggession1');
                    zoneSuggestion.refresh();
                    print('zone suggession2');
                  },
                  child: SizedBox(
                    child: TypeAheadField(
                      focusNode: zoneNode,
                      direction: VerticalDirection.up,
                      hideOnEmpty: true,
                      itemBuilder: (context, dataItem) {
                        return dataItem.name == null
                            ? const AppCardContainer(
                            height: 50,
                            child: Center(
                              child: Text('Loading...'),
                            ))
                            : ListTile(dense: true, title: Text(dataItem.name!));
                      },
                      errorBuilder: (context, error) => const AppCardContainer(
                          height: 50,
                          child: Center(
                            child: Text('errr'),
                          )),
                      emptyBuilder: (context) => const Text('No items found!'),
                      onSelected: (zone) {
                        groupShoppingController.selectedZoneId.value = zone.id!;
                        groupShoppingController.selectedZoneName.text = zone.name!;
                        groupShoppingController.selectedAreaName.clear();
                        groupShoppingController.selectedAreaId.value = 0;
                        groupShoppingController.areaList.value.areas?.clear();
                        areaNode.unfocus();
                        areaSuggestion.unfocus();
                        areaSuggestion.refresh();
                        groupShoppingController.getAreaList(zone.id!);
                        print(zone.id);
                      },
                      controller: groupShoppingController.selectedZoneName,
                      suggestionsController: zoneSuggestion,
                      suggestionsCallback: (value) async {
                        if(groupShoppingController.zoneList.value.data == null){
                          await groupShoppingController.getZoneList(groupShoppingController.selectedCityId.value);
                        }
                        return groupShoppingController.zoneList.value.data!.zones!
                            .where((element) {
                          return element.name!
                              .toLowerCase()
                              .contains(value.toLowerCase());
                        }).toList();
                      },
                      loadingBuilder: (context) {
                        return const AppCardContainer(
                            height: 50,
                            child: Center(
                              child: Text('Loading...'),
                            ));
                      },
                      builder: (context, controller, focusNode) {
                        return TextFormField(
                          controller: controller,
                          focusNode: focusNode,
                          onTap: (){
                            print('zone');
                            zoneSuggestion.refresh();
                            areaNode.unfocus();
                            controller.clear();
                          },
                          cursorColor: AppColors.primary,
                          decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.arrow_drop_down_rounded),
                            contentPadding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                            hintText: 'Select zone',
                            hintStyle: TextStyle(
                                color: AppColors.grey, fontWeight: FontWeight.w400),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.zero,
                                borderSide:
                                BorderSide(color: AppColors.grey, width: 2)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.zero,
                                borderSide:
                                BorderSide(color: AppColors.grey, width: 2)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.zero,
                                borderSide:
                                BorderSide(color: AppColors.grey, width: 2)),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const Gap(AppSizes.sm),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Area*',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const Gap(AppSizes.xs),
                InkWell(
                  onTap: ()=> areaSuggestion.refresh(),
                  child: TypeAheadField(
                    focusNode: areaNode,
                    hideOnEmpty: true,
                    direction: VerticalDirection.up,
                    itemBuilder: (context, dataItem) {
                      return ListTile(dense: true, title: Text(dataItem.name!));
                    },
                    errorBuilder: (context, error) => const AppCardContainer(
                        height: 50,
                        child: Center(
                          child: Text('errr'),
                        )),
                    onSelected: (area) {
                      groupShoppingController.selectedAreaId.value = area.id!;
                      groupShoppingController.selectedAreaName.text = area.name!;
                      areaNode.unfocus();
                    },
                    controller: groupShoppingController.selectedAreaName,
                    suggestionsController: areaSuggestion,
                    suggestionsCallback: (value) async{
                      if(groupShoppingController.areaList.value.areas == null){
                        await groupShoppingController.getAreaList(groupShoppingController.selectedZoneId.value);
                      }
                      return groupShoppingController.areaList.value.areas!.where((element) {
                        return element.name!
                            .toLowerCase()
                            .contains(value.toLowerCase());
                      }).toList();
                    },
                    loadingBuilder: (context) {
                      return const AppCardContainer(
                          height: 50,
                          child: Center(
                            child: Text('Loading...'),
                          ));
                    },
                    builder: (context, controller, focusNode) {
                      return TextFormField(
                        controller: controller,
                        focusNode: focusNode,
                        onTap: (){
                          print('area');
                          areaSuggestion.refresh();
                          controller.clear();
                        },
                        cursorColor: AppColors.primary,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.arrow_drop_down_rounded),
                          contentPadding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                          hintText: 'Select area',
                          hintStyle: TextStyle(
                              color: AppColors.grey, fontWeight: FontWeight.w400),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide:
                              BorderSide(color: AppColors.grey, width: 2)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide:
                              BorderSide(color: AppColors.grey, width: 2)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide:
                              BorderSide(color: AppColors.grey, width: 2)),
                        ),
                      );
                    },
                  ),
                ),
                const Gap(AppSizes.sm),
              ],
            ),
            AppAddressTextField(
              controller: groupShoppingController.noteController,
              verticalPadding: 20,
              fieldTitle: 'Note',
              hintText: 'Enter note',
            ),
            const Gap(AppSizes.md),
            Text('Payment Method *', style: Theme.of(context).textTheme.bodySmall!),
            const Gap(AppSizes.sm),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 150,
                  child: Obx(() {
                      return RadioListTile(
                        activeColor: AppColors.primary,
                        title: const AppBannerImage(
                          applyImageRadius: false,
                          imgUrl: AppImages.bKashIcon,
                        ),
                          value: 'bkash',
                          groupValue: groupShoppingController.selectedPaymentMethod.value,
                          onChanged: (value){
                            groupShoppingController.selectedPaymentMethod.value = value as String;
                          });
                    }
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: Obx(() {
                      return RadioListTile(
                          activeColor: AppColors.primary,
                          title: const AppBannerImage(
                            applyImageRadius: false,
                            imgUrl: AppImages.sslIcon,
                          ),
                          value: 'ssl',
                          groupValue: groupShoppingController.selectedPaymentMethod.value,
                          onChanged: (value){
                            groupShoppingController.selectedPaymentMethod.value = value as String;
                          });
                    }
                  ),
                ),
              ],
            ),
            const Gap(AppSizes.md),
            AppButtons.largeFlatFilledButton(
                onPressed: buttonWork,
                buttonText: buttonName,
                backgroundColor: AppColors.secondary
            )
          ],
        ),
      ),
    );
  }
}