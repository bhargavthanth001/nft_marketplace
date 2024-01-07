import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'data_variables.dart';

class WalletDataManager {
  static Future<bool> signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> register(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return false;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  static Future<bool> addCoin(String id, String amount) async {
    try {
      String uid = user.uid;
      var value = double.parse(amount);
      DocumentReference documentReference =
          firestore.collection('Users').doc(uid).collection('Coins').doc(id);
      firestore.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(documentReference);
        if (!snapshot.exists) {
          documentReference.set({'Amount': value});
          return true;
        }
        double newAmount =
            (snapshot.data() as Map<String, dynamic>?)?['Amount'] ?? 0;
        transaction.update(documentReference, {'Amount': newAmount});
        return true;
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> removeCoin(String id) async {
    String uid = user.uid;
    firestore.collection('Users').doc(uid).collection('Coins').doc(id).delete();
    return true;
  }

  static getCoins() {
    return firestore
        .collection('Users')
        .doc(user.uid)
        .collection('Coins')
        .snapshots();
  }
}
