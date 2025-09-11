import '../../home/model/home_products_model.dart';

class ShopPageResponse {
  bool? result;
  List<Product>? data;
  String? others;
  Meta? meta;
  String? message;

  ShopPageResponse({
    this.result,
    this.data,
    this.others,
    this.meta,
    this.message,
  });

  factory ShopPageResponse.fromJson(Map<String, dynamic> json) {
    return ShopPageResponse(
      result: json['result'],
      data: json['data'] != null ? List<Product>.from(json['data'].map((x) => Product.fromJson(x))) : null,
      others: json['others'],
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
      message: json['message'],
    );
  }
}

class Meta {
  dynamic currentPage;
  dynamic from;
  dynamic lastPage;
  dynamic path;
  dynamic perPage;
  dynamic to;
  dynamic total;

  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      currentPage: json['current_page'],
      from: json['from'],
      lastPage: json['last_page'],
      path: json['path'],
      perPage: json['per_page'],
      to: json['to'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'from': from,
      'last_page': lastPage,
      'path': path,
      'per_page': perPage,
      'to': to,
      'total': total,
    };
  }
}
