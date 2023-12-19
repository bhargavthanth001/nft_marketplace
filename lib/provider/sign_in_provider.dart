import 'package:flutter/cupertino.dart';
import 'package:nft_marketplace/data%20manager/database_handler.dart';
import 'package:nft_marketplace/data%20manager/local_data_manager.dart';
import 'package:nft_marketplace/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInProvider extends ChangeNotifier {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  bool _isSignedIn = false;

  bool get isSignedIn => _isSignedIn;
  bool _hasError = false;

  bool get hasError => _hasError;

  String? _errorCode;

  String? get errorCode => _errorCode;

  // sign in with google
  Future signInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    debugPrint("Google Account is => $googleSignInAccount");
    if (googleSignInAccount != null) {
      // executing our authentication
      try {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        // signing to firebase user instance
        final User userDetails =
            (await firebaseAuth.signInWithCredential(credential)).user!;

        UserModel userModel = UserModel(
            id: userDetails.uid,
            name: userDetails.displayName,
            email: userDetails.email,
            imageUrl: userDetails.photoURL);

        if (await DataBase.checkUserExists()) {
          debugPrint("TRUE CALLED");
          LocalDataManager.createSession(userModel);
          notifyListeners();
        } else {
          debugPrint("FALSE CALLED");
          DataBase.saveDataToFirebase(userModel);
          LocalDataManager.createSession(userModel);
          _isSignedIn = true;
          notifyListeners();
        }
        LocalDataManager.setSignIn();
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case "account-exists-with-different-credential":
            _errorCode =
                "You already have an account with us. Use correct provider";
            _hasError = true;
            notifyListeners();
            break;

          case "null":
            _errorCode = "Some unexpected error while trying to sign in";
            _hasError = true;
            notifyListeners();
            break;
          default:
            _errorCode = e.toString();
            _hasError = true;
            notifyListeners();
        }
      }
    } else {
      _hasError = true;
      notifyListeners();
    }
  }

  // sign out
  Future<void> userSignOut() async {
    firebaseAuth.signOut;
    await googleSignIn.signOut();
    _isSignedIn = false;
    LocalDataManager.destroySession();
  }
}
