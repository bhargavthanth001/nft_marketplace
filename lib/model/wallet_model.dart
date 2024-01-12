import 'dart:convert';

WalletModel walletModelFromJson(String str) =>
    WalletModel.fromJson(json.decode(str));

String walletModelToJson(WalletModel data) => json.encode(data.toJson());

class WalletModel {
  String? walletId;
  CoinList? coin;
  List<TransactionList>? transactions;
  String? createdAt;

  WalletModel({
    this.walletId,
    this.coin,
    this.transactions,
    this.createdAt,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) => WalletModel(
        walletId: json["walletId"],
        coin: CoinList.fromJson(json["coin"]),
        transactions: List<TransactionList>.from(
            json["transactions"].map((x) => TransactionList.fromJson(x))),
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toJson() => {
        "walletId": walletId,
        "coin": coin!.toJson(),
        "transactions":
            List<dynamic>.from(transactions!.map((x) => x.toJson())),
        "createdAt": createdAt,
      };
}

class CoinList {
  double? bitcoin;
  double? ethereum;

  CoinList({
    this.bitcoin,
    this.ethereum,
  });

  factory CoinList.fromJson(Map<String, dynamic> json) => CoinList(
        bitcoin: json["bitcoin"],
        ethereum: json["ethereum"],
      );

  Map<String, dynamic> toJson() => {
        "bitcoin": bitcoin,
        "ethereum": ethereum,
      };
}

class TransactionList {
  String? from;
  String? to;
  double? amount;
  String coinType;
  String? transactedAt;

  TransactionList({
    this.from,
    this.to,
    this.amount,
    required this.coinType,
    this.transactedAt,
  });

  factory TransactionList.fromJson(Map<String, dynamic> json) =>
      TransactionList(
        from: json["from"],
        to: json["to"],
        amount: json["amount"],
        coinType: json["coinType"],
        transactedAt: json["transactedAt"],
      );

  Map<String, dynamic> toJson() => {
        "from": from,
        "to": to,
        "amount": amount,
        "coinType": coinType,
        "transactedAt": transactedAt,
      };
}

enum Chain {
  Ethereum,
  Bitcoin,
}
