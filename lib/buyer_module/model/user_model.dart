// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? id;
  String? name;
  String? email;
  String? imageUrl;
  bool? isSeller;
  String? sellerId;
  String? dob;
  String? phNo;
  String? bank;
  String? accountNo;
  String? ifsc;
  String? createdAt;
  String? updatedAt;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.imageUrl,
    this.isSeller,
    this.sellerId,
    this.dob,
    this.phNo,
    this.bank,
    this.accountNo,
    this.ifsc,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        imageUrl: json["imageUrl"],
        isSeller: json["isSeller"],
        sellerId: json["sellerId"],
        dob: json["dob"],
        phNo: json["phNo"],
        bank: json["bank"],
        accountNo: json["accountNo"],
        ifsc: json["ifsc"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "imageUrl": imageUrl,
        "isSeller": isSeller,
        "sellerId": sellerId,
        "dob": dob,
        "phNo": phNo,
        "bank": bank,
        "accountNo": accountNo,
        "ifsc": ifsc,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}
