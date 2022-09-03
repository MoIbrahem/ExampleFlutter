// To parse this JSON data, do
//
//     final postModel = postModelFromMap(jsonString);

import 'dart:convert';

PostModel postModelFromMap(String str) => PostModel.fromMap(json.decode(str));

String postModelToMap(PostModel data) => json.encode(data.toMap());

class PostModel {
  PostModel({
    required this.id,
    required this.title,
    this.description,
    required this.email,
    this.created,
    this.images,
  });

  String id;
  String title;
  String? description;
  String email;
  DateTime? created;
  List? images;

  factory PostModel.fromMap(Map<String, dynamic> json) => PostModel(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        email: json["email"] == null ? null : json["email"],
        created:
            json["created"] == null ? null : DateTime.parse(json["created"]),
        images: json["images"] == null
            ? null
            : List.from(json["images"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "email": email == null ? null : email,
        "created": created == null ? null : created!.toIso8601String(),
        "images":
            images == null ? null : List<dynamic>.from(images!.map((x) => x)),
      };
}
