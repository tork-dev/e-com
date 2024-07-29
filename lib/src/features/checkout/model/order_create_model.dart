import 'dart:convert';

class OrderCreateResponse {
  bool? result;
  String? message;
  Data? data;
  int? code;

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
  int? apiCredentialId;
  String? orderSource;
  String? shippingAddress;
  String? paymentType;
  String? paymentStatus;
  int? deliveryStatus;
  int? date;
  dynamic note;
  int? isRecurring;
  double? grandTotal;
  int? shippingCost;
  double? couponDiscount;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;
  double? rewardPointEarned;
  List<OrderDetail>? orderDetails;
  User? user;

  Order({
    this.userId,
    this.apiCredentialId,
    this.orderSource,
    this.shippingAddress,
    this.paymentType,
    this.paymentStatus,
    this.deliveryStatus,
    this.date,
    this.note,
    this.isRecurring,
    this.grandTotal,
    this.shippingCost,
    this.couponDiscount,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.rewardPointEarned,
    this.orderDetails,
    this.user,
  });

  factory Order.fromRawJson(String str) => Order.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    userId: json["user_id"],
    apiCredentialId: json["api_credential_id"],
    orderSource: json["order_source"],
    shippingAddress: json["shipping_address"],
    paymentType: json["payment_type"],
    paymentStatus: json["payment_status"],
    deliveryStatus: json["delivery_status"],
    date: json["date"],
    note: json["note"],
    isRecurring: json["is_recurring"],
    grandTotal: json["grand_total"]?.toDouble(),
    shippingCost: json["shipping_cost"],
    couponDiscount: json["coupon_discount"]?.toDouble(),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["id"],
    rewardPointEarned: json["reward_point_earned"]?.toDouble(),
    orderDetails: json["order_details"] == null ? [] : List<OrderDetail>.from(json["order_details"]!.map((x) => OrderDetail.fromJson(x))),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "api_credential_id": apiCredentialId,
    "order_source": orderSource,
    "shipping_address": shippingAddress,
    "payment_type": paymentType,
    "payment_status": paymentStatus,
    "delivery_status": deliveryStatus,
    "date": date,
    "note": note,
    "is_recurring": isRecurring,
    "grand_total": grandTotal,
    "shipping_cost": shippingCost,
    "coupon_discount": couponDiscount,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
    "reward_point_earned": rewardPointEarned,
    "order_details": orderDetails == null ? [] : List<dynamic>.from(orderDetails!.map((x) => x.toJson())),
    "user": user?.toJson(),
  };
}

class OrderDetail {
  int? id;
  int? orderId;
  dynamic sellerId;
  int? productId;
  dynamic comboProductId;
  dynamic variation;
  int? unitPrice;
  int? price;
  int? rewardPointUsed;
  double? discount;
  dynamic couponCode;
  int? tax;
  int? shippingCost;
  int? quantity;
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
  String? addedBy;
  int? userId;
  int? categoryId;
  int? brandId;
  String? photos;
  String? thumbnailImg;
  int? videoProvider;
  dynamic videoLink;
  String? tags;
  String? shortDescription;
  String? guide;
  String? description;
  String? goodFor;
  String? skinTypes;
  String? keyIngredients;
  int? unitPrice;
  int? purchasePrice;
  int? groupPurchasePrice;
  int? groupMemberQuantity;
  int? costPrice;
  int? rewardPoint;
  int? variantProduct;
  String? attributes;
  String? choiceOptions;
  String? colors;
  String? variations;
  int? todaysDeal;
  int? published;
  int? approved;
  String? stockVisibilityState;
  int? cashOnDelivery;
  int? featured;
  dynamic sideFeatured;
  int? sellerFeatured;
  int? currentStock;
  int? preorderAvailable;
  int? requestAvailable;
  int? preorderAmount;
  DateTime? preorderDeliveryDate;
  dynamic preorderStartDate;
  dynamic preorderEndDate;
  int? maxPreorderQuantity;
  String? unit;
  int? minQty;
  dynamic lowStockQuantity;
  int? discount;
  String? discountType;
  dynamic discountStartDate;
  dynamic discountEndDate;
  dynamic tax;
  dynamic taxType;
  String? shippingType;
  int? shippingCost;
  int? isQuantityMultiplied;
  dynamic estShippingDays;
  int? numOfSale;
  String? metaTitle;
  String? metaDescription;
  String? metaImg;
  String? metaTags;
  dynamic pdf;
  String? slug;
  double? rating;
  dynamic barcode;
  dynamic jenCode;
  int? digital;
  int? auctionProduct;
  dynamic fileName;
  dynamic filePath;
  dynamic externalLink;
  String? externalLinkBtn;
  int? wholesaleProduct;
  String? totalStock;
  int? totalSale;
  String? sixtyDaysSale;
  int? isCombo;
  dynamic comboIds;
  dynamic comboQuantities;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<ProductTranslation>? productTranslations;
  List<dynamic>? taxes;

  Product({
    this.id,
    this.name,
    this.addedBy,
    this.userId,
    this.categoryId,
    this.brandId,
    this.photos,
    this.thumbnailImg,
    this.videoProvider,
    this.videoLink,
    this.tags,
    this.shortDescription,
    this.guide,
    this.description,
    this.goodFor,
    this.skinTypes,
    this.keyIngredients,
    this.unitPrice,
    this.purchasePrice,
    this.groupPurchasePrice,
    this.groupMemberQuantity,
    this.costPrice,
    this.rewardPoint,
    this.variantProduct,
    this.attributes,
    this.choiceOptions,
    this.colors,
    this.variations,
    this.todaysDeal,
    this.published,
    this.approved,
    this.stockVisibilityState,
    this.cashOnDelivery,
    this.featured,
    this.sideFeatured,
    this.sellerFeatured,
    this.currentStock,
    this.preorderAvailable,
    this.requestAvailable,
    this.preorderAmount,
    this.preorderDeliveryDate,
    this.preorderStartDate,
    this.preorderEndDate,
    this.maxPreorderQuantity,
    this.unit,
    this.minQty,
    this.lowStockQuantity,
    this.discount,
    this.discountType,
    this.discountStartDate,
    this.discountEndDate,
    this.tax,
    this.taxType,
    this.shippingType,
    this.shippingCost,
    this.isQuantityMultiplied,
    this.estShippingDays,
    this.numOfSale,
    this.metaTitle,
    this.metaDescription,
    this.metaImg,
    this.metaTags,
    this.pdf,
    this.slug,
    this.rating,
    this.barcode,
    this.jenCode,
    this.digital,
    this.auctionProduct,
    this.fileName,
    this.filePath,
    this.externalLink,
    this.externalLinkBtn,
    this.wholesaleProduct,
    this.totalStock,
    this.totalSale,
    this.sixtyDaysSale,
    this.isCombo,
    this.comboIds,
    this.comboQuantities,
    this.createdAt,
    this.updatedAt,
    this.productTranslations,
    this.taxes,
  });

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    addedBy: json["added_by"],
    userId: json["user_id"],
    categoryId: json["category_id"],
    brandId: json["brand_id"],
    photos: json["photos"],
    thumbnailImg: json["thumbnail_img"],
    videoProvider: json["video_provider"],
    videoLink: json["video_link"],
    tags: json["tags"],
    shortDescription: json["short_description"],
    guide: json["guide"],
    description: json["description"],
    goodFor: json["good_for"],
    skinTypes: json["skin_types"],
    keyIngredients: json["key_ingredients"],
    unitPrice: json["unit_price"],
    purchasePrice: json["purchase_price"],
    groupPurchasePrice: json["group_purchase_price"],
    groupMemberQuantity: json["group_member_quantity"],
    costPrice: json["cost_price"],
    rewardPoint: json["reward_point"],
    variantProduct: json["variant_product"],
    attributes: json["attributes"],
    choiceOptions: json["choice_options"],
    colors: json["colors"],
    variations: json["variations"],
    todaysDeal: json["todays_deal"],
    published: json["published"],
    approved: json["approved"],
    stockVisibilityState: json["stock_visibility_state"],
    cashOnDelivery: json["cash_on_delivery"],
    featured: json["featured"],
    sideFeatured: json["side_featured"],
    sellerFeatured: json["seller_featured"],
    currentStock: json["current_stock"],
    preorderAvailable: json["preorder_available"],
    requestAvailable: json["request_available"],
    preorderAmount: json["preorder_amount"],
    preorderDeliveryDate: json["preorder_delivery_date"] == null ? null : DateTime.parse(json["preorder_delivery_date"]),
    preorderStartDate: json["preorder_start_date"],
    preorderEndDate: json["preorder_end_date"],
    maxPreorderQuantity: json["max_preorder_quantity"],
    unit: json["unit"],
    minQty: json["min_qty"],
    lowStockQuantity: json["low_stock_quantity"],
    discount: json["discount"],
    discountType: json["discount_type"],
    discountStartDate: json["discount_start_date"],
    discountEndDate: json["discount_end_date"],
    tax: json["tax"],
    taxType: json["tax_type"],
    shippingType: json["shipping_type"],
    shippingCost: json["shipping_cost"],
    isQuantityMultiplied: json["is_quantity_multiplied"],
    estShippingDays: json["est_shipping_days"],
    numOfSale: json["num_of_sale"],
    metaTitle: json["meta_title"],
    metaDescription: json["meta_description"],
    metaImg: json["meta_img"],
    metaTags: json["meta_tags"],
    pdf: json["pdf"],
    slug: json["slug"],
    rating: json["rating"]?.toDouble(),
    barcode: json["barcode"],
    jenCode: json["jen_code"],
    digital: json["digital"],
    auctionProduct: json["auction_product"],
    fileName: json["file_name"],
    filePath: json["file_path"],
    externalLink: json["external_link"],
    externalLinkBtn: json["external_link_btn"],
    wholesaleProduct: json["wholesale_product"],
    totalStock: json["total_stock"],
    totalSale: json["total_sale"],
    sixtyDaysSale: json["sixty_days_sale"],
    isCombo: json["is_combo"],
    comboIds: json["combo_ids"],
    comboQuantities: json["combo_quantities"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    productTranslations: json["product_translations"] == null ? [] : List<ProductTranslation>.from(json["product_translations"]!.map((x) => ProductTranslation.fromJson(x))),
    taxes: json["taxes"] == null ? [] : List<dynamic>.from(json["taxes"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "added_by": addedBy,
    "user_id": userId,
    "category_id": categoryId,
    "brand_id": brandId,
    "photos": photos,
    "thumbnail_img": thumbnailImg,
    "video_provider": videoProvider,
    "video_link": videoLink,
    "tags": tags,
    "short_description": shortDescription,
    "guide": guide,
    "description": description,
    "good_for": goodFor,
    "skin_types": skinTypes,
    "key_ingredients": keyIngredients,
    "unit_price": unitPrice,
    "purchase_price": purchasePrice,
    "group_purchase_price": groupPurchasePrice,
    "group_member_quantity": groupMemberQuantity,
    "cost_price": costPrice,
    "reward_point": rewardPoint,
    "variant_product": variantProduct,
    "attributes": attributes,
    "choice_options": choiceOptions,
    "colors": colors,
    "variations": variations,
    "todays_deal": todaysDeal,
    "published": published,
    "approved": approved,
    "stock_visibility_state": stockVisibilityState,
    "cash_on_delivery": cashOnDelivery,
    "featured": featured,
    "side_featured": sideFeatured,
    "seller_featured": sellerFeatured,
    "current_stock": currentStock,
    "preorder_available": preorderAvailable,
    "request_available": requestAvailable,
    "preorder_amount": preorderAmount,
    "preorder_delivery_date": "${preorderDeliveryDate!.year.toString().padLeft(4, '0')}-${preorderDeliveryDate!.month.toString().padLeft(2, '0')}-${preorderDeliveryDate!.day.toString().padLeft(2, '0')}",
    "preorder_start_date": preorderStartDate,
    "preorder_end_date": preorderEndDate,
    "max_preorder_quantity": maxPreorderQuantity,
    "unit": unit,
    "min_qty": minQty,
    "low_stock_quantity": lowStockQuantity,
    "discount": discount,
    "discount_type": discountType,
    "discount_start_date": discountStartDate,
    "discount_end_date": discountEndDate,
    "tax": tax,
    "tax_type": taxType,
    "shipping_type": shippingType,
    "shipping_cost": shippingCost,
    "is_quantity_multiplied": isQuantityMultiplied,
    "est_shipping_days": estShippingDays,
    "num_of_sale": numOfSale,
    "meta_title": metaTitle,
    "meta_description": metaDescription,
    "meta_img": metaImg,
    "meta_tags": metaTags,
    "pdf": pdf,
    "slug": slug,
    "rating": rating,
    "barcode": barcode,
    "jen_code": jenCode,
    "digital": digital,
    "auction_product": auctionProduct,
    "file_name": fileName,
    "file_path": filePath,
    "external_link": externalLink,
    "external_link_btn": externalLinkBtn,
    "wholesale_product": wholesaleProduct,
    "total_stock": totalStock,
    "total_sale": totalSale,
    "sixty_days_sale": sixtyDaysSale,
    "is_combo": isCombo,
    "combo_ids": comboIds,
    "combo_quantities": comboQuantities,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "product_translations": productTranslations == null ? [] : List<dynamic>.from(productTranslations!.map((x) => x.toJson())),
    "taxes": taxes == null ? [] : List<dynamic>.from(taxes!.map((x) => x)),
  };
}

class ProductTranslation {
  int? id;
  int? productId;
  String? name;
  String? unit;
  String? description;
  dynamic lang;
  DateTime? createdAt;
  DateTime? updatedAt;

  ProductTranslation({
    this.id,
    this.productId,
    this.name,
    this.unit,
    this.description,
    this.lang,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductTranslation.fromRawJson(String str) => ProductTranslation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductTranslation.fromJson(Map<String, dynamic> json) => ProductTranslation(
    id: json["id"],
    productId: json["product_id"],
    name: json["name"],
    unit: json["unit"],
    description: json["description"],
    lang: json["lang"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "name": name,
    "unit": unit,
    "description": description,
    "lang": lang,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class User {
  int? id;
  dynamic referredBy;
  dynamic providerId;
  String? userType;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  dynamic verificationCode;
  dynamic newEmailVerificiationCode;
  String? deviceToken;
  String? avatar;
  String? avatarOriginal;
  dynamic address;
  dynamic country;
  dynamic state;
  dynamic city;
  dynamic cityId;
  dynamic zoneId;
  dynamic areaId;
  dynamic postalCode;
  dynamic phone;
  int? balance;
  int? isDeactive;
  int? banned;
  dynamic referralCode;
  dynamic customerPackageId;
  int? remainingUploads;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.id,
    this.referredBy,
    this.providerId,
    this.userType,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.verificationCode,
    this.newEmailVerificiationCode,
    this.deviceToken,
    this.avatar,
    this.avatarOriginal,
    this.address,
    this.country,
    this.state,
    this.city,
    this.cityId,
    this.zoneId,
    this.areaId,
    this.postalCode,
    this.phone,
    this.balance,
    this.isDeactive,
    this.banned,
    this.referralCode,
    this.customerPackageId,
    this.remainingUploads,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    referredBy: json["referred_by"],
    providerId: json["provider_id"],
    userType: json["user_type"],
    name: json["name"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    verificationCode: json["verification_code"],
    newEmailVerificiationCode: json["new_email_verificiation_code"],
    deviceToken: json["device_token"],
    avatar: json["avatar"],
    avatarOriginal: json["avatar_original"],
    address: json["address"],
    country: json["country"],
    state: json["state"],
    city: json["city"],
    cityId: json["city_id"],
    zoneId: json["zone_id"],
    areaId: json["area_id"],
    postalCode: json["postal_code"],
    phone: json["phone"],
    balance: json["balance"],
    isDeactive: json["is_deactive"],
    banned: json["banned"],
    referralCode: json["referral_code"],
    customerPackageId: json["customer_package_id"],
    remainingUploads: json["remaining_uploads"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "referred_by": referredBy,
    "provider_id": providerId,
    "user_type": userType,
    "name": name,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "verification_code": verificationCode,
    "new_email_verificiation_code": newEmailVerificiationCode,
    "device_token": deviceToken,
    "avatar": avatar,
    "avatar_original": avatarOriginal,
    "address": address,
    "country": country,
    "state": state,
    "city": city,
    "city_id": cityId,
    "zone_id": zoneId,
    "area_id": areaId,
    "postal_code": postalCode,
    "phone": phone,
    "balance": balance,
    "is_deactive": isDeactive,
    "banned": banned,
    "referral_code": referralCode,
    "customer_package_id": customerPackageId,
    "remaining_uploads": remainingUploads,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
