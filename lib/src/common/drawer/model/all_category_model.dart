import 'dart:convert';

class AllCategory {
  dynamic id;
  String? name;
  String? slug;
  List<Child>? children;
  String? icon;
  dynamic banner;
  int? isTop;
  int? isFeatured;
  bool? disabled;
  int? counts;
  String? url;

  AllCategory({
    this.id,
    this.name,
    this.slug,
    this.children,
    this.icon,
    this.banner,
    this.isTop,
    this.isFeatured,
    this.disabled,
    this.counts,
    this.url
  });

  factory AllCategory.fromRawJson(String str) => AllCategory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AllCategory.fromJson(Map<String, dynamic> json) => AllCategory(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    children: json["children"] == null ? [] : List<Child>.from(json["children"]!.map((x) => Child.fromJson(x))),
    icon: json["icon"],
    banner: json["banner"],
    isTop: json["is_top"],
    isFeatured: json["is_featured"],
    disabled: json["disabled"],
    counts: json["counts"],
    url: json["url"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "children": children == null ? [] : List<dynamic>.from(children!.map((x) => x.toJson())),
    "icon": icon,
    "banner": banner,
    "is_top": isTop,
    "is_featured": isFeatured,
    "disabled": disabled,
    "counts": counts,
    "url": url
  };
}

class Child {
  int? id;
  String? icon;
  String? banner;
  int? isTop;
  int? isFeatured;
  String? name;
  String? slug;
  bool? disabled;
  int? counts;
  String? url;
  List<Child>? children;

  Child({
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
    this.url
  });

  factory Child.fromRawJson(String str) => Child.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Child.fromJson(Map<String, dynamic> json) => Child(
    id: json["id"],
    icon: json["icon"],
    banner: json["banner"],
    isTop: json["is_top"],
    isFeatured: json["is_featured"],
    name: json["name"],
    slug: json["slug"],
    disabled: json["disabled"],
    counts: json["counts"],
    url: json["url"],
    children: json["children"] == null ? [] : List<Child>.from(json["children"]!.map((x) => Child.fromJson(x))),
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
    "url": url,
    "children": children == null ? [] : List<dynamic>.from(children!.map((x) => x.toJson())),
  };
}
