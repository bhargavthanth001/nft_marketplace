import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:nft_marketplace/authentication%20pages/registration_page.dart';
import 'package:nft_marketplace/provider/sign_in_provider.dart';
import 'package:provider/provider.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnBoardingSlider(
        headerBackgroundColor: Colors.white,
        pageBackgroundColor: Colors.white,
        finishButtonText: 'Register',
        controllerColor: Colors.blue,
        finishButtonStyle: const FinishButtonStyle(
          backgroundColor: Colors.blue,
        ),
        onFinish: () =>
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const RegistrationPageWidget())),
        skipTextButton: const Text(
          'Skip',
          style: TextStyle(color: Colors.blue),
        ),
        trailing: const Text(
          'Login',
          style: TextStyle(
            color: Colors.blue,
          ),
        ),
        background: [
          SizedBox(
            height: 500,
            width: 360,
            child: Image.asset('assets/images/image_1.png'),
          ),
          SizedBox(
            height: 500,
            width: 360,
            child: Image.asset('assets/images/image_2.png'),
          ),
          SizedBox(
            height: 500,
            width: 360,
            child: Image.asset('assets/images/image_3.png'),
          ),
        ],
        totalPage: 3,
        speed: 1.8,
        pageBodies: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: const Column(
              children: <Widget>[
                SizedBox(
                  height: 480,
                ),
                Text('Description Text 1'),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: const Column(
              children: <Widget>[
                SizedBox(
                  height: 480,
                ),
                Text('Description Text 2'),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: const Column(
              children: <Widget>[
                SizedBox(
                  height: 480,
                ),
                Text('Description Text 3'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
