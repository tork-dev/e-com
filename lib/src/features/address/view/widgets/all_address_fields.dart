import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kirei/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:kirei/src/common/widgets/buttons/app_buttons.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/address/controller/address_controller.dart';
import 'package:kirei/src/features/address/model/address_city_model.dart';
import 'package:kirei/src/features/address/view/widgets/address_text_field.dart';
import 'package:kirei/src/features/address/view/widgets/address_tyepe_ahed_field.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

import '../../../../utils/constants/colors.dart';

class AppAllAddressFields extends StatelessWidget {
  const AppAllAddressFields({super.key});

  @override
  Widget build(BuildContext context) {
    final addressController = AddressController.instance;
    FocusNode areaNode = FocusNode();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppAddressTextField(
          controller: addressController.nameController,
          fieldTitle: 'Name*',
          hintText: 'Enter name',
        ),
        const Gap(AppSizes.spaceBtwRowItem),
        AppAddressTextField(
          controller: addressController.phoneController,
          fieldTitle: 'Phone*',
          hintText: 'Enter phone',
        ),
        const Gap(AppSizes.spaceBtwRowItem),
        AppAddressTextField(
          controller: addressController.emailController,
          fieldTitle: 'Email',
          hintText: 'Enter email',
        ),
        const Gap(AppSizes.spaceBtwRowItem),
        AppAddressTextField(
          controller: addressController.addressController,
          verticalPadding: 20,
          fieldTitle: 'Address*',
          hintText: 'Enter address',
        ),
        const Gap(AppSizes.spaceBtwRowItem),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'City*',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const Gap(AppSizes.xs),
            TypeAheadField(
              direction: VerticalDirection.up,
              itemBuilder: (context, dataItem) {
                return dataItem.name == null
                    ? const AppCardContainer(
                    height: 50,
                    child: Center(
                      child: Text('Loading...'),
                    ))
                    : ListTile(dense: true, title: Text(dataItem.name ?? 'Not found'));
              },
              onSelected: (value) async {
                addressController.selectedCityId.value = value.id!;
                addressController.selectedCityName.text = value.name!;
                addressController.selectedZoneName.clear();
                addressController.selectedAreaName.clear();
                addressController.selectedZoneId.value = 0;
                addressController.selectedAreaId.value = 0;
                await addressController.getZoneList(value.id!);
                areaNode.unfocus();
              },
              controller: addressController.selectedCityName,
              suggestionsCallback: (value) async{
                if(addressController.cityList.value.cities == null){
                  await addressController.getCityList();
                }
                var cities = addressController.cityList.value.cities;
                return cities
                    ?.where((element) =>
                    element.name!.toLowerCase().contains(value.toLowerCase()))
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
            )
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
            Obx(() {
                return TypeAheadField(
                  direction: VerticalDirection.up,
                  itemBuilder: (context, dataItem) {
                    return dataItem.name == null
                        ? const AppCardContainer(
                        height: 50,
                        child: Center(
                          child: Text('Loading...'),
                        ))
                        : ListTile(dense: true, title: Text(dataItem.name!));
                  },
                  onSelected: (zone) async {
                    addressController.selectedZoneId.value = zone.id!;
                    addressController.selectedZoneName.text = zone.name!;
                    addressController.selectedAreaName.clear();
                    addressController.selectedAreaId.value = 0;
                    await addressController.getAreaList(zone.id!);
                    // addressController.se.text = zone.name!;
                    print(
                        '////////////////////////////////////////////////////////');
                    print(zone.id);
                  },
                  controller: addressController.selectedZoneName,
                  suggestionsCallback: (value) async {
                    print(addressController.zoneList.value.data!.zones!.length);
                    if(addressController.zoneList.value.data == null){
                      await addressController.getZoneList(addressController.selectedCityId.value);
                    }
                    return addressController.zoneList.value.data!.zones!
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
                );
              }
            )
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
            TypeAheadField(
              focusNode: areaNode,
              direction: VerticalDirection.up,
              itemBuilder: (context, dataItem) {
                return ListTile(dense: true, title: Text(dataItem.name!));
              },
              onSelected: (area) async {
                addressController.selectedAreaId.value = area.id!;
                addressController.selectedAreaName.text = area.name!;
                areaNode.unfocus();
              },
              controller: addressController.selectedAreaName,
              suggestionsCallback: (value) async{
                if(addressController.areaList.value.areas == null){
                  await addressController.getAreaList(addressController.selectedZoneId.value);
                }
                return addressController.areaList.value.areas!
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
            )
          ],
        ),
      ],
    );
  }
}