import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/utils/logging/logger.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../model/blog_categories.dart';
import '../model/blog_response.dart';
import '../model/blog_tags_response.dart';
import '../repository/blogs_repository.dart';

class BlogsController extends GetxController {
  static BlogsController get instance => Get.find();

  Rx<BlogsResponseModel> blogsResponseData = BlogsResponseModel().obs;
  RxBool isApiHitting = false.obs;
  final ScrollController scrollController = ScrollController();

  List<Post> blogList = []; // Store blogs fetched from API
  RxBool categoryApiHitting = false.obs;
  Rx<BlogCategories> blogCategories = BlogCategories().obs;
  RxString selectedCategories = 'All'.obs;
  RxString searchName = ''.obs;
  Rx<BlogTags> blogTags = BlogTags().obs;
  RxBool tagApiHitting = false.obs;
  RxList selectedTagsList = [].obs;
  TextEditingController searchController = TextEditingController();

  RxInt currentPage = 1.obs;
  RxInt lastPage = 1.obs; // Store the last page from API
  RxBool hasMore = true.obs;
  int pageSize = 6;

  @override
  void onInit() {
    super.onInit();
    getAllBlogData(); // Fetch initial data
    // addItems();
    // getCategories();
    // getTags();
    // setupScrollListener();

  }

  /// Fetch paginated blog data from API
  // Future<void> getAllBlogData() async {
  //   if (isApiHitting.value || !hasMore.value) return;
  //
  //   isApiHitting.value = true;
  //
  //   try {
  //     if (selectedCategories.value == 'All') {
  //       clearFilter();
  //     }
  //
  //     blogsResponseData.value = await BlogsRepository().getBlogsResponse(
  //       search: searchName.value,
  //       categoryTitle: selectedCategories.value,
  //       tags: selectedTagsList.join(','),
  //       pageNumber: currentPage.value,
  //     );
  //
  //     if (blogsResponseData.value.data != null && blogsResponseData.value.data!.isNotEmpty) {
  //       blogList.addAll(blogsResponseData.value.data!);
  //       lastPage.value = blogsResponseData.value.meta?.lastPage ?? 1;
  //
  //       // Check if it's the last page
  //       if (currentPage.value >= lastPage.value) {
  //         hasMore.value = false;
  //       }
  //     } else {
  //       hasMore.value = false;
  //     }
  //   } finally {
  //     isApiHitting.value = false;
  //   }
  // }

  /// Load next page when reaching the bottom
  // Future<void> loadMoreData() async {
  //   if (currentPage.value < lastPage.value && !isApiHitting.value) {
  //     double currentScrollPosition = scrollController.position.pixels; // Save position
  //     currentPage.value++;
  //     Log.i(currentPage.value.toString());
  //     await getAllBlogData();
  //
  //     // Restore scroll position after data is added
  //     Future.delayed(const Duration(milliseconds: 100), () {
  //       scrollController.jumpTo(currentScrollPosition);
  //     });
  //   }
  // }

  /// Scroll listener to trigger pagination
  // void setupScrollListener() {
  //   scrollController.addListener(() {
  //     if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 100) {
  //       loadMoreData();
  //     }
  //   });
  // }

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
  // void addItems() {
  //   scrollController.addListener(() {
  //     if (scrollController.position.pixels >=
  //         scrollController.position.maxScrollExtent - 50 &&
  //         currentPage.value < blogsResponseData.value.meta!.lastPage! &&
  //         !isLoadingMore &&
  //         !isApiHitting.value) {
  //       isLoadingMore = true; // Set loading flag to true
  //
  //       AppHelperFunctions.showToast('Loading more...');
  //       print('Loading more data for page number: ${currentPage.value}');
  //
  //       // Save current scroll position and content height before loading more data
  //       double currentScrollPosition = scrollController.position.pixels;
  //       double maxScrollExtentBeforeLoad =
  //           scrollController.position.maxScrollExtent;
  //
  //       currentPage.value++;
  //       isApiHitting.value = true;
  //
  //       getAllBlogData();
  //       isApiHitting.value = false;
  //       isLoadingMore = false; // Reset loading flag
  //
  //       double newMaxScrollExtent = scrollController.position.maxScrollExtent;
  //       double scrollOffsetDifference =
  //           newMaxScrollExtent - maxScrollExtentBeforeLoad;
  //       scrollController.jumpTo(currentScrollPosition +
  //           scrollOffsetDifference); // Maintain position after loading
  //     } else if (currentPage.value >= blogsResponseData.value.meta!.lastPage! &&
  //         scrollController.position.pixels >=
  //             scrollController.position.maxScrollExtent &&
  //         !isLoadingMore) {
  //       isLoadingMore = true;
  //       AppHelperFunctions.showToast('No Post');
  //     }
  //   });
  // }

  /// Refresh the data
  Future<void> onRefresh() async {
    currentPage.value = 1;
    hasMore.value = true;
    blogList.clear();
    await getAllBlogData();
  }

  // Future<void> getCategories() async {
  //   categoryApiHitting.value = true;
  //   blogCategories.value = await BlogsRepository().getBlogsCategories();
  //   final totalBlogs = blogCategories.value.data
  //       ?.fold<int>(0, (sum, item) => sum + (item.total as int));
  //   blogCategories.value.data!
  //       .insert(0, Datum(title: "All", slug: 'all', id: 0, total: totalBlogs));
  //   categoryApiHitting.value = false;
  // }

  // Future<void> getTags() async {
  //   tagApiHitting.value = true;
  //   blogTags.value = await BlogsRepository().getBlogsTags();
  //   tagApiHitting.value = false;
  // }

  void clearFilter() {
    selectedTagsList.clear();
    searchName.value = '';
    selectedCategories.value = 'All';
  }
}
