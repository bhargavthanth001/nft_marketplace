import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nft_marketplace/HomePage/home_page.dart';
import 'package:nft_marketplace/authentication%20pages/login_page.dart';
import 'package:nft_marketplace/data%20manager/local_data_manager.dart';
import 'package:nft_marketplace/model/user_model.dart';
import 'package:nft_marketplace/provider/internet_provider.dart';
import 'package:nft_marketplace/provider/sign_in_provider.dart';
import 'package:provider/provider.dart';
import 'package:gap/gap.dart';

import 'nav_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool? _isSignIn;

  Future<void> getSignInData() async {
    _isSignIn = await LocalDataManager.checkSignInUser();
    debugPrint("Sign in called => $_isSignIn");
  }

  @override
  void initState() {
    final sp = context.read<SignInProvider>();
    super.initState();
    getSignInData();
    Timer(const Duration(seconds: 2), () {
      _isSignIn!
          ? Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const NavBar()))
          : Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const LoginPageWidget()));
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
