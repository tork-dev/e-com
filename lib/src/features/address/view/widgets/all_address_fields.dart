import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gap/gap.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/address/controller/address_controller.dart';
import 'package:kirei/src/features/address/view/widgets/address_text_field.dart';
import 'package:kirei/src/features/checkout/controller/checkout_controller.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/logging/logger.dart';
import '../../../../utils/validators/validation.dart';

class AppAllAddressFields extends StatelessWidget {
  final bool isCallSummary;
  const AppAllAddressFields({super.key, this.isCallSummary = false});

  @override
  Widget build(BuildContext context) {
    final addressController = AddressController.instance;
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
          const Gap(AppSizes.spaceBtwInputFields),
          AppAddressTextField(
            controller: addressController.phoneController,
            fieldTitle: 'Phone*',
            hintText: 'Enter phone',
            textInputType: TextInputType.number,
            validator: (value) => AppValidator.validatePhoneNumber(value),
          ),
          const Gap(AppSizes.spaceBtwInputFields),
          AppAddressTextField(
            controller: addressController.emailController,
            fieldTitle: 'Email',
            hintText: 'Enter email',
            validator: (value) => AppValidator.validateEmail(value),
            textInputType: TextInputType.emailAddress,
          ),
          const Gap(AppSizes.spaceBtwInputFields),
          AppAddressTextField(
            controller: addressController.addressController,
            verticalPadding: 20,
            fieldTitle: 'Address*',
            hintText: 'Enter address',
          ),
          const Gap(AppSizes.spaceBtwInputFields),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('City*', style: Theme.of(context).textTheme.bodySmall),
              const Gap(AppSizes.xs),
              TypeAheadField(
                focusNode: cityNode,
                direction: VerticalDirection.up,
                itemBuilder: (context, dataItem) {
                  return dataItem.name == null
                      ? const AppCardContainer(
                        height: 50,
                        child: Center(child: Text('Loading...')),
                      )
                      : ListTile(
                        dense: true,
                        title: Text(dataItem.name ?? 'Not found'),
                      );
                },
                onSelected: (value) {
                  addressController.selectedCityId.value = value.id!;
                  addressController.selectedCityName.value = value.name!;
                  addressController.selectedCityController.text = value.name!;
                  addressController.selectedZoneController.clear();
                  addressController.selectedAreaController.clear();
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
                  if(isCallSummary){
                    CheckoutController.instance.getCheckoutSummary();
                  }
                },
                controller: addressController.selectedCityController,
                suggestionsCallback: (value) async {
                  if (addressController.cityList.value.cities == null) {
                    await addressController.getCityList();
                  }
                  return addressController.cityList.value.cities!
                      .where(
                        (element) => element.name!.toLowerCase().contains(
                          value.toLowerCase(),
                        ),
                      )
                      .toList();
                },
                loadingBuilder: (context) {
                  return const AppCardContainer(
                    height: 50,
                    child: Center(child: Text('Loading...')),
                  );
                },
                builder: (context, controller, focusNode) {
                  return TextFormField(
                    controller: controller,
                    focusNode: focusNode,
                    onTap: () {
                      Log.d('city');
                      areaSuggestion.refresh();
                      areaNode.unfocus();
                      controller.clear();
                    },
                    cursorColor: AppColors.primary,
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.arrow_drop_down_rounded),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 0,
                      ),
                      hintText: 'Select city',
                      hintStyle: TextStyle(
                        color: AppColors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.lightGrey,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.lightGrey,
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.lightGrey,
                          width: 1,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          const Gap(AppSizes.spaceBtwInputFields),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Zone*', style: Theme.of(context).textTheme.bodySmall),
              const Gap(AppSizes.xs),
              InkWell(
                onTap: () {
                  Log.d('zone suggession1');
                  zoneSuggestion.refresh();
                  Log.d('zone suggession2');
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
                            child: Center(child: Text('Loading...')),
                          )
                          : ListTile(dense: true, title: Text(dataItem.name!));
                    },
                    errorBuilder:
                        (context, error) => const AppCardContainer(
                          height: 50,
                          child: Center(child: Text('errr')),
                        ),
                    emptyBuilder: (context) => const Text('No items found!'),
                    onSelected: (zone) {
                      addressController.selectedZoneId.value = zone.id!;
                      addressController.selectedZoneName.value = zone.name!;
                      addressController.selectedZoneController.text =
                          zone.name!;
                      addressController.selectedAreaController.clear();
                      addressController.selectedAreaId.value = 0;
                      addressController.areaList.value.areas?.clear();
                      areaNode.unfocus();
                      areaSuggestion.unfocus();
                      areaSuggestion.refresh();
                      addressController.getAreaList(zone.id!);
                      Log.d(zone.id.toString());
                      Log.d(addressController.selectedZoneName.value);
                      Log.d(addressController.selectedZoneController.text);
                    },
                    controller: addressController.selectedZoneController,
                    suggestionsController: zoneSuggestion,
                    suggestionsCallback: (value) async {
                      if (addressController.zoneList.value.data == null) {
                        await addressController.getZoneList(
                          addressController.selectedCityId.value,
                        );
                      }
                      return addressController.zoneList.value.data!.zones!
                          .where((element) {
                            return element.name!.toLowerCase().contains(
                              value.toLowerCase(),
                            );
                          })
                          .toList();
                    },
                    loadingBuilder: (context) {
                      return const AppCardContainer(
                        height: 50,
                        child: Center(child: Text('Loading...')),
                      );
                    },
                    builder: (context, controller, focusNode) {
                      return TextFormField(
                        controller: controller,
                        focusNode: focusNode,
                        onTap: () {
                          Log.d('zone');
                          Log.d(
                            'name : ${addressController.selectedCityName.value}',
                          );
                          if (addressController.selectedCityController.text !=
                              addressController.selectedCityName.value) {
                            addressController.selectedCityController.clear();
                            addressController.selectedCityName.value = '';
                          }
                          zoneSuggestion.refresh();
                          areaNode.unfocus();
                          controller.clear();
                        },
                        cursorColor: AppColors.primary,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.arrow_drop_down_rounded),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 0,
                          ),
                          hintText: 'Select zone',
                          hintStyle: TextStyle(
                            color: AppColors.grey,
                            fontWeight: FontWeight.w400,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.lightGrey,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.lightGrey,
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.lightGrey,
                              width: 1,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          const Gap(AppSizes.spaceBtwInputFields),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Area', style: Theme.of(context).textTheme.bodySmall),
              const Gap(AppSizes.xs),
              InkWell(
                onTap: () => areaSuggestion.refresh(),
                child: TypeAheadField(
                  focusNode: areaNode,
                  hideOnEmpty: true,
                  direction: VerticalDirection.up,
                  itemBuilder: (context, dataItem) {
                    return ListTile(dense: true, title: Text(dataItem.name!));
                  },
                  errorBuilder:
                      (context, error) => const AppCardContainer(
                        height: 50,
                        child: Center(child: Text('errr')),
                      ),
                  onSelected: (area) {
                    addressController.selectedAreaId.value = area.id!;
                    addressController.selectedAreaName.value = area.name!;
                    addressController.selectedAreaController.text = area.name!;
                    areaNode.unfocus();
                  },
                  controller: addressController.selectedAreaController,
                  suggestionsController: areaSuggestion,
                  suggestionsCallback: (value) async {
                    if (addressController.areaList.value.areas == null) {
                      await addressController.getAreaList(
                        addressController.selectedZoneId.value,
                      );
                    }
                    return addressController.areaList.value.areas!.where((
                      element,
                    ) {
                      return element.name!.toLowerCase().contains(
                        value.toLowerCase(),
                      );
                    }).toList();
                  },
                  loadingBuilder: (context) {
                    return const AppCardContainer(
                      height: 50,
                      child: Center(child: Text('Loading...')),
                    );
                  },
                  builder: (context, controller, focusNode) {
                    return TextFormField(
                      controller: controller,
                      focusNode: focusNode,
                      onTap: () {
                        Log.d('area');
                        areaSuggestion.refresh();
                        controller.clear();
                        if (addressController.selectedZoneName.value !=
                            addressController.selectedZoneController.text) {
                          addressController.selectedZoneController.clear();
                          addressController.selectedZoneName.value = '';
                        }
                      },
                      cursorColor: AppColors.primary,
                      decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.arrow_drop_down_rounded),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 0,
                        ),
                        hintText: 'Select area',
                        hintStyle: TextStyle(
                          color: AppColors.grey,
                          fontWeight: FontWeight.w400,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.lightGrey,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.lightGrey,
                            width: 1,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.lightGrey,
                            width: 1,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
