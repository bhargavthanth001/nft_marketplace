import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          Image.asset(
            "assets/images/app_logo.png",
            height: 100,
            width: 100,
          ),
          const Gap(15),
          const Text(
            "NFT Marketplace",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
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
          const Gap(50),
        ],
      ),
    );
  }

  // handling google sing in
  Future<void> handleGoogleSignIn() async {
    final sp = context.read<SignInProvider>();
    final ip = context.read<InternetProvider>();
    await ip.checkInternetConnection();

    if (ip.isInternet == false) {
      // ignore: use_build_context_synchronously
      openSnackBar(context, "Check your internet", Colors.red);
      googleController.reset();
    } else {
      sp.signInWithGoogle().then(
        (value) {
          SessionManager.setSession().then(
            (value) {
              googleController.success();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const BottomNavBar(),
                ),
              );
            },
          );
        },
      );
    }
  }
}
/*Stack(
        children: [
          Container(
            width: 1428.88,
            height: 1085.62,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/login_bg.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            left: 15,
            right: 15,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                height: 160.0,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                ),
                child: Stack(
                  children: [
                    //Blur Effect
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: Container(),
                    ),
                    //Gradient Effect
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(color: Colors.white.withOpacity(0.20)),
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white.withOpacity(0.15),
                              Colors.white.withOpacity(0.05),
                            ]),
                      ),
                    ),
                    Positioned(
                      top: 25,
                      left: 1,
                      right: 1,
                      bottom: 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Explore and Mint NFTs',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'SF Pro Display',
                                  fontWeight: FontWeight.w700,
                                  height: 0.06,
                                  letterSpacing: 0.32,
                                ),
                              ),
                              const SizedBox(height: 30),
                              Text(
                                'You can buy and sell the NFTs of the best artists in the world.',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 11.5,
                                  fontFamily: 'SF Pro Text',
                                  fontWeight: FontWeight.w400,
                                  height: 0.12,
                                  letterSpacing: -0.07,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 27.03),
                          Container(
                            width: 200,
                            height: 45.5,
                            padding: const EdgeInsets.only(
                              top: 13.5,
                              left: 18,
                              right: 19,
                              bottom: 12,
                            ),
                            decoration: ShapeDecoration(
                              color: const Color(0x7F97A9F6),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 1.12,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                borderRadius: BorderRadius.circular(33.54),
                              ),
                            ),
                            child: TextButton(
                              onPressed: () {
                                handleGoogleSignIn();
                              },
                              child: const Text(
                                'Get started now',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.32,
                                  fontFamily: 'SF Pro Text',
                                  fontWeight: FontWeight.w600,
                                  height: 0.08,
                                  letterSpacing: -0.37,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),*/
