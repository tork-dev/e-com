import 'dart:convert';

class BlogTags {
  List<dynamic>? tags;

  BlogTags({
    this.tags,
  });

  factory BlogTags.fromJson(String str) => BlogTags.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BlogTags.fromMap(Map<String, dynamic> json) => BlogTags(
    tags: json["tags"] == null ? [] : List<dynamic>.from(json["tags"]!.map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
  };
}
