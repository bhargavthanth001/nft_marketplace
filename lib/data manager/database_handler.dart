import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:nft_marketplace/data%20manager/session_manager.dart';
import 'package:nft_marketplace/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class DataBase {
  static final auth = FirebaseAuth.instance;
  static final firestore = FirebaseFirestore.instance;

  static User get user => auth.currentUser!;

  static Future<bool> userExist() async {
    return (await firestore.collection("users").doc(user.uid).get()).exists;
  }

  static Future<void> createUser() async {
    // final time = DateTime.now().microsecondsSinceEpoch.toString();

    final userModel = UserModel(
      id: user.uid,
      name: user.displayName.toString(),
      email: user.email.toString(),
      imageUrl: user.photoURL,
      isSeller: false,
    );

    return await firestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toJson());
  }
}
