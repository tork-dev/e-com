class KireiTubeResponse {
  final List<Data>? data;
  final bool? success;
  final int? status;

  KireiTubeResponse({
    this.data,
    this.success,
    this.status,
  });

  factory KireiTubeResponse.fromJson(Map<String, dynamic> json) {
    return KireiTubeResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
      success: json['success'] as bool?,
      status: json['status'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.map((e) => e.toJson()).toList(),
      'success': success,
      'status': status,
    };
  }
}

class Data {
  final int? id;
  final String? title;
  final String? slug;
  final String? categoryName;
  final String? banner;
  final String? shortDescription;
  final String? description;
  final String? video;
  final Statistics? statistics;

  Data({
    this.id,
    this.title,
    this.slug,
    this.categoryName,
    this.banner,
    this.shortDescription,
    this.description,
    this.video,
    this.statistics,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'] as int?,
      title: json['title'] as String?,
      slug: json['slug'] as String?,
      categoryName: json['category_name'] as String?,
      banner: json['banner'] as String?,
      shortDescription: json['short_description'] as String?,
      description: json['description'] as String?,
      video: json['video'] as String?,
      statistics: json['statistics'] is Map<String, dynamic>
          ? Statistics.fromJson(json['statistics'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'slug': slug,
      'category_name': categoryName,
      'banner': banner,
      'short_description': shortDescription,
      'description': description,
      'video': video,
      'statistics': statistics?.toJson(),
    };
  }
}

class Statistics {
  final String? viewCount;
  final String? likeCount;
  final String? favoriteCount;
  final String? commentCount;

  Statistics({
    this.viewCount,
    this.likeCount,
    this.favoriteCount,
    this.commentCount,
  });

  factory Statistics.fromJson(Map<String, dynamic> json) {
    return Statistics(
      viewCount: json['viewCount'] as String?,
      likeCount: json['likeCount'] as String?,
      favoriteCount: json['favoriteCount'] as String?,
      commentCount: json['commentCount'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'viewCount': viewCount,
      'likeCount': likeCount,
      'favoriteCount': favoriteCount,
      'commentCount': commentCount,
    };
  }
}
