import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nft_marketplace/data%20manager/session_manager.dart';
import 'package:nft_marketplace/nav_bar.dart';
import 'package:nft_marketplace/provider/internet_provider.dart';
import 'package:nft_marketplace/provider/sign_in_provider.dart';

// ignore: depend_on_referenced_packages
import 'package:rounded_loading_button/rounded_loading_button.dart';

// ignore: depend_on_referenced_packages
import 'package:awesome_icons/awesome_icons.dart';

// ignore: depend_on_referenced_packages
import 'package:gap/gap.dart';

// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import '../snack_bar.dart';

class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({super.key});

  @override
  State<LoginPageWidget> createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  final RoundedLoadingButtonController googleController =
      RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
        ),
      ),
      body: Column(
        children: [
          const Spacer(),
          RoundedLoadingButton(
            controller: googleController,
            successColor: Colors.red,
            color: Colors.red,
            onPressed: () async {
              handleGoogleSignIn();
            },
            child: const Wrap(
              children: [
                Icon(
                  FontAwesomeIcons.google,
                  size: 20,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Sign in with google",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const Gap(30),
        ],
      ),
    );
  }

  // handling google sig in in
  Future<void> handleGoogleSignIn() async {
    final sp = context.read<SignInProvider>();
    final ip = context.read<InternetProvider>();
    await ip.checkInternetConnection();

    if (ip.isInternet == false) {
      // ignore: use_build_context_synchronously
      openSnackbar(context, "Check your internet", Colors.red);
    } else {
      sp.signInWithGoogle().then((value) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const NavBar()));
        SessionManager.setSession();
      });
    }
  }
}
