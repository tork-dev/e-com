import 'dart:convert';

class OrderDetailsResponseModel {
  int? id;
  int? userId;
  ShippingAddress? shippingAddress;
  String? paymentType;
  dynamic shippingType;
  String? shippingTypeString;
  String? paymentStatus;
  String? paymentStatusString;
  String? deliveryStatus;
  String? deliveryStatusString;
  dynamic couponCode;
  int? grandTotal;
  int? redeemPoint;
  int? rewardPoint;
  int? couponDiscount;
  int? shippingCost;
  int? subtotal;
  String? tax;
  String? date;
  bool? cancelRequest;
  bool? manuallyPayable;
  Links? links;
  List<Product>? products;
  List<ComboProductElement>? comboProducts;

  OrderDetailsResponseModel({
    this.id,
    this.userId,
    this.shippingAddress,
    this.paymentType,
    this.shippingType,
    this.shippingTypeString,
    this.paymentStatus,
    this.paymentStatusString,
    this.deliveryStatus,
    this.deliveryStatusString,
    this.couponCode,
    this.grandTotal,
    this.redeemPoint,
    this.rewardPoint,
    this.couponDiscount,
    this.shippingCost,
    this.subtotal,
    this.tax,
    this.date,
    this.cancelRequest,
    this.manuallyPayable,
    this.links,
    this.products,
    this.comboProducts,
  });

  factory OrderDetailsResponseModel.fromRawJson(String str) => OrderDetailsResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderDetailsResponseModel.fromJson(Map<String, dynamic> json) => OrderDetailsResponseModel(
    id: json["id"],
    userId: json["user_id"],
    shippingAddress: json["shipping_address"] == null ? null : ShippingAddress.fromJson(json["shipping_address"]),
    paymentType: json["payment_type"],
    shippingType: json["shipping_type"],
    shippingTypeString: json["shipping_type_string"],
    paymentStatus: json["payment_status"],
    paymentStatusString: json["payment_status_string"],
    deliveryStatus: json["delivery_status"],
    deliveryStatusString: json["delivery_status_string"],
    couponCode: json["coupon_code"],
    grandTotal: json["grand_total"],
    redeemPoint: json["redeem_point"],
    rewardPoint: json["reward_point"],
    couponDiscount: json["coupon_discount"],
    shippingCost: json["shipping_cost"],
    subtotal: json["subtotal"],
    tax: json["tax"],
    date: json["date"],
    cancelRequest: json["cancel_request"],
    manuallyPayable: json["manually_payable"],
    links: json["links"] == null ? null : Links.fromJson(json["links"]),
    products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
    comboProducts: json["combo_products"] == null ? [] : List<ComboProductElement>.from(json["combo_products"]!.map((x) => ComboProductElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "shipping_address": shippingAddress?.toJson(),
    "payment_type": paymentType,
    "shipping_type": shippingType,
    "shipping_type_string": shippingTypeString,
    "payment_status": paymentStatus,
    "payment_status_string": paymentStatusString,
    "delivery_status": deliveryStatus,
    "delivery_status_string": deliveryStatusString,
    "coupon_code": couponCode,
    "grand_total": grandTotal,
    "redeem_point": redeemPoint,
    "reward_point": rewardPoint,
    "coupon_discount": couponDiscount,
    "shipping_cost": shippingCost,
    "subtotal": subtotal,
    "tax": tax,
    "date": date,
    "cancel_request": cancelRequest,
    "manually_payable": manuallyPayable,
    "links": links?.toJson(),
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
    "combo_products": comboProducts == null ? [] : List<dynamic>.from(comboProducts!.map((x) => x.toJson())),
  };
}

class ComboProductElement {
  int? comboProductId;
  int? quantity;
  int? subTotal;
  ComboProductComboProduct? comboProduct;

  ComboProductElement({
    this.comboProductId,
    this.quantity,
    this.subTotal,
    this.comboProduct,
  });

  factory ComboProductElement.fromRawJson(String str) => ComboProductElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ComboProductElement.fromJson(Map<String, dynamic> json) => ComboProductElement(
    comboProductId: json["combo_product_id"],
    quantity: json["quantity"],
    subTotal: json["sub_total"],
    comboProduct: json["combo_product"] == null ? null : ComboProductComboProduct.fromJson(json["combo_product"]),
  );

  Map<String, dynamic> toJson() => {
    "combo_product_id": comboProductId,
    "quantity": quantity,
    "sub_total": subTotal,
    "combo_product": comboProduct?.toJson(),
  };
}

class ComboProductComboProduct {
  int? id;
  String? name;
  String? slug;
  int? price;
  int? salePrice;
  String? thumbnailImage;
  int? stock;
  int? rating;
  int? sales;
  List<ProductCategory>? productCategories;

  ComboProductComboProduct({
    this.id,
    this.name,
    this.slug,
    this.price,
    this.salePrice,
    this.thumbnailImage,
    this.stock,
    this.rating,
    this.sales,
    this.productCategories,
  });

  factory ComboProductComboProduct.fromRawJson(String str) => ComboProductComboProduct.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ComboProductComboProduct.fromJson(Map<String, dynamic> json) => ComboProductComboProduct(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    price: json["price"],
    salePrice: json["sale_price"],
    thumbnailImage: json["thumbnail_image"],
    stock: json["stock"],
    rating: json["rating"],
    sales: json["sales"],
    productCategories: json["product_categories"] == null ? [] : List<ProductCategory>.from(json["product_categories"]!.map((x) => ProductCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "price": price,
    "sale_price": salePrice,
    "thumbnail_image": thumbnailImage,
    "stock": stock,
    "rating": rating,
    "sales": sales,
    "product_categories": productCategories == null ? [] : List<dynamic>.from(productCategories!.map((x) => x.toJson())),
  };
}

class ProductCategory {
  String? name;
  String? slug;
  int? parentName;
  ProductCategoryPivot? pivot;

  ProductCategory({
    this.name,
    this.slug,
    this.parentName,
    this.pivot,
  });

  factory ProductCategory.fromRawJson(String str) => ProductCategory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductCategory.fromJson(Map<String, dynamic> json) => ProductCategory(
    name: json["name"],
    slug: json["slug"],
    parentName: json["parent_name"],
    pivot: json["pivot"] == null ? null : ProductCategoryPivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "slug": slug,
    "parent_name": parentName,
    "pivot": pivot?.toJson(),
  };
}

class ProductCategoryPivot {
  int? productId;
  int? productCategoryId;

  ProductCategoryPivot({
    this.productId,
    this.productCategoryId,
  });

  factory ProductCategoryPivot.fromRawJson(String str) => ProductCategoryPivot.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductCategoryPivot.fromJson(Map<String, dynamic> json) => ProductCategoryPivot(
    productId: json["product_id"],
    productCategoryId: json["product_category_id"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "product_category_id": productCategoryId,
  };
}

class Links {
  String? details;

  Links({
    this.details,
  });

  factory Links.fromRawJson(String str) => Links.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    details: json["details"],
  );

  Map<String, dynamic> toJson() => {
    "details": details,
  };
}

class Product {
  int? id;
  int? orderId;
  int? productId;
  String? productName;
  String? slug;
  List<SmallPicture>? smallPictures;
  dynamic variation;
  int? unitPrice;
  int? price;
  String? tax;
  int? shippingCost;
  dynamic couponDiscount;
  int? quantity;
  String? paymentStatus;
  String? paymentStatusString;
  String? deliveryStatus;
  String? deliveryStatusString;
  bool? refundSection;
  bool? refundButton;
  String? refundLabel;
  int? refundRequestStatus;
  bool? isAuthenticReview;
  bool? canUpdateAuthenticReview;

  Product({
    this.id,
    this.orderId,
    this.productId,
    this.productName,
    this.slug,
    this.smallPictures,
    this.variation,
    this.unitPrice,
    this.price,
    this.tax,
    this.shippingCost,
    this.couponDiscount,
    this.quantity,
    this.paymentStatus,
    this.paymentStatusString,
    this.deliveryStatus,
    this.deliveryStatusString,
    this.refundSection,
    this.refundButton,
    this.refundLabel,
    this.refundRequestStatus,
    this.isAuthenticReview,
    this.canUpdateAuthenticReview,
  });

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    orderId: json["order_id"],
    productId: json["product_id"],
    productName: json["product_name"],
    slug: json["slug"],
    smallPictures: json["small_pictures"] == null ? [] : List<SmallPicture>.from(json["small_pictures"]!.map((x) => SmallPicture.fromJson(x))),
    variation: json["variation"],
    unitPrice: json["unit_price"],
    price: json["price"],
    tax: json["tax"],
    shippingCost: json["shipping_cost"],
    couponDiscount: json["coupon_discount"],
    quantity: json["quantity"],
    paymentStatus: json["payment_status"],
    paymentStatusString: json["payment_status_string"],
    deliveryStatus: json["delivery_status"],
    deliveryStatusString: json["delivery_status_string"],
    refundSection: json["refund_section"],
    refundButton: json["refund_button"],
    refundLabel: json["refund_label"],
    refundRequestStatus: json["refund_request_status"],
    isAuthenticReview: json["is_authentic_review"],
    canUpdateAuthenticReview: json["can_update_authentic_review"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "product_id": productId,
    "product_name": productName,
    "slug": slug,
    "small_pictures": smallPictures == null ? [] : List<dynamic>.from(smallPictures!.map((x) => x.toJson())),
    "variation": variation,
    "unit_price": unitPrice,
    "price": price,
    "tax": tax,
    "shipping_cost": shippingCost,
    "coupon_discount": couponDiscount,
    "quantity": quantity,
    "payment_status": paymentStatus,
    "payment_status_string": paymentStatusString,
    "delivery_status": deliveryStatus,
    "delivery_status_string": deliveryStatusString,
    "refund_section": refundSection,
    "refund_button": refundButton,
    "refund_label": refundLabel,
    "refund_request_status": refundRequestStatus,
    "is_authentic_review": isAuthenticReview,
    "can_update_authentic_review": canUpdateAuthenticReview,
  };
}

class SmallPicture {
  String? url;
  int? width;
  int? height;
  SmallPicturePivot? pivot;

  SmallPicture({
    this.url,
    this.width,
    this.height,
    this.pivot,
  });

  factory SmallPicture.fromRawJson(String str) => SmallPicture.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SmallPicture.fromJson(Map<String, dynamic> json) => SmallPicture(
    url: json["url"],
    width: json["width"],
    height: json["height"],
    pivot: json["pivot"] == null ? null : SmallPicturePivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "width": width,
    "height": height,
    "pivot": pivot?.toJson(),
  };
}

class SmallPicturePivot {
  int? relatedId;
  String? uploadFileId;

  SmallPicturePivot({
    this.relatedId,
    this.uploadFileId,
  });

  factory SmallPicturePivot.fromRawJson(String str) => SmallPicturePivot.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SmallPicturePivot.fromJson(Map<String, dynamic> json) => SmallPicturePivot(
    relatedId: json["related_id"],
    uploadFileId: json["upload_file_id"],
  );

  Map<String, dynamic> toJson() => {
    "related_id": relatedId,
    "upload_file_id": uploadFileId,
  };
}

class ShippingAddress {
  String? name;
  dynamic email;
  String? address;
  dynamic cityId;
  String? state;
  int? zoneId;
  String? city;
  int? areaId;
  String? area;
  String? phone;
  int? stateId;

  ShippingAddress({
    this.name,
    this.email,
    this.address,
    this.cityId,
    this.state,
    this.zoneId,
    this.city,
    this.areaId,
    this.area,
    this.phone,
    this.stateId,
  });

  factory ShippingAddress.fromRawJson(String str) => ShippingAddress.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ShippingAddress.fromJson(Map<String, dynamic> json) => ShippingAddress(
    name: json["name"],
    email: json["email"],
    address: json["address"],
    cityId: json["city_id"],
    state: json["state"],
    zoneId: json["zone_id"],
    city: json["city"],
    areaId: json["area_id"],
    area: json["area"],
    phone: json["phone"],
    stateId: json["state_id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "address": address,
    "city_id": cityId,
    "state": state,
    "zone_id": zoneId,
    "city": city,
    "area_id": areaId,
    "area": area,
    "phone": phone,
    "state_id": stateId,
  };
}
