class CartItem {
  int? id;
  int? ownerId;
  int? userId;
  int? productId;
  String? productName;
  String? productThumbnailImage;
  int? isPreorder;
  String? variation;
  int? price;
  String? currencySymbol;
  int? tax;
  int? shippingCost;
  int? quantity;
  int? lowerLimit;
  int? upperLimit;

  CartItem({
    this.id,
    this.ownerId,
    this.userId,
    this.productId,
    this.productName,
    this.productThumbnailImage,
    this.isPreorder,
    this.variation,
    this.price,
    this.currencySymbol,
    this.tax,
    this.shippingCost,
    this.quantity,
    this.lowerLimit,
    this.upperLimit,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      ownerId: json['owner_id'],
      userId: json['user_id'],
      productId: json['product_id'],
      productName: json['product_name'],
      productThumbnailImage: json['product_thumbnail_image'],
      isPreorder: json['is_preorder'],
      variation: json['variation'],
      price: json['price'],
      currencySymbol: json['currency_symbol'],
      tax: json['tax'],
      shippingCost: json['shipping_cost'],
      quantity: json['quantity'],
      lowerLimit: json['lower_limit'],
      upperLimit: json['upper_limit'],
    );
  }
}

class CartItemGetResponse {
  String? name;
  int? ownerId;
  List<CartItem>? cartItems;

  CartItemGetResponse({
    this.name,
    this.ownerId,
    this.cartItems,
  });

  factory CartItemGetResponse.fromJson(Map<String, dynamic> json) {
    var list = json['cart_items'] as List?;
    List<CartItem>? cartItemList = list?.map((i) => CartItem.fromJson(i)).toList();

    return CartItemGetResponse(
      name: json['name'],
      ownerId: json['owner_id'],
      cartItems: cartItemList,
    );
  }
}
