import 'dart:convert';

class ProductQuestionResponse {
  List<ProductQuestion>? data;
  Links? links;
  Meta? meta;
  bool? success;
  bool? result;
  int? status;

  ProductQuestionResponse({
    this.data,
    this.links,
    this.meta,
    this.success,
    this.result,
    this.status,
  });

  factory ProductQuestionResponse.fromJson(Map<String, dynamic> json) =>
      ProductQuestionResponse(
        data: json['data'] == null
            ? null
            : List<ProductQuestion>.from(
            json['data'].map((x) => ProductQuestion.fromJson(x))),
        links: json['links'] == null ? null : Links.fromJson(json['links']),
        meta: json['meta'] == null ? null : Meta.fromJson(json['meta']),
        success: json['success'],
        result: json['result'],
        status: json['status'],
      );
}

class ProductQuestion {
  String? name;
  int? productId;
  String? text;
  String? time;
  List<ProductQuestion>? replies;

  ProductQuestion({
    this.name,
    this.productId,
    this.text,
    this.time,
    this.replies,
  });

  factory ProductQuestion.fromJson(Map<String, dynamic> json) =>
      ProductQuestion(
        name: json['name'],
        productId: json['product_id'],
        text: json['text'],
        time: json['time'],
        replies: json['replies'] == null
            ? []
            : List<ProductQuestion>.from(
            json['replies'].map((x) => ProductQuestion.fromJson(x))),
      );
}

class Links {
  String? first;
  String? last;
  String? prev;
  String? next;

  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    first: json['first'],
    last: json['last'],
    prev: json['prev'],
    next: json['next'],
  );
}

class Meta {
  int? currentPage;
  int? from;
  int? lastPage;
  List<MetaLink>? links;
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

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    currentPage: json['current_page'],
    from: json['from'],
    lastPage: json['last_page'],
    links: json['links'] == null
        ? null
        : List<MetaLink>.from(
        json['links'].map((x) => MetaLink.fromJson(x))),
    path: json['path'],
    perPage: json['per_page'],
    to: json['to'],
    total: json['total'],
  );
}

class MetaLink {
  String? url;
  String? label;
  bool? active;

  MetaLink({
    this.url,
    this.label,
    this.active,
  });

  factory MetaLink.fromJson(Map<String, dynamic> json) => MetaLink(
    url: json['url'],
    label: json['label'],
    active: json['active'],
  );
}
