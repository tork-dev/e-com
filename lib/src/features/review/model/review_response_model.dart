class Review {
  int? id;
  int? userId;
  String? userName;
  String? avatar;
  int? rating;
  String? comment;
  List<String>? images;
  List<dynamic>? replies;
  String? time;
  int? isApproved;

  Review({
    this.id,
    this.userId,
    this.userName,
    this.avatar,
    this.rating,
    this.comment,
    this.images,
    this.replies,
    this.time,
    this.isApproved
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      userId: json['user_id'],
      userName: json['user_name'],
      avatar: json['avatar'] ,
      rating: json['rating'],
      comment: json['comment'],
      images: json['images'] != null ? List<String>.from(json['images']) : [],
      replies: json['replies'] != null ? List<dynamic>.from(json['replies']) : [],
      time: json['time'],
      isApproved: json['is_approved'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'user_name': userName,
      'avatar': avatar,
      'rating': rating,
      'comment': comment,
      'images': images,
      'replies': replies,
      'time': time,
    };
  }
}

class PaginationLinks {
  String? first;
  String? last;
  String? prev;
  String? next;

  PaginationLinks({this.first, this.last, this.prev, this.next});

  factory PaginationLinks.fromJson(Map<String, dynamic> json) {
    return PaginationLinks(
      first: json['first'],
      last: json['last'],
      prev: json['prev'],
      next: json['next'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first': first,
      'last': last,
      'prev': prev,
      'next': next,
    };
  }
}

class Meta {
  int? currentPage;
  int? from;
  int? lastPage;
  List<PageLink>? links;
  String? path;
  int? perPage;
  int? to;
  int? total;

  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.links,
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
      links: (json['links'] as List?)?.map((i) => PageLink.fromJson(i)).toList() ?? [],
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
      'links': links?.map((i) => i.toJson()).toList(),
      'path': path,
      'per_page': perPage,
      'to': to,
      'total': total,
    };
  }
}

class PageLink {
  String? url;
  String? label;
  bool? active;

  PageLink({this.url, this.label, this.active});

  factory PageLink.fromJson(Map<String, dynamic> json) {
    return PageLink(
      url: json['url'],
      label: json['label'],
      active: json['active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'label': label,
      'active': active,
    };
  }
}

class ReviewResponse {
  List<Review>? data;
  PaginationLinks? links;
  Meta? meta;
  bool? success;
  bool? result;
  int? status;
  bool? canReview;
  Review? loggerReview;

  ReviewResponse({this.data, this.links, this.meta, this.success, this.result, this.status, this.canReview, this.loggerReview});

  factory ReviewResponse.fromJson(Map<String, dynamic> json) {
    return ReviewResponse(
      data: (json['data'] as List?)?.map((i) => Review.fromJson(i)).toList() ?? [],
      links: json['links'] != null ? PaginationLinks.fromJson(json['links']) : null,
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
      success: json['success'],
      result: json['result'],
      status: json['status'],
      canReview: json['can_review'],
      // loggerReview: (json['logger_review'] as List?)?.map((i) => Review.fromJson(i)).toList() ?? [],
      loggerReview: json['logger_review'] != null ? Review.fromJson(json['logger_review']) : null,
    );
  }

}
