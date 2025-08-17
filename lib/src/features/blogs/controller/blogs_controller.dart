import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/features/blogs/model/blog_details_model.dart' hide Post;
import 'package:kirei/src/utils/logging/logger.dart';
import '../model/blog_response.dart';
import '../repository/blogs_repository.dart';

class BlogsController extends GetxController {
  static BlogsController get instance => Get.find();

  Rx<BlogsResponseModel> blogsResponseData = BlogsResponseModel().obs;
  RxBool isApiHitting = false.obs;
  final ScrollController scrollController = ScrollController();

  List<Post> blogList = []; // Store blogs fetched from API
  RxBool categoryApiHitting = false.obs;
  RxString selectedCategories = 'All'.obs;
  RxString searchName = ''.obs;
  RxBool tagApiHitting = false.obs;
  RxList selectedTagsList = [].obs;
  TextEditingController searchController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  Rx<
      BlogDetailsResponseModel> blogsDetailsResponseData = BlogDetailsResponseModel()
      .obs;

  RxInt currentPage = 1.obs;
  RxInt lastPage = 1.obs; // Store the last page from API
  RxBool hasMore = true.obs;
  int pageSize = 6;

  @override
  void onInit() {
    super.onInit();
    getAllBlogData(); // Fetch initial data
  }

  Future<void> getAllBlogData() async {
    isApiHitting.value = true;
    blogsResponseData.value = await BlogsRepository().getBlogsResponse(
      // pageNumber: currentPage.value,
      categoryTitle: selectedCategories.value,
      tags: selectedTagsList.join(','),
      search: searchName.value,
    );
    if (blogsResponseData.value.data != null) {
      blogList.addAll(blogsResponseData.value.data?.posts ?? []);
      Log.i('all post : ${blogList.length}');
    }
    isApiHitting.value = false;
  }

  bool isLoadingMore = false;

  /// Refresh the data
  Future<void> onRefresh() async {
    currentPage.value = 1;
    hasMore.value = true;
    blogList.clear();
    await getAllBlogData();
  }

  void clearFilter() {
    selectedTagsList.clear();
    searchName.value = '';
    selectedCategories.value = 'All';
  }


  Future<void> getBlogDetails({required String slug}) async {
    isApiHitting.value = true;
    blogsDetailsResponseData.value =
    await BlogsRepository().getBlogsDetailsResponse(slug: slug);
    isApiHitting.value = false;
    print(blogsDetailsResponseData.value.title);
  }
}
