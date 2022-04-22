// To parse this JSON data, do
//
//     final blogModel = blogModelFromJson(jsonString);

import 'dart:convert';

BlogModel singleblogModelFromJson(String str) =>
    BlogModel.fromJson(json.decode(str));

String singleblogModelToJson(BlogModel data) => json.encode(data.toJson());

List<BlogModel> blogModelFromJson(String str) =>
    List<BlogModel>.from(json.decode(str).map((x) => BlogModel.fromJson(x)));

String blogModelToJson(List<BlogModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BlogModel {
  BlogModel({
    required this.blogId,
    required this.blogTitle,
    required this.writerName,
    required this.postedDate,
    required this.numOfViews,
    required this.blogImage,
    required this.content,
  });

  int blogId;
  String blogTitle;
  String writerName;
  String postedDate;
  int numOfViews;
  String blogImage;
  String content;

  factory BlogModel.fromJson(Map<String, dynamic> json) => BlogModel(
        blogId: json["blog_id"],
        blogTitle: json["blog_title"],
        writerName: json["writer_name"],
        postedDate: json["posted_date"],
        numOfViews: json["num_of_views"] ?? 0,
        blogImage: json["blog_image"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "blog_id": blogId,
        "blog_title": blogTitle,
        "writer_name": writerName,
        "posted_date": postedDate,
        "num_of_views": numOfViews,
        "blog_image": blogImage,
        "content": content,
      };
}
