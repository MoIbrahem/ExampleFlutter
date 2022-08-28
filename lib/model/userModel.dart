class UsersModel {
  String? id;
  String? name;
  String? age;


  UsersModel({this.id, this.age, this.name});

  factory UsersModel.fromMap(Map<String, dynamic> json) => UsersModel(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        age: json["age"] == null ? null : json["age"],

      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'age': age,

      };
}
