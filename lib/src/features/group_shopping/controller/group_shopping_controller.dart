import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/features/group_shopping/model/group_shopping_products_model.dart';
import 'package:kirei/src/features/group_shopping/repositories/group_shopping_repositories.dart';

import '../../address/model/address_city_model.dart';
import '../../address/model/area_response.dart';
import '../../address/model/zone_response.dart';
import '../../address/repositories/address_repositories.dart';
import '../model/group_shopping_groups.dart';

class GroupShoppingController extends GetxController{
  static GroupShoppingController get instance => Get.find();

  RxBool hittingApi = false.obs;

  Rx<GroupShoppingProductsResponse> groupShoppingProduct = GroupShoppingProductsResponse().obs;
  Rx<GroupShoppingGroupsResponse> groupShoppingGroup = GroupShoppingGroupsResponse().obs;


  Rx<CityResponse> cityList = CityResponse().obs;
  Rx<ZoneResponse> zoneList = ZoneResponse().obs;
  Rx<AreaResponse> areaList = AreaResponse().obs;
  RxInt selectedCityId = 0.obs;
  RxInt selectedZoneId = 0.obs;
  RxInt selectedAreaId = 0.obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController selectedCityName = TextEditingController();
  TextEditingController selectedZoneName = TextEditingController();
  TextEditingController selectedAreaName = TextEditingController();


  @override
  void onInit() {
    super.onInit();
    onRefresh();
  }

  Future<void> onRefresh()async{
    print('refresh');
    getProducts();
  }

  Future<void> getProducts() async{
    hittingApi.value = true;
    groupShoppingProduct.value = await GroupShoppingRepo().getGroupShoppingProducts();
    groupShoppingGroup.value = await GroupShoppingRepo().getGroupShoppingGroups();
    hittingApi.value = false;
  }


  Future<CityResponse> getCityList() async {
    return cityList.value = await AddressRepositories().getCities();
  }

  Future<ZoneResponse> getZoneList(int selectedCityId) async {
    return zoneList.value =
    await AddressRepositories().getZones(selectedCityId);
  }

  Future<AreaResponse> getAreaList(int selectedZoneId) async {
    return areaList.value =
    await AddressRepositories().getAreas(selectedZoneId);
  }
}