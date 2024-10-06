import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gap/gap.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/address/controller/address_controller.dart';
import 'package:kirei/src/features/address/view/widgets/address_text_field.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/validators/validation.dart';

class AppAllAddressFields extends StatelessWidget {
  const AppAllAddressFields({super.key});


  @override
  Widget build(BuildContext context) {
    final addressController = AddressController.instance;
    final SuggestionsController citySuggestion = SuggestionsController();
    final SuggestionsController zoneSuggestion = SuggestionsController();
    final SuggestionsController areaSuggestion = SuggestionsController();
    FocusNode areaNode = FocusNode();
    FocusNode zoneNode = FocusNode();
    FocusNode cityNode = FocusNode();

    return Form(
      key: addressController.addressFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppAddressTextField(
            controller: addressController.nameController,
            fieldTitle: 'Name*',
            hintText: 'Enter name',
          ),
          const Gap(AppSizes.spaceBtwSmallItem),
          AppAddressTextField(
            controller: addressController.phoneController,
            fieldTitle: 'Phone*',
            hintText: 'Enter phone',
            textInputType: TextInputType.number,
          ),
          const Gap(AppSizes.spaceBtwSmallItem),
          AppAddressTextField(
            validator: (value) => AppValidator.validateEmail(value),
            controller: addressController.emailController,
            fieldTitle: 'Email',
            hintText: 'Enter email',
            textInputType: TextInputType.emailAddress,
          ),
          const Gap(AppSizes.spaceBtwSmallItem),
          AppAddressTextField(
            controller: addressController.addressController,
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
                  addressController.selectedCityId.value = value.id!;
                  addressController.selectedCityName.text = value.name!;
                  addressController.selectedZoneName.clear();
                  addressController.selectedAreaName.clear();
                  addressController.selectedZoneId.value = 0;
                  addressController.selectedAreaId.value = 0;
                  addressController.zoneList.value.data?.zones?.clear();
                  addressController.areaList.value.areas?.clear();
                  areaNode.unfocus();
                  zoneNode.unfocus();
                  zoneSuggestion.unfocus();
                  areaSuggestion.unfocus();
                  zoneSuggestion.refresh();
                  addressController.getZoneList(value.id!);
                },
                controller: addressController.selectedCityName,
                suggestionsCallback: (value) async {
                  if (addressController.cityList.value.cities == null) {
                    await addressController.getCityList();
                  }
                  return addressController.cityList.value.cities!.where((element) => element.name!
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
                      addressController.selectedZoneId.value = zone.id!;
                      addressController.selectedZoneName.text = zone.name!;
                      addressController.selectedAreaName.clear();
                      addressController.selectedAreaId.value = 0;
                      addressController.areaList.value.areas?.clear();
                      areaNode.unfocus();
                      areaSuggestion.unfocus();
                      areaSuggestion.refresh();
                      addressController.getAreaList(zone.id!);
                      print(zone.id);
                    },
                    controller: addressController.selectedZoneName,
                    suggestionsController: zoneSuggestion,
                    suggestionsCallback: (value) async {
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
                    addressController.selectedAreaId.value = area.id!;
                    addressController.selectedAreaName.text = area.name!;
                    areaNode.unfocus();
                  },
                  controller: addressController.selectedAreaName,
                  suggestionsController: areaSuggestion,
                  suggestionsCallback: (value) async{
                    if(addressController.areaList.value.areas == null){
                      await addressController.getAreaList(addressController.selectedZoneId.value);
                    }
                    return addressController.areaList.value.areas!.where((element) {
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
              )
            ],
          ),
        ],
      ),
    );
  }
}