import 'dart:convert';

WalletModel walletModelFromJson(String str) =>
    WalletModel.fromJson(json.decode(str));

String walletModelToJson(WalletModel data) => json.encode(data.toJson());

class WalletModel {
  String? walletId;
  CoinList? coin;
  List<Transaction>? transactions;
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
        transactions: List<Transaction>.from(
            json["transactions"].map((x) => Transaction.fromJson(x))),
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

class Transaction {
  String? from;
  String? to;
  double? amount;
  String coinType;
  String? transactedAt;

  Transaction({
    this.from,
    this.to,
    this.amount,
    required this.coinType,
    this.transactedAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
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
