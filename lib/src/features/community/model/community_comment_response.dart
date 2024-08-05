import 'dart:convert';

class CommunityCommentResponse {
  List<Datum>? data;
  bool? success;
  int? status;

  CommunityCommentResponse({
    this.data,
    this.success,
    this.status,
  });

  factory CommunityCommentResponse.fromRawJson(String str) => CommunityCommentResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CommunityCommentResponse.fromJson(Map<String, dynamic> json) => CommunityCommentResponse(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    success: json["success"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "success": success,
    "status": status,
  };
}

class Datum {
  int? id;
  String? comment;
  String? createdAt;
  String? customerName;
  String? customerAvatar;

  Datum({
    this.id,
    this.comment,
    this.createdAt,
    this.customerName,
    this.customerAvatar,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    comment: json["comment"],
    createdAt: json["created_at"],
    customerName: json["customer_name"],
    customerAvatar: json["customer_avatar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "comment": comment,
    "created_at": createdAt,
    "customer_name": customerName,
    "customer_avatar": customerAvatar,
  };
}
