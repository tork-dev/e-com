import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:kirei/src/features/kirei_tube/model/kirei_tube_playlist.dart';
import 'package:kirei/src/features/kirei_tube/model/kirei_tube_response_model.dart';
import 'package:kirei/src/features/kirei_tube/model/kirei_tube_videos_model.dart';
import 'package:kirei/src/features/kirei_tube/repositories/kirei_tube_repositories.dart';
import 'package:kirei/src/utils/logging/logger.dart';

import '../model/playlist_details_response.dart';

class KireiTubeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static KireiTubeController get instance => Get.find();

  RxBool hittingApi = false.obs;
  Rx<KireiTubeHomeResponse> videoList = KireiTubeHomeResponse().obs;
  Rx<KireiTubeVideosPlaylistResponse> videoPlaylist = KireiTubeVideosPlaylistResponse().obs;
  Rx<KireiTubePlaylistDetailsResponse> playlistDetails = KireiTubePlaylistDetailsResponse().obs;
  Rx<KireiTubeVideosListResponse> videosList =
      KireiTubeVideosListResponse().obs;
  RxnInt selectedFilter = RxnInt();
  RxString selectedSortKey = 'Date added (newest)'.obs;

  List<String> filterOption = ['Latest', 'Popular', 'Oldest'];

  List<String> sortKeys = ['Date added (newest)', 'Last video added'];

  RxString selectedOrientation = 'portrait'.obs;
  RxString orderBy = ''.obs;
  RxInt isPopular = 0.obs;

  late TabController tabController;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(
        length: 4,
        vsync: this,
        initialIndex: 0,
        animationDuration: Durations.medium1);
    onRefresh();
  }

  Future<void> onRefresh() async {
    getKireiTubeHomeData();
  }

  Future<void> getKireiTubeHomeData() async {
    hittingApi.value = true;
    videoList.value = await KireiTubeRepositories().getKireiHome();
    hittingApi.value = false;
    update();
  }

  Future<void> getKireitubeVideos() async {
    hittingApi.value = true;
    videosList.value = await KireiTubeRepositories().getKireiTubeVideos(
        isPopular: isPopular.value,
        orderBy: orderBy.value,
        orientation: selectedOrientation.value);
    hittingApi.value = false;
    update();
  }

  Future<void> getKireitubePlaylist() async {
    hittingApi.value = true;
    videoPlaylist.value = await KireiTubeRepositories().getKireiPlaylist();
    hittingApi.value = false;
    update();
  }

  Future<void> getKireitubePlaylistDetails(playlistSlug) async {
    hittingApi.value = true;
    playlistDetails.value = await KireiTubeRepositories().getKireiPlaylistDetails(playlistSlug);
    hittingApi.value = false;
    update();
  }

  void switchTab(int index) {
    tabController.animateTo(index);
  }
}
