import 'package:cloud_firestore/cloud_firestore.dart';
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

  static Future<WalletModel> getWallet() async {
    DocumentSnapshot data =
        await firestore.collection('wallet_users').doc(user.uid).get();

    if (data.exists) {
      return WalletModel.fromJson(data.data() as Map<String, dynamic>);
    } else {
      throw Exception('user not found');
    }
  }

  static Future<void> makeTransaction(WalletModel walletModel) async {
    await firestore.collection("wallet_users").doc(walletModel.walletId).get();
  }

  static Future<bool> existWallet() async {
    return (await firestore.collection('wallet_users').doc(user.uid).get())
        .exists;
  }
}
