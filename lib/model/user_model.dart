// To parse this JSON data, do
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? id;
  String? name;
  String? email;
  String? imageUrl;
  bool isSeller;

  UserModel(
      {this.id, this.name, this.email, this.imageUrl, required this.isSeller});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        imageUrl: json["imageUrl"],
        isSeller: json["isSeller"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "imageUrl": imageUrl,
        "isSeller": isSeller,
      };
}
