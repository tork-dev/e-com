import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppApiEndPoints {
  AppApiEndPoints._();

  static final String baseUrl = dotenv.env["BASE_URL"]!;

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
  static String homeProducts = "$baseUrl/home-products";
  static String homeSlider = "$baseUrl/sliders";
  static String homeFeaturedCategory = "$baseUrl/home-featured-categories";
  static String sideBarData = "$baseUrl/sidebar-data";
  static String allCategories = "$baseUrl/all-categories";
  static String deviceToken = "$baseUrl/profile/update-device-token";

  ///Shop
  static String shopProducts = "$baseUrl/gigalogy/items/search?";
  static String shopSkinTypes = "$baseUrl/skin-types";
  static String subCategory = "$baseUrl/sub-categories";

  ///Details
  static String productDetails = "$baseUrl/products/details/";
  static String relatedProduct = "$baseUrl/gigalogy/related-products/";
  static String recommendedProduct = "$baseUrl/gigalogy/users/search/recommend?gaip_user_id=";
  static String trendingProduct = "$baseUrl/gigalogy/items/trending?gaip_user_id=";

  ///Carts
  static String addToCart = "$baseUrl/carts/add";
  static String cartProducts = "$baseUrl/carts";
  static String cartProductsDelete = "$baseUrl/carts";
  static String cartQuantityUpdate = "$baseUrl/carts/change-quantity";
  static String proceedToCheckout = "$baseUrl/carts/process";
  static String requestStock = "$baseUrl/add-product-request/";

  ///Checkout
  static String checkoutSummary = "$baseUrl/cart-summary";
  static String paymentTypes = "$baseUrl/payment-types";
  static String couponAdd = "$baseUrl/coupon-apply/on-cart";
  static String couponRemove = "$baseUrl/coupon-remove";
  static String placeOrder = "$baseUrl/credential/order-store/v2";

  ///Purchase History
  static String purchaseHistory = "$baseUrl/purchase-history";
  static String purchaseHistoryDetails = "$baseUrl/purchase-history-details";
  static String purchaseHistoryItem = "$baseUrl/purchase-history-items";
  static String reOrder = "$baseUrl/reorder";

  ///Update Profile info
  static String updateProfile = "$baseUrl/profile/update";
  static String updateProfileImage = "$baseUrl/profile/update-image";

  ///Wishlist
  static String wishlistProducts = "$baseUrl/wishlists";
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
  static String submitReview = "$baseUrl/reviews/submit";

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

  /// Reward point
  static String rewardPoint = "$baseUrl/user-memberships";
  static String pointRedeemProducts = "$baseUrl/user-memberships-products";


  ///Kirei-tube
  static String kireiTubeList = "$baseUrl/youtube-videos";


// static String AddOns = "$baseUrl/addon-list";
// static String AddrList = "$baseUrl/user/shipping/address";
// static String AddAddr = "$baseUrl/user/shipping/create";
// static String UpdateAddr = "$baseUrl/user/shipping/update";
// static String UpdateAddrNew = "$baseUrl/user/shipping/create-or-update";
// static String UpdateShipAddr =
//     "$baseUrl/user/shipping/update-location";
// static String ShipDefault = "$baseUrl/user/shipping/make_default";
// static String ShipDelete = "$baseUrl/user/shipping/delete";
// static String AddrDelete = "$baseUrl/zones-by-city";
// static String StateList = "$baseUrl/cities-by-country";
// static String CountryList = "$baseUrl/areas-by-zone";
// static String ShippingCost = "$baseUrl/shipping_cost";
// static String AddrUpdateInCart =
//     "$baseUrl/update-address-in-cart";
// //Brand Repo
// static String FILTER_PAGE_SKINTYPES = "$baseUrl/skin-types";
// static String FILTER_PAGE_BRANDS = "$baseUrl/skin-types";
//
// static String GET_BRANDS = "$baseUrl/brands";
// static String BUSINESS_SETTING = "$baseUrl/business-settings";
// //CART REPO
// static String GET_CARTS = "$baseUrl/carts";
// static String GET_PROCESS = "$baseUrl/carts/process";
// static String ADD_CART = "$baseUrl/carts/add";
// static String CART_SUMMARY = "$baseUrl/cart-summary";
// static String CART_QUANTITY = "$baseUrl/carts/change-quantity";
// //CATEGORY REPO..
// static String GET_CATEGORIES = "$baseUrl/all-categories";
// static String GET_FEATURED_CATEGORIES =
//     "$baseUrl/categories/featured";
// static String TOP_CATEGORIES = "$baseUrl/categories/top";
// static String FILTER_CATEGORIES = "$baseUrl/filter/categories";
//
// //Chat repo..
// static String GET_CONVERSATION =
//     "$baseUrl/chat/conversations?page=";
// static String GET_MESSAGE = "$baseUrl/chat/messages/";
// static String INSERT_MESSAGE = "$baseUrl/chat/insert-message";
// static String NEW_MESSAGE = "$baseUrl/chat/get-new-messages/";
// static String CREATE_CONVERSATION =
//     "$baseUrl/chat/create-conversation";
// //CLUB_POINT
//
// static String CLUB_POINT = "$baseUrl/clubpoint/get-list?page=";
// static String CLUB_POINT_WALLET =
//     "$baseUrl/clubpoint/convert-into-wallet";
// //COUPON
//
// static String COUPON_APPLY = "$baseUrl/coupon-apply/on-cart";
// static String COUPON_REMOVE = "$baseUrl/coupon-remove";
// //EXTRA_REPO
// static String GET_BLOGS = "$baseUrl/blogs";
// static String GET_BeautyBLOGS = "$baseUrl/beauty-blogs";
//
// //COMMUNITY POST
// static String COMMUNITY_POSTS = "$baseUrl/community-posts";
// static String COMMUNITY_HASH = "$baseUrl/community-hashtags";
// static String COMMUNITY_POST_CREATE =
//     "$baseUrl/community-post-create";
// static String COMMUNITY_POST_COMMENT_CREATE =
//     "$baseUrl/community-comment-create";
// static String COMMUNITY_POST_LIKE_CREATE =
//     "$baseUrl/community-like-update";
// static String COMMUNITY_POST_COMMENT =
//     "$baseUrl/community-comments";
//
// //File repo
// static String IMAGE_UPLOAD = "$baseUrl/file/image-upload";
//
// static String FLASH_DEAL = "$baseUrl/flash-deals";
// static String LANGUAGES = "$baseUrl/languages";
//
// static String PAYMENT_SUBMIT = "$baseUrl/offline/payment/submit";
//
// static String OFFLINE_RECHARGE =
//     "$baseUrl/wallet/offline-recharge";
// //ORDER REPO
// static String PURCHASE_HISTORY = "$baseUrl/purchase-history";
// static String PURCHASE_HISTORY_DETAILS =
//     "$baseUrl/purchase-history-details/";
// static String PURCHASE_HISTORY_ITEM =
//     "$baseUrl/purchase-history-items/";
// static String RE_ORDER =
//     "$baseUrl/reorder/";
}
