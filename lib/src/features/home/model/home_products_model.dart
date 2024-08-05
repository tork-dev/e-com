class HomeProductResponse {
  List<Product>? newProducts;
  List<Product>? bestsellingProducts;
  List<Product>? featuredProducts;
  bool? success;
  int? status;

  HomeProductResponse({
    this.newProducts,
    this.bestsellingProducts,
    this.featuredProducts,
    this.success,
    this.status,
  });

  factory HomeProductResponse.fromJson(Map<String, dynamic> json) {
    return HomeProductResponse(
      newProducts: (json['new_products'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e))
          .toList(),
      bestsellingProducts: (json['bestselling_products'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e))
          .toList(),
      featuredProducts: (json['featured_products'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e))
          .toList(),
      success: json['success'],
      status: json['status'],
    );
  }
}

class Product {
  int? id;
  String? name;
  String? slug;
  int? price;
  int? salePrice;
  int? discount;
  String? sku;
  int? stock;
  String? shortDescription;
  String? description;
  String? guide;
  List<GoodFor>? skinTypes;
  List<GoodFor>? keyIngredients;
  List<GoodFor>? goodFor;
  int? preorderAvailable;
  int? requestAvailable;
  PreorderDeliveryDate? preorderDeliveryDate;
  int? preorderAmount;
  PreorderDate? preorderStartDate;
  PreorderDate? preorderEndDate;
  int? saleCount;
  dynamic ratings;
  int? reviews;
  int? isHot;
  bool? isSale;
  int? isNew;
  bool? isOutOfStock;
  DateTime? releaseDate;
  List<ProductCategory>? productCategories;
  List<ProductBrand>? productBrands;
  List<GoodFor>? productTags;
  String? onlyTags;
  List<Picture>? pictures;
  List<Picture>? largePictures;
  List<Picture>? smallPictures;
  List<dynamic>? variants;
  int? isCouponApplicable;
  String? metaImage;
  String? metaTitle;
  String? metaDescription;
  String? metaTags;
  String? productLink;

  Product({
    this.id,
    this.name,
    this.slug,
    this.price,
    this.salePrice,
    this.discount,
    this.sku,
    this.stock,
    this.shortDescription,
    this.description,
    this.guide,
    this.skinTypes,
    this.keyIngredients,
    this.goodFor,
    this.preorderAvailable,
    this.requestAvailable,
    this.preorderDeliveryDate,
    this.preorderAmount,
    this.preorderStartDate,
    this.preorderEndDate,
    this.saleCount,
    this.ratings,
    this.reviews,
    this.isHot,
    this.isSale,
    this.isNew,
    this.isOutOfStock,
    this.releaseDate,
    this.productCategories,
    this.productBrands,
    this.productTags,
    this.onlyTags,
    this.pictures,
    this.largePictures,
    this.smallPictures,
    this.variants,
    this.isCouponApplicable,
    this.metaImage,
    this.metaTitle,
    this.metaDescription,
    this.metaTags,
    this.productLink,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      price: json['price'],
      salePrice: json['sale_price'],
      discount: json['discount'],
      sku: json['sku'],
      stock: json['stock'],
      shortDescription: json['short_description'],
      description: json['description'],
      guide: json['guide'],
      skinTypes: (json['skin_types'] as List<dynamic>?)
          ?.map((e) => GoodFor.fromJson(e))
          .toList(),
      keyIngredients: (json['key_ingredients'] as List<dynamic>?)
          ?.map((e) => GoodFor.fromJson(e))
          .toList(),
      goodFor: (json['good_for'] as List<dynamic>?)
          ?.map((e) => GoodFor.fromJson(e))
          .toList(),
      preorderAvailable: json['preorder_available'],
      requestAvailable: json['request_available'],
      preorderDeliveryDate:
      _parsePreorderDeliveryDate(json['preorder_delivery_date']),
      preorderAmount: json['preorder_amount'],
      preorderStartDate: _parsePreorderDate(json['preorder_start_date']),
      preorderEndDate: _parsePreorderDate(json['preorder_end_date']),
      saleCount: json['sale_count'],
      ratings: json['ratings'],
      reviews: json['reviews'],
      isHot: json['is_hot'],
      isSale: json['is_sale'],
      isNew: json['is_new'],
      isOutOfStock: json['is_out_of_stock'],
      releaseDate: json['release_date'] != null
          ? DateTime.parse(json['release_date'])
          : null,
      productCategories: (json['product_categories'] as List<dynamic>?)
          ?.map((e) => ProductCategory.fromJson(e))
          .toList(),
      productBrands: (json['product_brands'] as List<dynamic>?)
          ?.map((e) => ProductBrand.fromJson(e))
          .toList(),
      productTags: (json['product_tags'] as List<dynamic>?)
          ?.map((e) => GoodFor.fromJson(e))
          .toList(),
      onlyTags: json['only_tags'],
      pictures: (json['pictures'] as List<dynamic>?)
          ?.map((e) => Picture.fromJson(e))
          .toList(),
      largePictures: (json['large_pictures'] as List<dynamic>?)
          ?.map((e) => Picture.fromJson(e))
          .toList(),
      smallPictures: (json['small_pictures'] as List<dynamic>?)
          ?.map((e) => Picture.fromJson(e))
          .toList(),
      variants: json['variants'],
      isCouponApplicable: json['is_coupon_applicable'],
      metaImage: json['meta_image'],
      metaTitle: json['meta_title'],
      metaDescription: json['meta_description'],
      metaTags: json['meta_tags'],
      productLink: json['product_link'],
    );
  }

  static PreorderDeliveryDate? _parsePreorderDeliveryDate(String? date) {
    if (date == null) return null;
    return date.isNotEmpty ? PreorderDeliveryDate(date) : null;
  }

  static PreorderDate? _parsePreorderDate(String? date) {
    if (date == null) return null;
    return date.isNotEmpty ? PreorderDate(date) : null;
  }
}

class GoodFor {
  String? name;
  String? slug;

  GoodFor({
    this.name,
    this.slug,
  });

  factory GoodFor.fromJson(Map<String, dynamic> json) {
    return GoodFor(
      name: json['name'],
      slug: json['slug'],
    );
  }
}

class PreorderDeliveryDate {
  String? date;

  PreorderDeliveryDate(this.date);
}

class PreorderDate {
  String? date;

  PreorderDate(this.date);
}

class ProductCategory {
  String? name;
  String? slug;
  dynamic parentName;

  ProductCategory({
    this.name,
    this.slug,
    this.parentName,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
      name: json['name'],
      slug: json['slug'],
      parentName: json['parent_name'],
    );
  }
}

class ProductBrand {
  String? name;
  String? slug;

  ProductBrand({
    this.name,
    this.slug,
  });

  factory ProductBrand.fromJson(Map<String, dynamic> json) {
    return ProductBrand(
      name: json['name'],
      slug: json['slug'],
    );
  }
}

class Picture {
  String? url;
  int? width;
  int? height;

  Picture({
    this.url,
    this.width,
    this.height,
  });

  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(
      url: json['url'],
      width: json['width'],
      height: json['height'],
    );
  }
}
