import 'package:flutter/cupertino.dart';
import 'package:nft_marketplace/data%20manager/database_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nft_marketplace/data%20manager/session_manager.dart';

class SignInProvider extends ChangeNotifier {
  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    DataBase.createUser();
    notifyListeners();
  }

  Future<void> signOutGoogle() async {
    await GoogleSignIn().signOut();
    debugPrint("User Sign Out");
    notifyListeners();
  }
}
