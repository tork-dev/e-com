import 'dart:convert';

class ProductVerifyListResponse {
  List<Datum>? data;
  Links? links;
  Meta? meta;
  bool? success;
  int? status;

  ProductVerifyListResponse({
    this.data,
    this.links,
    this.meta,
    this.success,
    this.status,
  });

  factory ProductVerifyListResponse.fromJson(String str) => ProductVerifyListResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductVerifyListResponse.fromMap(Map<String, dynamic> json) => ProductVerifyListResponse(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
    links: json["links"] == null ? null : Links.fromMap(json["links"]),
    meta: json["meta"] == null ? null : Meta.fromMap(json["meta"]),
    success: json["success"],
    status: json["status"],
  );

  Map<String, dynamic> toMap() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    "links": links?.toMap(),
    "meta": meta?.toMap(),
    "success": success,
    "status": status,
  };
}

class Datum {
  int? id;
  int? orderId;
  int? productId;
  String? productName;
  String? productSlug;
  dynamic variation;
  String? price;
  String? tax;
  String? shippingCost;
  String? couponDiscount;
  int? quantity;
  String? paymentStatus;
  String? paymentStatusString;
  String? deliveryStatus;
  String? deliveryStatusString;
  List<SmallPicture>? smallPictures;
  bool? refundSection;
  bool? refundButton;
  String? refundLabel;
  int? refundRequestStatus;
  bool? isAuthenticReview;
  bool? canUpdateAuthenticReview;

  Datum({
    this.id,
    this.orderId,
    this.productId,
    this.productName,
    this.productSlug,
    this.variation,
    this.price,
    this.tax,
    this.shippingCost,
    this.couponDiscount,
    this.quantity,
    this.paymentStatus,
    this.paymentStatusString,
    this.deliveryStatus,
    this.deliveryStatusString,
    this.smallPictures,
    this.refundSection,
    this.refundButton,
    this.refundLabel,
    this.refundRequestStatus,
    this.isAuthenticReview,
    this.canUpdateAuthenticReview,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    orderId: json["order_id"],
    productId: json["product_id"],
    productName: json["product_name"],
    productSlug: json["product_slug"],
    variation: json["variation"],
    price: json["price"],
    tax: json["tax"],
    shippingCost: json["shipping_cost"],
    couponDiscount: json["coupon_discount"],
    quantity: json["quantity"],
    paymentStatus: json["payment_status"],
    paymentStatusString: json["payment_status_string"],
    deliveryStatus: json["delivery_status"],
    deliveryStatusString: json["delivery_status_string"],
    smallPictures: json["small_pictures"] == null ? [] : List<SmallPicture>.from(json["small_pictures"]!.map((x) => SmallPicture.fromMap(x))),
    refundSection: json["refund_section"],
    refundButton: json["refund_button"],
    refundLabel: json["refund_label"],
    refundRequestStatus: json["refund_request_status"],
    isAuthenticReview: json["is_authentic_review"],
    canUpdateAuthenticReview: json["can_update_authentic_review"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "order_id": orderId,
    "product_id": productId,
    "product_name": productName,
    "product_slug": productSlug,
    "variation": variation,
    "price": price,
    "tax": tax,
    "shipping_cost": shippingCost,
    "coupon_discount": couponDiscount,
    "quantity": quantity,
    "payment_status": paymentStatus,
    "payment_status_string": paymentStatusString,
    "delivery_status": deliveryStatus,
    "delivery_status_string": deliveryStatusString,
    "small_pictures": smallPictures == null ? [] : List<dynamic>.from(smallPictures!.map((x) => x.toMap())),
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
  Pivot? pivot;

  SmallPicture({
    this.url,
    this.width,
    this.height,
    this.pivot,
  });

  factory SmallPicture.fromJson(String str) => SmallPicture.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SmallPicture.fromMap(Map<String, dynamic> json) => SmallPicture(
    url: json["url"],
    width: json["width"],
    height: json["height"],
    pivot: json["pivot"] == null ? null : Pivot.fromMap(json["pivot"]),
  );

  Map<String, dynamic> toMap() => {
    "url": url,
    "width": width,
    "height": height,
    "pivot": pivot?.toMap(),
  };
}

class Pivot {
  int? relatedId;
  String? uploadFileId;

  Pivot({
    this.relatedId,
    this.uploadFileId,
  });

  factory Pivot.fromJson(String str) => Pivot.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Pivot.fromMap(Map<String, dynamic> json) => Pivot(
    relatedId: json["related_id"],
    uploadFileId: json["upload_file_id"],
  );

  Map<String, dynamic> toMap() => {
    "related_id": relatedId,
    "upload_file_id": uploadFileId,
  };
}

class Links {
  String? first;
  String? last;
  dynamic prev;
  dynamic next;

  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  factory Links.fromJson(String str) => Links.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Links.fromMap(Map<String, dynamic> json) => Links(
    first: json["first"],
    last: json["last"],
    prev: json["prev"],
    next: json["next"],
  );

  Map<String, dynamic> toMap() => {
    "first": first,
    "last": last,
    "prev": prev,
    "next": next,
  };
}

class Meta {
  int? currentPage;
  int? from;
  int? lastPage;
  List<Link>? links;
  String? path;
  int? perPage;
  int? to;
  int? total;

  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.links,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  factory Meta.fromJson(String str) => Meta.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Meta.fromMap(Map<String, dynamic> json) => Meta(
    currentPage: json["current_page"],
    from: json["from"],
    lastPage: json["last_page"],
    links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromMap(x))),
    path: json["path"],
    perPage: json["per_page"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toMap() => {
    "current_page": currentPage,
    "from": from,
    "last_page": lastPage,
    "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toMap())),
    "path": path,
    "per_page": perPage,
    "to": to,
    "total": total,
  };
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(String str) => Link.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Link.fromMap(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toMap() => {
    "url": url,
    "label": label,
    "active": active,
  };
}
