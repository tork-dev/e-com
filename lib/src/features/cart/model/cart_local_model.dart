import 'package:hive/hive.dart';

part 'cart_local_model.g.dart'; // generated file (build_runner)

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
  dynamic price;

  @HiveField(13)
  int? quantity;

  @HiveField(14)
  int? lowerLimit;

  @HiveField(15)
  int? upperLimit;

  @HiveField(16) // new field
  int? requestAvailable;

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
    this.requestAvailable,
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
      requestAvailable: json['request_available'], // new param
    );
  }

  /// ✅ To JSON
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
      'request_available': requestAvailable, // new param
    };
  }

  /// ✅ copyWith helper
  CartItemLocal copyWith({
    int? id,
    String? slug,
    int? productId,
    String? productName,
    String? productThumbnailImage,
    int? isPreorder,
    int? quantity,
    double? price,
    int? lowerLimit,
    int? upperLimit,
    int? requestAvailable, // new param
  }) {
    return CartItemLocal(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      lowerLimit: lowerLimit ?? this.lowerLimit,
      upperLimit: upperLimit ?? this.upperLimit,
      slug: slug ?? this.slug,
      productThumbnailImage: productThumbnailImage ?? this.productThumbnailImage,
      isPreorder: isPreorder ?? this.isPreorder,
      requestAvailable: requestAvailable ?? this.requestAvailable, // new param
    );
  }
}
