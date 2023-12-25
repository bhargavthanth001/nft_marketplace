import 'dart:convert';

NftModel nftModelFromJson(String str) => NftModel.fromJson(json.decode(str));

String nftModelToJson(NftModel data) => json.encode(data.toJson());

class NftModel {
  String? id;
  String? title;
  String? description;
  String? rate;
  String? collectionId;
  String? collectionName;
  String? createdBy;
  List<String>? owners;
  String? createdAt;
  String? updatedAt;

  NftModel({
    this.id,
    this.title,
    this.description,
    this.rate,
    this.collectionId,
    this.collectionName,
    this.createdBy,
    this.owners,
    this.createdAt,
    this.updatedAt,
  });

  factory NftModel.fromJson(Map<String, dynamic> json) => NftModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        rate: json["rate"],
        collectionId: json["collectionId"],
        collectionName: json["collectionName"],
        createdBy: json["createdBy"],
        owners: List<String>.from(json["owners"].map((x) => x)),
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "rate": rate,
        "collectionId": collectionId,
        "collectionName": collectionName,
        "createdBy": createdBy,
        "owners": List<String>.from(owners!.map((x) => x)),
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}
