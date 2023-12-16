// To parse this JSON data, do
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? id;
  String? username;
  String? fullName;
  String? email;
  String? password;
  bool? isSeller;
  String? city;
  String? state;
  String? country;

  UserModel({
    this.id,
    this.username,
    this.fullName,
    this.email,
    this.password,
    this.isSeller,
    this.city,
    this.state,
    this.country,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        username: json["username"],
        fullName: json["fullName"],
        email: json["email"],
        password: json["password"],
        isSeller: json["isSeller"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "fullName": fullName,
        "email": email,
        "password": password,
        "isSeller": isSeller,
        "city": city,
        "state": state,
        "country": country,
      };
}
