import 'dart:convert';

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
  List<SkinType>? skinTypes;
  List<KeyIngredient>? keyIngredients;
  List<GoodFor>? goodFor;
  int? preorderAvailable;
  String? preorderDeliveryDate;
  int? preorderAmount;
  String? preorderStartDate;
  String? preorderEndDate;
  int? saleCount;
  dynamic ratings;
  int? reviews;
  int? isHot;
  bool? isSale;
  int? isNew;
  bool? isOutOfStock;
  String? releaseDate;
  String? developer;
  String? publisher;
  String? gameMode;
  String? rated;
  String? until;
  List<ProductCategory>? productCategories;
  List<ProductBrand>? productBrands;
  List<ProductTag>? productTags;
  String? onlyTags;
  List<Picture>? pictures;
  List<Picture>? largePictures;
  List<Picture>? smallPictures;
  List<Variant>? variants;
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
      price: json['price'],
      salePrice: json['sale_price'],
      discount: json['discount'],
      sku: json['sku'],
      stock: json['stock'],
      shortDescription: json['short_description'],
      description: json['description'],
      guide: json['guide'],
      skinTypes: (json['skin_types'] as List<dynamic>?)
          ?.map((e) => SkinType.fromJson(e as Map<String, dynamic>))
          .toList(),
      keyIngredients: (json['key_ingredients'] as List<dynamic>?)
          ?.map((e) => KeyIngredient.fromJson(e as Map<String, dynamic>))
          .toList(),
      goodFor: (json['good_for'] as List<dynamic>?)
          ?.map((e) => GoodFor.fromJson(e as Map<String, dynamic>))
          .toList(),
      preorderAvailable: json['preorder_available'],
      preorderDeliveryDate: json['preorder_delivery_date'],
      preorderAmount: json['preorder_amount'],
      preorderStartDate: json['preorder_start_date'],
      preorderEndDate: json['preorder_end_date'],
      saleCount: json['sale_count'],
      ratings: json['ratings'],
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
      productCategories: (json['product_categories'] as List<dynamic>?)
          ?.map((e) => ProductCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
      productBrands: (json['product_brands'] as List<dynamic>?)
          ?.map((e) => ProductBrand.fromJson(e as Map<String, dynamic>))
          .toList(),
      productTags: (json['product_tags'] as List<dynamic>?)
          ?.map((e) => ProductTag.fromJson(e as Map<String, dynamic>))
          .toList(),
      onlyTags: json['only_tags'],
      pictures: (json['pictures'] as List<dynamic>?)
          ?.map((e) => Picture.fromJson(e as Map<String, dynamic>))
          .toList(),
      largePictures: (json['large_pictures'] as List<dynamic>?)
          ?.map((e) => Picture.fromJson(e as Map<String, dynamic>))
          .toList(),
      smallPictures: (json['small_pictures'] as List<dynamic>?)
          ?.map((e) => Picture.fromJson(e as Map<String, dynamic>))
          .toList(),
      // variants: (json['variants'] as List<dynamic>).map((e) => Variant.fromJson(e as Map<String, dynamic>)).toList(),
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
      'skin_types': skinTypes?.map((e) => e.toJson()).toList(),
      'key_ingredients': keyIngredients?.map((e) => e.toJson()).toList(),
      'good_for': goodFor?.map((e) => e.toJson()).toList(),
      'preorder_available': preorderAvailable,
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
      'product_categories': productCategories?.map((e) => e.toJson()).toList(),
      'product_brands': productBrands?.map((e) => e.toJson()).toList(),
      'product_tags': productTags?.map((e) => e.toJson()).toList(),
      'only_tags': onlyTags,
      'pictures': pictures?.map((e) => e.toJson()).toList(),
      'large_pictures': largePictures?.map((e) => e.toJson()).toList(),
      'small_pictures': smallPictures?.map((e) => e.toJson()).toList(),
      //'variants': variants.map((e) => e.toJson()).toList(),
      'is_coupon_applicable': isCouponApplicable,
      'meta_image': metaImage,
      'meta_title': metaTitle,
      'meta_description': metaDescription,
      'meta_tags': metaTags,
      'product_link': productLink,
    };
  }
}

class SkinType {
  int? id;
  String? name;

  SkinType({
    this.id,
    this.name,
  });

  factory SkinType.fromJson(Map<String, dynamic> json) {
    return SkinType(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class KeyIngredient {
  int? id;
  String? name;

  KeyIngredient({
    this.id,
    this.name,
  });

  factory KeyIngredient.fromJson(Map<String, dynamic> json) {
    return KeyIngredient(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class GoodFor {
  int? id;
  String? name;

  GoodFor({
    this.id,
    this.name,
  });

  factory GoodFor.fromJson(Map<String, dynamic> json) {
    return GoodFor(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class ProductCategory {
  int? id;
  String? name;

  ProductCategory({
    this.id,
    this.name,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class ProductBrand {
  int? id;
  String? name;

  ProductBrand({
    this.id,
    this.name,
  });

  factory ProductBrand.fromJson(Map<String, dynamic> json) {
    return ProductBrand(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class ProductTag {
  int? id;
  String? name;

  ProductTag({
    this.id,
    this.name,
  });

  factory ProductTag.fromJson(Map<String, dynamic> json) {
    return ProductTag(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class Picture {
  int? id;
  String? url;

  Picture({
    this.id,
    this.url,
  });

  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(
      id: json['id'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
    };
  }
}

class Variant {
  int? id;
  String? name;

  Variant({
    this.id,
    this.name,
  });

  factory Variant.fromJson(Map<String, dynamic> json) {
    return Variant(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
