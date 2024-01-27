import 'dart:convert';

import 'package:nft_marketplace/model/blockchain_model.dart';

NftModel nftModelFromJson(String str) => NftModel.fromJson(json.decode(str));

String nftModelToJson(NftModel data) => json.encode(data.toJson());

class NftModel {
  String? id;
  String? title;
  String? description;
  String? collectionName;
  String? collectionId;
  String? category;
  String? imageUrl;
  String? rate;
  String? chain;
  String? createdBy;
  String? currentOwner;
  List<String>? owners;
  List<BlockchainModel>? blockchain;
  String? createdAt;
  String? updatedAt;

  NftModel({
    this.id,
    this.title,
    this.description,
    this.collectionName,
    this.collectionId,
    this.category,
    this.imageUrl,
    this.rate,
    this.chain,
    this.createdBy,
    this.currentOwner,
    this.owners,
    this.blockchain,
    this.createdAt,
    this.updatedAt,
  });

  factory NftModel.fromJson(Map<String, dynamic> json) => NftModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        collectionName: json["collectionName"],
        collectionId: json["collectionId"],
        category: json["category"],
        imageUrl: json["imageUrl"],
        rate: json["rate"],
        chain: json["chain"],
        createdBy: json["createdBy"],
        currentOwner: json["currentOwner"],
        owners: List<String>.from(json["owners"].map((x) => x)),
        blockchain: List<BlockchainModel>.from(
            json["blockchain"].map((x) => BlockchainModel.fromJson(x))),
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "collectionName": collectionName,
        "collectionId": collectionId,
        "category": category,
        "imageUrl": imageUrl,
        "rate": rate,
        "chain": chain,
        "createdBy": createdBy,
        "currentOwner": currentOwner,
        "owners": List<String>.from(owners!.map((x) => x)),
        "blockchain": List<dynamic>.from(blockchain!.map((x) => x.toJson())),
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}
