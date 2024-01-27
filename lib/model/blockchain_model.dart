import 'dart:convert';

class BlockchainModel {
  String? id;
  String from;
  String to;
  String amount;
  String nftId;
  String createdAt;

  BlockchainModel({
    this.id,
    required this.from,
    required this.to,
    required this.amount,
    required this.nftId,
    required this.createdAt,
  });

  factory BlockchainModel.fromJson(Map<String, dynamic> json) =>
      BlockchainModel(
        id: json["id"],
        from: json["from"],
        to: json["to"],
        amount: json["amount"],
        nftId: json["nftId"],
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "from": from,
        "to": to,
        "amount": amount,
        "nftId": nftId,
        "createdAt": createdAt,
      };
}
