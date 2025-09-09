import 'package:hive/hive.dart';

part 'cart_local_model.g.dart'; // generated file (build_runner দিয়ে আসবে)

@HiveType(typeId: 0)
class CartItemLocal {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? slug;

  @HiveField(4)
  int? productId;

  @HiveField(5)
  String? productName;

  @HiveField(6)
  String? productThumbnailImage;

  @HiveField(7)
  int? isPreorder;

  @HiveField(9)
  double? price;

  @HiveField(13)
  int? quantity;

  @HiveField(14)
  int? lowerLimit;

  @HiveField(15)
  int? upperLimit;

  CartItemLocal({
    this.id,
    this.slug,
    this.productId,
    this.productName,
    this.productThumbnailImage,
    this.isPreorder,
    this.price,
    this.quantity,
    this.lowerLimit,
    this.upperLimit,
  });

  /// ✅ From API JSON
  factory CartItemLocal.fromJson(Map<String, dynamic> json) {
    return CartItemLocal(
      id: json['id'],
      slug: json['slug'],
      productId: json['product_id'],
      productName: json['product_name'],
      productThumbnailImage: json['product_thumbnail_image'],
      isPreorder: json['is_preorder'],
      price: json['price'],
      quantity: json['quantity'],
      lowerLimit: json['lower_limit'],
      upperLimit: json['upper_limit'],
    );
  }

  /// ✅ To JSON (if you need to send back to API or debug)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'slug': slug,
      'product_id': productId,
      'product_name': productName,
      'product_thumbnail_image': productThumbnailImage,
      'is_preorder': isPreorder,
      'price': price,
      'quantity': quantity,
      'lower_limit': lowerLimit,
      'upper_limit': upperLimit,
    };
  }
}

@HiveType(typeId: 1)
class CartItemGetResponse {
  @HiveField(0)
  String? name;

  @HiveField(1)
  int? ownerId;

  @HiveField(2)
  List<CartItemLocal>? cartItems;

  CartItemGetResponse({
    this.name,
    this.ownerId,
    this.cartItems,
  });

  /// ✅ From API JSON
  factory CartItemGetResponse.fromJson(Map<String, dynamic> json) {
    var list = json['cart_items'] as List?;
    List<CartItemLocal>? cartItemList =
    list?.map((i) => CartItemLocal.fromJson(i)).toList();

    return CartItemGetResponse(
      name: json['name'],
      ownerId: json['owner_id'],
      cartItems: cartItemList,
    );
  }

  /// ✅ To JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'owner_id': ownerId,
      'cart_items': cartItems?.map((e) => e.toJson()).toList(),
    };
  }
}