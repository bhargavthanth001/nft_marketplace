import 'dart:convert';

NftModel nftModelFromJson(String str) => NftModel.fromJson(json.decode(str));

String nftModelToJson(NftModel data) => json.encode(data.toJson());

class NftModel {
  String? id;
  String? title;
  String? description;
  String? collectionName;
  String? collectionId;
  String? imageUrl;
  String? rate;
  String? createdBy;
  String? currentOwner;
  List<String>? owners;
  String? createdAt;
  String? updatedAt;

  NftModel({
    this.id,
    this.title,
    this.description,
    this.collectionName,
    this.collectionId,
    this.imageUrl,
    this.rate,
    this.createdBy,
    this.currentOwner,
    this.owners,

    this.createdAt,
    this.updatedAt,
  });

  factory NftModel.fromJson(Map<String, dynamic> json) =>
      NftModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        collectionName: json["collectionName"],
        collectionId: json["collectionId"],
        imageUrl: json["imageUrl"],
        rate: json["rate"],
        createdBy: json["createdBy"],
        currentOwner: json["currentOwner"],
        owners: List<String>.from(json["owners"].map((x) => x)),
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "title": title,
        "description": description,
        "collectionName": collectionName,
        "collectionId": collectionId,
        "imageUrl": imageUrl,
        "rate": rate,
        "createdBy": createdBy,
        "currentOwner": currentOwner,
        "owners": List<String>.from(owners!.map((x) => x)),
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}
