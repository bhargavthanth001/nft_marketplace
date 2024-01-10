import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:nft_marketplace/model/wallet_model.dart';

import '../../data_variables.dart';

class WalletDataManager {
  static void createWallet(WalletModel walletModel) async {
    final result = firestore.collection("wallet_users").doc(user.uid);
    result.set(walletModel.toJson());
  }

  static Future<void> addCoin(WalletModel walletModel) async {
    firestore
        .collection("wallet_users")
        .doc(walletModel.walletId)
        .update(walletModel.coin!.toJson());
  }

  static String transactionId(String id) {
    return "${user.uid}_$id";
  }

  static Future<WalletModel> getWallet(String id) async {
    DocumentSnapshot data =
        await firestore.collection('wallet_users').doc(id).get();
    if (data.exists) {
      return WalletModel.fromJson(data.data() as Map<String, dynamic>);
    } else {
      throw Exception('user not found');
    }
  }

  static Future<bool> existWallet() async {
    return (await firestore.collection('wallet_users').doc(user.uid).get())
        .exists;
  }

  static void makeTransaction(TransactionList model) async {
    final doc = firestore.collection("wallet_users").doc(model.from);
    final doc2 = firestore.collection("wallet_users").doc(model.to);
    debugPrint("-------------");
    debugPrint(doc.toString());
    debugPrint(doc2.toString());
    debugPrint("-------------");
    doc.update(
      {
        "coin": await debitUpdate(model),
        "transactions": FieldValue.arrayUnion(
          [model.toJson()],
        )
      },
    );
    doc2.update(
      {
        "coin": await creditUpdate(model),
        "transactions": FieldValue.arrayUnion(
          [model.toJson()],
        )
      },
    );
  }

  static Future<Map<String, dynamic>> debitUpdate(TransactionList model) async {
    DocumentSnapshot data =
        await firestore.collection('wallet_users').doc(model.from).get();
    if (data.exists) {
      final doc = WalletModel.fromJson(data.data() as Map<String, dynamic>);
      if (model.coinType == "Ethereum") {
        doc.coin!.ethereum = doc.coin!.ethereum! - model.amount!;
      } else {
        doc.coin!.bitcoin = doc.coin!.bitcoin! - model.amount!;
      }
      return doc.coin!.toJson();
    } else {
      throw Exception('user not found');
    }
  }

  static Future<Map<String, dynamic>> creditUpdate(
      TransactionList model) async {
    DocumentSnapshot data =
        await firestore.collection('wallet_users').doc(model.to).get();
    if (data.exists) {
      final doc = WalletModel.fromJson(data.data() as Map<String, dynamic>);
      if (model.coinType == "Ethereum") {
        doc.coin!.ethereum = doc.coin!.ethereum! + model.amount!;
      } else {
        doc.coin!.bitcoin = doc.coin!.bitcoin! + model.amount!;
      }
      return doc.coin!.toJson();
    } else {
      throw Exception('user not found');
    }
  }

// static Future<CoinList> calculation(TransactionList transactionList) async {
//   DocumentSnapshot data =
//       await firestore.collection('wallet_users').doc(user.uid).get();
//
//   final model = WalletModel.fromJson(data.data() as Map<String, dynamic>);
//   if (transactionList.coinType == "Ethereum") {
//     model.coin!.ethereum = model.coin!.ethereum! - transactionList.amount!;
//     return model.coin!;
//   } else {
//     model.coin!.bitcoin = model.coin!.bitcoin! - transactionList.amount!;
//     return model.coin!;
//   }
// }
}
