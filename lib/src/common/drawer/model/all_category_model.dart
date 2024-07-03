import 'dart:convert';
import 'package:http/http.dart' as http;

class AllCategory {
  final int id;
  final String? icon;
  final String? banner;
  final int isTop;
  final int isFeatured;
  final String name;
  final String slug;
  final bool disabled;
  final int counts;
  final List<AllCategory>? children;

  AllCategory({
    required this.id,
    this.icon,
    this.banner,
    required this.isTop,
    required this.isFeatured,
    required this.name,
    required this.slug,
    required this.disabled,
    required this.counts,
    this.children,
  });

  factory AllCategory.fromJson(Map<String, dynamic> json) {
    return AllCategory(
      id: json['id'],
      icon: json['icon'],
      banner: json['banner'],
      isTop: json['is_top'],
      isFeatured: json['is_featured'],
      name: json['name'],
      slug: json['slug'],
      disabled: json['disabled'],
      counts: json['counts'],
      children: (json['children'] as List<dynamic>?)
          ?.map((child) => AllCategory.fromJson(child))
          .toList(),
    );
  }
}

