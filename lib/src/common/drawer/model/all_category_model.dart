import 'dart:convert';

class AllCategory {
  int? id;
  String? icon;
  dynamic banner;
  int? isTop;
  int? isFeatured;
  String? name;
  String? slug;
  bool? disabled;
  int? counts;
  List<AllCategoryChild>? children;

  AllCategory({
    this.id,
    this.icon,
    this.banner,
    this.isTop,
    this.isFeatured,
    this.name,
    this.slug,
    this.disabled,
    this.counts,
    this.children,
  });

  factory AllCategory.fromRawJson(String str) => AllCategory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AllCategory.fromJson(Map<String, dynamic> json) => AllCategory(
    id: json["id"],
    icon: json["icon"],
    banner: json["banner"],
    isTop: json["is_top"],
    isFeatured: json["is_featured"],
    name: json["name"],
    slug: json["slug"],
    disabled: json["disabled"],
    counts: json["counts"],
    children: json["children"] == null ? [] : List<AllCategoryChild>.from(json["children"]!.map((x) => AllCategoryChild.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "icon": icon,
    "banner": banner,
    "is_top": isTop,
    "is_featured": isFeatured,
    "name": name,
    "slug": slug,
    "disabled": disabled,
    "counts": counts,
    "children": children == null ? [] : List<dynamic>.from(children!.map((x) => x.toJson())),
  };
}

class AllCategoryChild {
  String? name;
  List<ChildChild>? children;
  int? id;
  String? icon;
  dynamic banner;
  int? isTop;
  int? isFeatured;
  String? slug;
  bool? disabled;
  int? counts;

  AllCategoryChild({
    this.name,
    this.children,
    this.id,
    this.icon,
    this.banner,
    this.isTop,
    this.isFeatured,
    this.slug,
    this.disabled,
    this.counts,
  });

  factory AllCategoryChild.fromRawJson(String str) => AllCategoryChild.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AllCategoryChild.fromJson(Map<String, dynamic> json) => AllCategoryChild(
    name: json["name"],
    children: json["children"] == null ? [] : List<ChildChild>.from(json["children"]!.map((x) => ChildChild.fromJson(x))),
    id: json["id"],
    icon: json["icon"],
    banner: json["banner"],
    isTop: json["is_top"],
    isFeatured: json["is_featured"],
    slug: json["slug"],
    disabled: json["disabled"],
    counts: json["counts"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "children": children == null ? [] : List<dynamic>.from(children!.map((x) => x.toJson())),
    "id": id,
    "icon": icon,
    "banner": banner,
    "is_top": isTop,
    "is_featured": isFeatured,
    "slug": slug,
    "disabled": disabled,
    "counts": counts,
  };
}

class ChildChild {
  int? id;
  String? icon;
  dynamic banner;
  int? isTop;
  int? isFeatured;
  String? name;
  String? slug;
  bool? disabled;
  int? counts;
  String? title;
  int? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;

  ChildChild({
    this.id,
    this.icon,
    this.banner,
    this.isTop,
    this.isFeatured,
    this.name,
    this.slug,
    this.disabled,
    this.counts,
    this.title,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory ChildChild.fromRawJson(String str) => ChildChild.fromJson(json.decode(str));


  String toRawJson() => json.encode(toJson());

  factory ChildChild.fromJson(Map<String, dynamic> json) => ChildChild(
    id: json["id"],
    icon: json["icon"],
    banner: json["banner"],
    isTop: json["is_top"],
    isFeatured: json["is_featured"],
    name: json["name"],
    slug: json["slug"],
    disabled: json["disabled"],
    counts: json["counts"],
    title: json["title"],
    isActive: json["is_active"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "icon": icon,
    "banner": banner,
    "is_top": isTop,
    "is_featured": isFeatured,
    "name": name,
    "slug": slug,
    "disabled": disabled,
    "counts": counts,
    "title": title,
    "is_active": isActive,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
