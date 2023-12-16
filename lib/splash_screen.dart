import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nft_marketplace/HomePage/home_page.dart';
import 'package:nft_marketplace/on_boarding_screen.dart';
import 'package:nft_marketplace/provider/sign_in_provider.dart';
import 'package:provider/provider.dart';
import 'package:gap/gap.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    final sp = context.read<SignInProvider>();
    super.initState();
    Timer(const Duration(seconds: 2), () {
      debugPrint(sp.isSignIn.toString());
      sp.isSignIn
          ? Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const HomePage()))
          : Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const OnBoardingScreen()));
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
