import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nft_marketplace/model/user_model.dart';

class Authentication {
  User? currentUser = FirebaseAuth.instance.currentUser;

  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

// void createUser(UserModel userModel) {
//   auth
//       .createUserWithEmailAndPassword(
//           email: userModel.email!, password: userModel.password!)
//       .then((value) {
//     debugPrint("user created");
//     userModel.id = currentUser!.uid;
//     firestore
//         .collection("user")
//         .doc(currentUser!.uid)
//         .set(userModel.toJson());
//   });
// }
}
