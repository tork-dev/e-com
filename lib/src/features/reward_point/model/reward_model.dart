import 'dart:convert';

class RewardResponse {
  List<Membership>? memberships;
  dynamic balance;
  NextMemberships? nextMemberships;

  RewardResponse({
    this.memberships,
    this.balance,
    this.nextMemberships,
  });

  factory RewardResponse.fromJson(String str) => RewardResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RewardResponse.fromMap(Map<String, dynamic> json) => RewardResponse(
    memberships: json["memberships"] == null ? [] : List<Membership>.from(json["memberships"]!.map((x) => Membership.fromMap(x))),
    balance: json["balance"],
    nextMemberships: json["next_memberships"] == null ? null : NextMemberships.fromMap(json["next_memberships"]),
  );

  Map<String, dynamic> toMap() => {
    "memberships": memberships == null ? [] : List<dynamic>.from(memberships!.map((x) => x.toMap())),
    "balance": balance,
    "next_memberships": nextMemberships?.toMap(),
  };
}

class Membership {
  int? id;
  String? title;
  int? minRewardPoint;
  int? isUnlocked;

  Membership({
    this.id,
    this.title,
    this.minRewardPoint,
    this.isUnlocked,
  });

  factory Membership.fromJson(String str) => Membership.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Membership.fromMap(Map<String, dynamic> json) => Membership(
    id: json["id"],
    title: json["title"],
    minRewardPoint: json["min_reward_point"],
    isUnlocked: json["is_unlocked"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "min_reward_point": minRewardPoint,
    "is_unlocked": isUnlocked,
  };
}

class NextMemberships {
  int? id;
  String? title;
  int? minRewardPoint;
  String? lastDate;
  int? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic balance;
  int? needPoint;

  NextMemberships({
    this.id,
    this.title,
    this.minRewardPoint,
    this.lastDate,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.balance,
    this.needPoint,
  });

  factory NextMemberships.fromJson(String str) => NextMemberships.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NextMemberships.fromMap(Map<String, dynamic> json) => NextMemberships(
    id: json["id"],
    title: json["title"],
    minRewardPoint: json["min_reward_point"],
    lastDate: json["last_date"],
    isActive: json["is_active"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    balance: json["balance"],
    needPoint: json["need_point"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "min_reward_point": minRewardPoint,
    "last_date" : lastDate,
    "is_active": isActive,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "balance": balance,
    "need_point": needPoint,
  };
}
