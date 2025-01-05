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

  Map<String, dynamic> toJson() {
    return {
      'result': result,
      'data': data != null ? List<dynamic>.from(data!.map((x) => x.toJson())) : null,
      'others': others,
      'meta': meta?.toJson(),
      'message': message,
    };
  }
}

class Product {
  int? id;
  String? name;
  String? slug;
  double? price;
  double? salePrice;
  double? discount;
  String? sku;
  int? stock;
  String? shortDescription;
  String? description;
  String? guide;
  List<dynamic>? skinTypes;
  List<dynamic>? keyIngredients;
  List<dynamic>? goodFor;
  int? preorderAvailable;
  int? requestAvailable;
  String? preorderDeliveryDate;
  dynamic preorderAmount;
  String? preorderStartDate;
  String? preorderEndDate;
  int? saleCount;
  double? ratings;
  int? reviews;
  int? isHot;
  bool? isSale;
  int? isNew;
  dynamic isOutOfStock;
  dynamic releaseDate;
  dynamic developer;
  dynamic publisher;
  dynamic gameMode;
  dynamic rated;
  dynamic until;
  List<ProductCategory>? productCategories;
  List<dynamic>? productBrands;
  List<dynamic>? productTags;
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
    this.developer,
    this.publisher,
    this.gameMode,
    this.rated,
    this.until,
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
      price: json['price']?.toDouble(),
      salePrice: json['sale_price']?.toDouble(),
      discount: json['discount']?.toDouble(),
      sku: json['sku'],
      stock: json['stock'],
      shortDescription: json['short_description'],
      description: json['description'],
      guide: json['guide'],
      skinTypes: json['skin_types'] != null ? List<dynamic>.from(json['skin_types']) : [],
      keyIngredients: json['key_ingredients'] != null ? List<dynamic>.from(json['key_ingredients']) : [],
      goodFor: json['good_for'] != null ? List<dynamic>.from(json['good_for']) : [],
      preorderAvailable: json['preorder_available'],
      requestAvailable: json['request_available'],
      preorderDeliveryDate: json['preorder_delivery_date'],
      preorderAmount: json['preorder_amount'],
      preorderStartDate: json['preorder_start_date'],
      preorderEndDate: json['preorder_end_date'],
      saleCount: json['sale_count'],
      ratings: json['ratings']?.toDouble(),
      reviews: json['reviews'],
      isHot: json['is_hot'],
      isSale: json['is_sale'],
      isNew: json['is_new'],
      isOutOfStock: json['is_out_of_stock'],
      releaseDate: json['release_date'],
      developer: json['developer'],
      publisher: json['publisher'],
      gameMode: json['game_mode'],
      rated: json['rated'],
      until: json['until'],
      productCategories: json['product_categories'] != null ? List<ProductCategory>.from(json['product_categories'].map((x) => ProductCategory.fromJson(x))) : [],
      productBrands: json['product_brands'] != null ? List<dynamic>.from(json['product_brands']) : [],
      productTags: json['product_tags'] != null ? List<dynamic>.from(json['product_tags']) : [],
      onlyTags: json['only_tags'],
      pictures: json['pictures'] != null ? List<Picture>.from(json['pictures'].map((x) => Picture.fromJson(x))) : [],
      largePictures: json['large_pictures'] != null ? List<Picture>.from(json['large_pictures'].map((x) => Picture.fromJson(x))) : [],
      smallPictures: json['small_pictures'] != null ? List<Picture>.from(json['small_pictures'].map((x) => Picture.fromJson(x))) : [],
      variants: json['variants'] != null ? List<dynamic>.from(json['variants']) : [],
      isCouponApplicable: json['is_coupon_applicable'],
      metaImage: json['meta_image'],
      metaTitle: json['meta_title'],
      metaDescription: json['meta_description'],
      metaTags: json['meta_tags'],
      productLink: json['product_link'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'price': price,
      'sale_price': salePrice,
      'discount': discount,
      'sku': sku,
      'stock': stock,
      'short_description': shortDescription,
      'description': description,
      'guide': guide,
      'skin_types': skinTypes,
      'key_ingredients': keyIngredients,
      'good_for': goodFor,
      'preorder_available': preorderAvailable,
      'request_available': requestAvailable,
      'preorder_delivery_date': preorderDeliveryDate,
      'preorder_amount': preorderAmount,
      'preorder_start_date': preorderStartDate,
      'preorder_end_date': preorderEndDate,
      'sale_count': saleCount,
      'ratings': ratings,
      'reviews': reviews,
      'is_hot': isHot,
      'is_sale': isSale,
      'is_new': isNew,
      'is_out_of_stock': isOutOfStock,
      'release_date': releaseDate,
      'developer': developer,
      'publisher': publisher,
      'game_mode': gameMode,
      'rated': rated,
      'until': until,
      'product_categories': productCategories != null ? List<dynamic>.from(productCategories!.map((x) => x.toJson())) : null,
      'product_brands': productBrands,
      'product_tags': productTags,
      'only_tags': onlyTags,
      'pictures': pictures != null ? List<dynamic>.from(pictures!.map((x) => x.toJson())) : null,
      'large_pictures': largePictures != null ? List<dynamic>.from(largePictures!.map((x) => x.toJson())) : null,
      'small_pictures': smallPictures != null ? List<dynamic>.from(smallPictures!.map((x) => x.toJson())) : null,
      'variants': variants,
      'is_coupon_applicable': isCouponApplicable,
      'meta_image': metaImage,
      'meta_title': metaTitle,
      'meta_description': metaDescription,
      'meta_tags': metaTags,
      'product_link': productLink,
    };
  }
}

class ProductCategory {
  String? name;
  String? slug;
  dynamic parentName; // Change from String? to dynamic
  Pivot? pivot;

  ProductCategory({
    this.name,
    this.slug,
    this.parentName,
    this.pivot,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
      name: json['name'],
      slug: json['slug'],
      parentName: json['parent_name'],
      pivot: json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'slug': slug,
      'parent_name': parentName,
      'pivot': pivot?.toJson(),
    };
  }
}

class Pivot {
  int? productId;
  int? categoryId;

  Pivot({
    this.productId,
    this.categoryId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(
      productId: json['product_id'],
      categoryId: json['category_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'category_id': categoryId,
    };
  }
}

class Picture {
  int? id;
  String? small;
  String? large;
  String? url;
  Pivot? pivot;

  Picture({
    this.id,
    this.small,
    this.large,
    this.url,
    this.pivot,
  });

  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(
      id: json['id'],
      small: json['small'],
      large: json['large'],
      url: json['url'],
      pivot: json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'small': small,
      'large': large,
      'url': url,
      'pivot': pivot?.toJson(),
    };
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
