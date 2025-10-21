import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppApiEndPoints {
  AppApiEndPoints._();

  static final String baseUrl = dotenv.env["BASE_URL"]!;
   // static final String gialogyBaseUrl = dotenv.env["GIGALOGY_BASE_URL"]!;

  ///Authentication
  static String logIn = "$baseUrl/auth/login";
  static String loginOtp = "$baseUrl/send-login-otp";
  static String verifyLoginOtp = "$baseUrl/verify-login-otp";
  static String getUserAccessToken = "$baseUrl/get-user-by-access_token";
  static String socialSignIn = "$baseUrl/auth/social-login";
  static String socialLogOut = "$baseUrl/auth/logout";
  static String socialOption = "$baseUrl/activated-social-login";
  static String signUp = "$baseUrl/auth/signup";
  static String signupOtp = "$baseUrl/send-signup-otp";
  static String verifySignUpOtp = "$baseUrl/verify-signup-otp";
  static String forgetPasswordOtpSend = "$baseUrl/send-reset-otp";
  static String forgetConfirmPassword = "$baseUrl/verify-reset-otp";
  static String passwordConfirmReset = "$baseUrl/auth/password/confirm_reset";

  /// Home
  static String homeProducts = "$baseUrl/home-things";
  static String homeSlider = "$baseUrl/sliders";
  static String homeFeaturedCategory = "$baseUrl/home-featured-categories";
  static String sideBarData = "$baseUrl/sidebar-data";
  static String allNewCategories = "$baseUrl/all-categories?new=true";
  static String allCategories = "$baseUrl/all-categories";
  static String deviceToken = "$baseUrl/profile/update-device-token";
  static String surpriseGift = "$baseUrl/surprize-store";


  ///Shop
  static String shopProducts = "$baseUrl/gigalogy/items/search?";
  static String shopSkinTypes = "$baseUrl/skin-types";
  static String subCategory = "$baseUrl/sub-categories";


  ///Details
  static String productDetails = "$baseUrl/products/details/";
  static String relatedProduct = "$baseUrl/gigalogy/related-products";
  static String recommendedProduct = "$baseUrl/gigalogy/users/search/recommend";

  static String recommendedProductForUser = "$baseUrl/gigalogy/users/recommend";
  // static String trendingProduct = "$baseUrl/gigalogy/items/trending";


  ///Carts
  static String addToCart = "$baseUrl/carts/add";
  static String cartProducts = "$baseUrl/carts";
  static String cartProductsDelete = "$baseUrl/carts";
  static String cartQuantityUpdate = "$baseUrl/carts/change-quantity";
  static String proceedToCheckout = "$baseUrl/carts/process";
  static String requestStock = "$baseUrl/add-product-request/";
  static String bulkAddToCart = "$baseUrl/carts/bulk-add";


  ///Checkout
  // static String checkoutSummary = "$baseUrl/cart-summary";
  static String checkoutSummary = "$baseUrl/checkout-summary";
  static String paymentTypes = "$baseUrl/payment-types";
  static String couponAdd = "$baseUrl/coupon-apply/on-cart";
  static String couponRemove = "$baseUrl/coupon-remove";
  static String placeOrder = "$baseUrl/credential/order-store/v2";
  static String sendCheckoutOtp = "$baseUrl/send-checkout-otp";
  static String verifyCheckoutOtp = "$baseUrl/verify-checkout-otp";


  ///Purchase History
  static String purchaseHistory = "$baseUrl/purchase-history";
  static String purchaseHistoryDetails = "$baseUrl/purchase-history-details";
  static String purchaseHistoryItem = "$baseUrl/purchase-history-items";
  static String reOrder = "$baseUrl/reorder";


  ///Update Profile info
  static String updateProfile = "$baseUrl/profile/update";
  static String updateProfileImage = "$baseUrl/profile/update-image";


  ///Wishlist
  static String wishlistProducts = "$baseUrl/all-wishlists";
  static String addWishlistProduct = "$baseUrl/wishlists-add-product?product_id=";
  static String removeWishlistProduct = "$baseUrl/wishlists-remove-product?product_id=";
  static String checkWishlistProduct = "$baseUrl/wishlists-check-product?product_id=";


  ///Address
  static String shippingAddress = "$baseUrl/user/shipping/address";
  static String shippingAddressCreateOrUpdate = "$baseUrl/user/shipping/create-or-update";
  static String cityAddresses  = "$baseUrl/cities-by-country/3069";
  static String zoneAddresses  = "$baseUrl/zones-by-city";
  static String areaAddresses  = "$baseUrl/areas-by-zone";
  static String changeOrderAddresses  = "$baseUrl/order/shipping-update/";


  ///Product Review
  static String productReview = "$baseUrl/reviews/product";
  static String submitReview = "$baseUrl/new-reviews/submit";


  ///Product Questions
  static String productQuestions = "$baseUrl/product-questions/";
  static String submitQuestion = "$baseUrl/product-question";


  ///Community
  static String communityPost = "$baseUrl/community-posts";
  static String createCommunityPost = "$baseUrl/community-post-create";
  static String createCommunityLike = "$baseUrl/community-like-update";
  static String communityCommentList = "$baseUrl/community-comments";
  static String communityCommentCreate = "$baseUrl/community-comment-create";

  ///Image Search
  static String imageSearch = "$baseUrl/gigalogy/items/search";

  ///Recommendation question
  static String recommendationQuestion = "$baseUrl/gigalogy/questions/recommend";


  ///Appointment
  static String appointmentStore = "$baseUrl/new-appointment/store";

  /// De-Active Account
  static String deActiveAccount = "$baseUrl/auth/deactive-account";

  /// Business-settings
  static String businessSettings = "$baseUrl/business-settings";

  ///spinner module
  static String spinnerCouponList = "$baseUrl/spinner/coupons";
  static String spinnerSelectedCoupon = "$baseUrl/spinner/spin-coupon";

  /// Reward point
  static String rewardPoint = "$baseUrl/user-memberships";
  static String rewardPointBalance = "$baseUrl/user-reward-balance";
  static String pointRedeemProducts = "$baseUrl/user-memberships-products";
  static String pointLevel = "$baseUrl/memberships";
  static String rewardHistory = "$baseUrl/user-rewards";


  ///Kirei-tube
  static String kireiTubeHome = "$baseUrl/kireitube-home";
  static String kireiTubeVideos = "$baseUrl/kireitube-videos";
  static String kireiPlaylist = "$baseUrl/kireitube-playlists";
  static String kireiPlaylistDetails = "$baseUrl/kireitube-playlist";


  ///Group Shopping
  static String shoppingGroups = "$baseUrl/groups";
  static String groupShoppingProducts = "$baseUrl/groups/products";
  static String createGroup = "$baseUrl/groups/store";
  static String joinGroup = "$baseUrl/groups/join";

  /// User Notification
  static String userNotificationList = "$baseUrl/user-notifications";

  /// Submit feedback
  static String submitFeedback = "$baseUrl/product-authentic-reviews/submit";
  static String productVerifyList = "$baseUrl/authentic-user-order-history";

  ///Blogs
  static String blogs = "$baseUrl/blogs";
  static String blogDetails = "$baseUrl/blog";
  static String blogCategories = "$baseUrl/blog/categories";
  static String blogTags = "$baseUrl/trending/tags";





}
