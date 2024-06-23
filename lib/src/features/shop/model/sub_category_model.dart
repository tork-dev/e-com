class ProductSubCategoryItem {
  final int id;
  final String? icon;
  final String? banner;
  final int isTop;
  final int isFeatured;
  final String name;
  final String slug;
  final bool disabled;
  final int counts;

  ProductSubCategoryItem({
    required this.id,
    this.icon,
    this.banner,
    required this.isTop,
    required this.isFeatured,
    required this.name,
    required this.slug,
    required this.disabled,
    required this.counts,
  });

  factory ProductSubCategoryItem.fromJson(Map<String, dynamic> json) {
    return ProductSubCategoryItem(
      id: json['id'],
      icon: json['icon'],
      banner: json['banner'],
      isTop: json['is_top'],
      isFeatured: json['is_featured'],
      name: json['name'],
      slug: json['slug'],
      disabled: json['disabled'],
      counts: json['counts'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'icon': icon,
      'banner': banner,
      'is_top': isTop,
      'is_featured': isFeatured,
      'name': name,
      'slug': slug,
      'disabled': disabled,
      'counts': counts,
    };
  }
}
