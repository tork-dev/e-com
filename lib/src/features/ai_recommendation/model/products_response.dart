

class RecommendationProductResponse {
  bool? result;
  List<ProductType>? data;

  RecommendationProductResponse({this.result, this.data});

  factory RecommendationProductResponse.fromJson(Map<String, dynamic> json) {
    return RecommendationProductResponse(
      result: json['result'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ProductType.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

}

class ProductType {
  String? type;
  List<Product>? products;

  ProductType({this.type, this.products});

  factory ProductType.fromJson(Map<String, dynamic> json) {
    return ProductType(
      type: json['type'] as String?,
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
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
  List<SkinType>? skinTypes;
  List<KeyIngredient>? keyIngredients;
  List<GoodFor>? goodFor;
  int? preorderAvailable;
  int? requestAvailable;
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
      id: json['id'] as int?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      price: json['price'] as int?,
      salePrice: json['sale_price'] as int?,
      discount: json['discount'] as int?,
      sku: json['sku'] as String?,
      stock: json['stock'] as int?,
      shortDescription: json['short_description'] as String?,
      description: json['description'] as String?,
      guide: json['guide'] as String?,
      skinTypes: (json['skin_types'] as List<dynamic>?)
          ?.map((e) => SkinType.fromJson(e as Map<String, dynamic>))
          .toList(),
      keyIngredients: (json['key_ingredients'] as List<dynamic>?)
          ?.map((e) => KeyIngredient.fromJson(e as Map<String, dynamic>))
          .toList(),
      goodFor: (json['good_for'] as List<dynamic>?)
          ?.map((e) => GoodFor.fromJson(e as Map<String, dynamic>))
          .toList(),
      preorderAvailable: json['preorder_available'] as int?,
      requestAvailable: json['request_available'] as int?,
      preorderDeliveryDate: json['preorder_delivery_date'] as String?,
      preorderAmount: json['preorder_amount'] as int?,
      preorderStartDate: json['preorder_start_date'] as String?,
      preorderEndDate: json['preorder_end_date'] as String?,
      saleCount: json['sale_count'] as int?,
      ratings: json['ratings'],
      reviews: json['reviews'] as int?,
      isHot: json['is_hot'] as int?,
      isSale: json['is_sale'] as bool?,
      isNew: json['is_new'] as int?,
      isOutOfStock: json['is_out_of_stock'] as bool?,
      releaseDate: json['release_date'] as String?,
      developer: json['developer'] as String?,
      publisher: json['publisher'] as String?,
      gameMode: json['game_mode'] as String?,
      rated: json['rated'] as String?,
      until: json['until'] as String?,
      productCategories: (json['product_categories'] as List<dynamic>?)
          ?.map((e) => ProductCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
      productBrands: (json['product_brands'] as List<dynamic>?)
          ?.map((e) => ProductBrand.fromJson(e as Map<String, dynamic>))
          .toList(),
      productTags: (json['product_tags'] as List<dynamic>?)
          ?.map((e) => ProductTag.fromJson(e as Map<String, dynamic>))
          .toList(),
      onlyTags: json['only_tags'] as String?,
      pictures: (json['pictures'] as List<dynamic>?)
          ?.map((e) => Picture.fromJson(e as Map<String, dynamic>))
          .toList(),
      largePictures: (json['large_pictures'] as List<dynamic>?)
          ?.map((e) => Picture.fromJson(e as Map<String, dynamic>))
          .toList(),
      smallPictures: (json['small_pictures'] as List<dynamic>?)
          ?.map((e) => Picture.fromJson(e as Map<String, dynamic>))
          .toList(),
      //variants: (json['variants'] as List<dynamic>?)
      //    ?.map((e) => Variant.fromJson(e as Map<String, dynamic>))
      //    .toList(),
      isCouponApplicable: json['is_coupon_applicable'] as int?,
      metaImage: json['meta_image'] as String?,
      metaTitle: json['meta_title'] as String?,
      metaDescription: json['meta_description'] as String?,
      metaTags: json['meta_tags'] as String?,
      productLink: json['product_link'] as String?,
    );
  }

}

class SkinType {
  int? id;
  String? name;
  String? slug;
  String? description;
  int? isSelected;

  SkinType({this.id, this.name, this.slug, this.description, this.isSelected});

  factory SkinType.fromJson(Map<String, dynamic> json) {
    return SkinType(
      id: json['id'] as int?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      description: json['description'] as String?,
      isSelected: json['is_selected'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'description': description,
      'is_selected': isSelected,
    };
  }
}

class KeyIngredient {
  int? id;
  String? name;
  String? slug;
  String? description;
  int? isSelected;

  KeyIngredient({this.id, this.name, this.slug, this.description, this.isSelected});

  factory KeyIngredient.fromJson(Map<String, dynamic> json) {
    return KeyIngredient(
      id: json['id'] as int?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      description: json['description'] as String?,
      isSelected: json['is_selected'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'description': description,
      'is_selected': isSelected,
    };
  }
}

class GoodFor {
  int? id;
  String? name;
  String? slug;
  String? description;
  int? isSelected;

  GoodFor({this.id, this.name, this.slug, this.description, this.isSelected});

  factory GoodFor.fromJson(Map<String, dynamic> json) {
    return GoodFor(
      id: json['id'] as int?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      description: json['description'] as String?,
      isSelected: json['is_selected'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'description': description,
      'is_selected': isSelected,
    };
  }
}

class ProductCategory {
  int? id;
  String? name;
  String? slug;
  String? image;
  String? description;

  ProductCategory({this.id, this.name, this.slug, this.image, this.description});

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
      id: json['id'] as int?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      image: json['image'] as String?,
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'image': image,
      'description': description,
    };
  }
}

class ProductBrand {
  int? id;
  String? name;
  String? slug;
  String? image;
  String? description;

  ProductBrand({this.id, this.name, this.slug, this.image, this.description});

  factory ProductBrand.fromJson(Map<String, dynamic> json) {
    return ProductBrand(
      id: json['id'] as int?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      image: json['image'] as String?,
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'image': image,
      'description': description,
    };
  }
}

class ProductTag {
  int? id;
  String? name;
  String? slug;
  String? description;

  ProductTag({this.id, this.name, this.slug, this.description});

  factory ProductTag.fromJson(Map<String, dynamic> json) {
    return ProductTag(
      id: json['id'] as int?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'description': description,
    };
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

class Variant {
  int? id;
  String? name;
  String? slug;
  int? price;
  int? salePrice;
  int? discount;
  String? sku;
  int? stock;
  List<VariantOption>? variantOptions;

  Variant({
    this.id,
    this.name,
    this.slug,
    this.price,
    this.salePrice,
    this.discount,
    this.sku,
    this.stock,
    this.variantOptions,
  });

  factory Variant.fromJson(Map<String, dynamic> json) {
    return Variant(
      id: json['id'] as int?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      price: json['price'] as int?,
      salePrice: json['sale_price'] as int?,
      discount: json['discount'] as int?,
      sku: json['sku'] as String?,
      stock: json['stock'] as int?,
      variantOptions: (json['variant_options'] as List<dynamic>?)
          ?.map((e) => VariantOption.fromJson(e as Map<String, dynamic>))
          .toList(),
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
      'variant_options': variantOptions?.map((e) => e.toJson()).toList(),
    };
  }
}

class VariantOption {
  int? id;
  String? name;
  int? isSelected;

  VariantOption({this.id, this.name, this.isSelected});

  factory VariantOption.fromJson(Map<String, dynamic> json) {
    return VariantOption(
      id: json['id'] as int?,
      name: json['name'] as String?,
      isSelected: json['is_selected'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'is_selected': isSelected,
    };
  }
}
