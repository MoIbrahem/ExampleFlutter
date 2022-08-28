class SuccessStories {
  SuccessStories({
    this.statusCode,
    this.success,
    this.message,
    this.model,
  });

  int? statusCode;
  bool? success;
  String? message;
  List<Model>? model;

  factory SuccessStories.fromMap(Map<String, dynamic> json) => SuccessStories(
        statusCode: json["statusCode"] == null ? null : json["statusCode"],
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        model: json["model"] == null
            ? null
            : List<Model>.from(json["model"].map((x) => Model.fromMap(x))),
      );
}


class Model {
  Model({
    this.id,
    this.title,
    this.image,
  });

  String? id;
  String? title;
  String? image;


  factory Model.fromMap(Map<String, dynamic> json) => Model(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        image: json["image"] == null ? null : json["image"],

      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "image": image == null ? null : image,

      };
}
