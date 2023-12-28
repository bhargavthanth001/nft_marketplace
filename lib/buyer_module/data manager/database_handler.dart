import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../model/user_model.dart';

class DataBase {
  static final auth = FirebaseAuth.instance;
  static final firestore = FirebaseFirestore.instance;

  static User get user => auth.currentUser!;

  static Future<bool> userExist() async {
    return (await firestore.collection("users").doc(user.uid).get()).exists;
  }

  static Future<void> createUser() async {
    final date = DateTime.now().toString();
    final userModel = UserModel(
      id: user.uid,
      name: user.displayName.toString(),
      email: user.email.toString(),
      imageUrl: user.photoURL,
      createdAt: date,
      updatedAt: date,
    );

    return await firestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toJson());
  }

  static Future<UserModel> getUser() async {
    DocumentSnapshot data =
        await firestore.collection('users').doc(user.uid).get();

    if (data.exists) {
      return UserModel.fromJson(data.data() as Map<String, dynamic>);
    } else {
      throw Exception('user not found');
    }
  }

  static Future<void> createCollection(String collection) async {
    debugPrint("id => ${user.uid}");
    final result = firestore
        .collection("users")
        .doc(user.uid)
        .collection(collection)
        .doc();
    final id = result.id;
    result.set(
      {
        "id": id,
        "name": collection,
      },
    );
  }
}
