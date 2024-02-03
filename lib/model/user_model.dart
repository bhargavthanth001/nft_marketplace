import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? id;
  String? name;
  String? username;
  String? email;
  String? imageUrl;
  List<String>? collected;
  String? createdAt;
  String? updatedAt;

  UserModel({
    this.id,
    this.name,
    this.username,
    this.email,
    this.imageUrl,
    this.collected,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        imageUrl: json["imageUrl"],
        collected: List<String>.from(json["collected"].map((x) => x)),
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "imageUrl": imageUrl,
        "collected": List<String>.from(collected!.map((x) => x)),
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}
