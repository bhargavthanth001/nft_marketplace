import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:nft_marketplace/data%20manager/local_data_manager.dart';
import 'package:nft_marketplace/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class DataBase {
  static User? currentUser = FirebaseAuth.instance.currentUser;
  static final auth = FirebaseAuth.instance;
  static final firestore = FirebaseFirestore.instance;

  static Stream<UserModel> getSingleUser() {
    return firestore
        .collection("users")
        .doc(currentUser!.uid)
        .snapshots()
        .map((event) => UserModel.fromJson(event.data()!));
  }

  static Future<void> saveDataToFirebase(UserModel userModel) async {
    final r = firestore.collection("users").doc(userModel.id);
    r.set(userModel.toJson());
  }

  static Future<bool> checkUserExists() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .get();
    if (snap.exists) {
      debugPrint("EXISTING USER");
      return true;
    } else {
      debugPrint("NEW USER");
      return false;
    }
  }


}
