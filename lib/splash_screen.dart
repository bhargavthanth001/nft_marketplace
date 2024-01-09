import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nft_marketplace/bottom_nav_bar.dart';

import 'authentication pages/login_page.dart';
import 'data manager/session_manager.dart';
import 'data_variables.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool? _isSignIn;

  Future<void> getSignInInfo() async {
    _isSignIn = await SessionManager.getSession();
    debugPrint("CURRENT USER IS => $_isSignIn");
  }

  @override
  void initState() {
    super.initState();
    getSignInInfo();
    debugPrint("CURRENT USER => ${auth.currentUser}");
    Timer(const Duration(seconds: 2), () {
      _isSignIn!
          ? Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const BottomNavBar(),
              ),
            )
          : Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const LoginPageWidget(),
              ),
            );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                image: const DecorationImage(
                  image: AssetImage("assets/images/logo.jpg"),
                ),
              ),
            ),
            const Gap(20),
            const Text(
              "NFT Marketplace",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
