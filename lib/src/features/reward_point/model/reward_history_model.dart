import 'dart:convert';

class RewardHistoryResponse {
  List<Datum>? data;
  bool? result;
  int? status;

  RewardHistoryResponse({
    this.data,
    this.result,
    this.status,
  });

  factory RewardHistoryResponse.fromJson(String str) => RewardHistoryResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RewardHistoryResponse.fromMap(Map<String, dynamic> json) => RewardHistoryResponse(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
    result: json["result"],
    status: json["status"],
  );

  Map<String, dynamic> toMap() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    "result": result,
    "status": status,
  };
}

class Datum {
  int? id;
  dynamic orderId;
  int? totalRewardPointEarned;
  DateTime? date;
  String? event;
  String? source;

  Datum({
    this.id,
    this.orderId,
    this.totalRewardPointEarned,
    this.date,
    this.event,
    this.source,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    orderId: json["order_id"],
    totalRewardPointEarned: json["total_reward_point_earned"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    event: json["event"],
    source: json["source"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "order_id": orderId,
    "total_reward_point_earned": totalRewardPointEarned,
    "date": date,
    "event": event,
    "source": source,
  };
}
