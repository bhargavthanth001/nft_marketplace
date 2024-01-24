import 'dart:math' as math;

// ignore: depend_on_referenced_packages
import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:gap/gap.dart';
import 'package:nft_marketplace/bottom_nav_bar.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
// ignore: depend_on_referenced_packages
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../data manager/session_manager.dart';
import '../provider/internet_provider.dart';
import '../provider/sign_in_provider.dart';
import '../utils/snack_bar.dart';

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
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: SweepGradient(
              stops: <double>[0.0, 0.25, 0.5, 0.75, 1.0],
              tileMode: TileMode.clamp,
              startAngle: math.pi * 0.2,
              endAngle: math.pi * 1.7,
              colors: [
                Color(0xFFdf37fc),
                Color(0xFFe167ff),
                Color(0xFF0057ff),
                Color(0xFF189fff),
                Color(0xFF17ef97)
              ],
            ),
          ),
        ),
        Column(
          children: [
            const Gap(50),
            Image.asset(
              "assets/images/app_logo.png",
              height: 100,
              width: double.infinity,
            ),
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
      ],
    );
  }

  // handling google sig in in
  Future<void> handleGoogleSignIn() async {
    final sp = context.read<SignInProvider>();
    final ip = context.read<InternetProvider>();
    await ip.checkInternetConnection();

    if (ip.isInternet == false) {
      // ignore: use_build_context_synchronously
      openSnackBar(context, "Check your internet", Colors.red);
      googleController.reset();
    } else {
      sp.signInWithGoogle().then((value) {
        SessionManager.setSession().then((value) {
          googleController.success();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const BottomNavBar(),
            ),
          );
        });
      });
    }
  }
}
