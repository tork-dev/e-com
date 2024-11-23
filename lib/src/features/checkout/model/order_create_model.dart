import 'dart:convert';

class OrderCreateResponse {
  bool? result;
  String? message;
  Data? data;
  dynamic code;

  OrderCreateResponse({
    this.result,
    this.message,
    this.data,
    this.code,
  });

  factory OrderCreateResponse.fromRawJson(String str) => OrderCreateResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderCreateResponse.fromJson(Map<String, dynamic> json) => OrderCreateResponse(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
    "data": data?.toJson(),
    "code": code,
  };
}

class Data {
  Order? order;
  dynamic paymentUrl;

  Data({
    this.order,
    this.paymentUrl,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    order: json["order"] == null ? null : Order.fromJson(json["order"]),
    paymentUrl: json["payment_url"],
  );

  Map<String, dynamic> toJson() => {
    "order": order?.toJson(),
    "payment_url": paymentUrl,
  };
}

class Order {
  int? userId;
  String? shippingAddress;
  String? paymentType;
  String? paymentStatus;
  dynamic grandTotal;
  dynamic shippingCost;
  dynamic couponDiscount;
  int? id;
  dynamic rewardPointEarned;
  List<OrderDetail>? orderDetails;

  Order({
    this.userId,
    this.shippingAddress,
    this.paymentType,
    this.paymentStatus,
    this.grandTotal,
    this.shippingCost,
    this.couponDiscount,
    this.id,
    this.rewardPointEarned,
    this.orderDetails,
  });

  factory Order.fromRawJson(String str) => Order.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    userId: json["user_id"],
    shippingAddress: json["shipping_address"],
    paymentType: json["payment_type"],
    paymentStatus: json["payment_status"],
    grandTotal: json["grand_total"]?.toDouble(),
    shippingCost: json["shipping_cost"],
    couponDiscount: json["coupon_discount"]?.toDouble(),
    id: json["id"],
    rewardPointEarned: json["reward_point_earned"]?.toDouble(),
    orderDetails: json["order_details"] == null ? [] : List<OrderDetail>.from(json["order_details"]!.map((x) => OrderDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "shipping_address": shippingAddress,
    "payment_type": paymentType,
    "payment_status": paymentStatus,
    "grand_total": grandTotal,
    "shipping_cost": shippingCost,
    "coupon_discount": couponDiscount,
    "id": id,
    "reward_point_earned": rewardPointEarned,
    "order_details": orderDetails == null ? [] : List<dynamic>.from(orderDetails!.map((x) => x.toJson())),
  };
}

class OrderDetail {
  int? id;
  int? orderId;
  dynamic sellerId;
  int? productId;
  dynamic comboProductId;
  dynamic variation;
  dynamic unitPrice;
  dynamic price;
  dynamic rewardPointUsed;
  dynamic discount;
  dynamic couponCode;
  dynamic tax;
  dynamic shippingCost;
  dynamic quantity;
  dynamic productStockId;
  int? isPreOrder;
  String? paymentStatus;
  String? deliveryStatus;
  dynamic shippingType;
  dynamic pickupPointId;
  dynamic productReferralCode;
  DateTime? createdAt;
  DateTime? updatedAt;
  Product? product;

  OrderDetail({
    this.id,
    this.orderId,
    this.sellerId,
    this.productId,
    this.comboProductId,
    this.variation,
    this.unitPrice,
    this.price,
    this.rewardPointUsed,
    this.discount,
    this.couponCode,
    this.tax,
    this.shippingCost,
    this.quantity,
    this.productStockId,
    this.isPreOrder,
    this.paymentStatus,
    this.deliveryStatus,
    this.shippingType,
    this.pickupPointId,
    this.productReferralCode,
    this.createdAt,
    this.updatedAt,
    this.product,
  });

  factory OrderDetail.fromRawJson(String str) => OrderDetail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
    id: json["id"],
    orderId: json["order_id"],
    sellerId: json["seller_id"],
    productId: json["product_id"],
    comboProductId: json["combo_product_id"],
    variation: json["variation"],
    unitPrice: json["unit_price"],
    price: json["price"],
    rewardPointUsed: json["reward_point_used"],
    discount: json["discount"]?.toDouble(),
    couponCode: json["coupon_code"],
    tax: json["tax"],
    shippingCost: json["shipping_cost"],
    quantity: json["quantity"],
    productStockId: json["product_stock_id"],
    isPreOrder: json["is_pre_order"],
    paymentStatus: json["payment_status"],
    deliveryStatus: json["delivery_status"],
    shippingType: json["shipping_type"],
    pickupPointId: json["pickup_point_id"],
    productReferralCode: json["product_referral_code"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    product: json["product"] == null ? null : Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "seller_id": sellerId,
    "product_id": productId,
    "combo_product_id": comboProductId,
    "variation": variation,
    "unit_price": unitPrice,
    "price": price,
    "reward_point_used": rewardPointUsed,
    "discount": discount,
    "coupon_code": couponCode,
    "tax": tax,
    "shipping_cost": shippingCost,
    "quantity": quantity,
    "product_stock_id": productStockId,
    "is_pre_order": isPreOrder,
    "payment_status": paymentStatus,
    "delivery_status": deliveryStatus,
    "shipping_type": shippingType,
    "pickup_point_id": pickupPointId,
    "product_referral_code": productReferralCode,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "product": product?.toJson(),
  };
}

class Product {
  int? id;
  String? name;
  String? photos;
  String? thumbnailImg;
  String? tags;
  String? shortDescription;
  String? description;
  String? goodFor;
  String? skinTypes;
  String? keyIngredients;
  dynamic unitPrice;
  dynamic purchasePrice;
  dynamic groupPurchasePrice;
  dynamic costPrice;
  String? attributes;
  String? choiceOptions;
  String? colors;
  String? variations;
  String? stockVisibilityState;
  dynamic sideFeatured;
  DateTime? preorderDeliveryDate;
  dynamic preorderStartDate;
  dynamic preorderEndDate;
  String? unit;
  dynamic lowStockQuantity;
  String? discountType;
  dynamic discountStartDate;
  dynamic discountEndDate;
  dynamic tax;
  dynamic taxType;
  String? shippingType;
  dynamic estShippingDays;
  String? metaTitle;
  String? metaDescription;
  String? metaImg;
  String? metaTags;
  dynamic pdf;
  String? slug;
  double? rating;
  dynamic barcode;
  dynamic jenCode;
  dynamic fileName;
  dynamic filePath;
  dynamic externalLink;
  String? externalLinkBtn;
  String? totalStock;
  String? sixtyDaysSale;
  dynamic comboIds;
  dynamic comboQuantities;
  List<dynamic>? taxes;

  Product({
    this.id,
    this.name,
    this.photos,
    this.thumbnailImg,
    this.shortDescription,
    this.description,
    this.unitPrice,
    this.purchasePrice,
    this.groupPurchasePrice,
    this.costPrice,
    this.attributes,
    this.choiceOptions,
    this.colors,
    this.variations,
    this.stockVisibilityState,
    this.sideFeatured,
    this.preorderDeliveryDate,
    this.preorderStartDate,
    this.preorderEndDate,
    this.unit,
    this.lowStockQuantity,
    this.discountType,
    this.discountStartDate,
    this.discountEndDate,
    this.tax,
    this.taxType,
    this.shippingType,
    this.estShippingDays,
    this.metaTitle,
    this.metaDescription,
    this.metaImg,
    this.metaTags,
    this.pdf,
    this.slug,
    this.rating,
    this.barcode,
    this.jenCode,
    this.fileName,
    this.filePath,
    this.externalLink,
    this.externalLinkBtn,
    this.totalStock,
    this.sixtyDaysSale,
    this.comboIds,
    this.comboQuantities,
    this.taxes,
  });

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    photos: json["photos"],
    thumbnailImg: json["thumbnail_img"],
    shortDescription: json["short_description"],
    description: json["description"],
    unitPrice: json["unit_price"],
    purchasePrice: json["purchase_price"],
    groupPurchasePrice: json["group_purchase_price"],
    costPrice: json["cost_price"],
    attributes: json["attributes"],
    choiceOptions: json["choice_options"],
    colors: json["colors"],
    variations: json["variations"],
    stockVisibilityState: json["stock_visibility_state"],
    sideFeatured: json["side_featured"],
    preorderDeliveryDate: json["preorder_delivery_date"] == null ? null : DateTime.parse(json["preorder_delivery_date"]),
    preorderStartDate: json["preorder_start_date"],
    preorderEndDate: json["preorder_end_date"],
    unit: json["unit"],
    lowStockQuantity: json["low_stock_quantity"],
    discountType: json["discount_type"],
    discountStartDate: json["discount_start_date"],
    discountEndDate: json["discount_end_date"],
    tax: json["tax"],
    taxType: json["tax_type"],
    shippingType: json["shipping_type"],
    estShippingDays: json["est_shipping_days"],
    metaTitle: json["meta_title"],
    metaDescription: json["meta_description"],
    metaImg: json["meta_img"],
    metaTags: json["meta_tags"],
    pdf: json["pdf"],
    slug: json["slug"],
    rating: json["rating"]?.toDouble(),
    barcode: json["barcode"],
    jenCode: json["jen_code"],
    fileName: json["file_name"],
    filePath: json["file_path"],
    externalLink: json["external_link"],
    externalLinkBtn: json["external_link_btn"],
    totalStock: json["total_stock"],
    sixtyDaysSale: json["sixty_days_sale"],
    comboIds: json["combo_ids"],
    comboQuantities: json["combo_quantities"],
    taxes: json["taxes"] == null ? [] : List<dynamic>.from(json["taxes"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "photos": photos,
    "thumbnail_img": thumbnailImg,
    "tags": tags,
    "short_description": shortDescription,
    "description": description,
    "good_for": goodFor,
    "skin_types": skinTypes,
    "key_ingredients": keyIngredients,
    "unit_price": unitPrice,
    "purchase_price": purchasePrice,
    "group_purchase_price": groupPurchasePrice,
    "cost_price": costPrice,
    "attributes": attributes,
    "choice_options": choiceOptions,
    "colors": colors,
    "variations": variations,
    "stock_visibility_state": stockVisibilityState,
    "side_featured": sideFeatured,
    "preorder_delivery_date": "${preorderDeliveryDate!.year.toString().padLeft(4, '0')}-${preorderDeliveryDate!.month.toString().padLeft(2, '0')}-${preorderDeliveryDate!.day.toString().padLeft(2, '0')}",
    "preorder_start_date": preorderStartDate,
    "preorder_end_date": preorderEndDate,
    "unit": unit,
    "low_stock_quantity": lowStockQuantity,
    "discount_type": discountType,
    "discount_start_date": discountStartDate,
    "discount_end_date": discountEndDate,
    "tax": tax,
    "tax_type": taxType,
    "shipping_type": shippingType,
    "est_shipping_days": estShippingDays,
    "meta_title": metaTitle,
    "meta_description": metaDescription,
    "meta_img": metaImg,
    "meta_tags": metaTags,
    "pdf": pdf,
    "slug": slug,
    "rating": rating,
    "barcode": barcode,
    "jen_code": jenCode,
    "file_name": fileName,
    "file_path": filePath,
    "external_link": externalLink,
    "external_link_btn": externalLinkBtn,

    "total_stock": totalStock,
    "sixty_days_sale": sixtyDaysSale,
    "combo_ids": comboIds,
    "combo_quantities": comboQuantities,
    "taxes": taxes == null ? [] : List<dynamic>.from(taxes!.map((x) => x)),
  };
}

