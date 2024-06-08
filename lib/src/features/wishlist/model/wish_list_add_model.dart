import 'dart:convert';

class WishListAddResponse {
  String? message;
  bool? isInWishlist;
  dynamic productId;
  int? wishlistId;

  WishListAddResponse({
    this.message,
    this.isInWishlist,
    this.productId,
    this.wishlistId,
  });

  factory WishListAddResponse.fromRawJson(String str) => WishListAddResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WishListAddResponse.fromJson(Map<String, dynamic> json) => WishListAddResponse(
    message: json["message"],
    isInWishlist: json["is_in_wishlist"],
    productId: json["product_id"],
    wishlistId: json["wishlist_id"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "is_in_wishlist": isInWishlist,
    "product_id": productId,
    "wishlist_id": wishlistId,
  };
}
