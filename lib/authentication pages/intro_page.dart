import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nft_marketplace/authentication%20pages/registration_page.dart';

class IntroScreenWidget extends StatelessWidget {
  const IntroScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Gap(30),
          Image.asset("assets/images/intro_image.png"),
          const Spacer(),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  height: 50,
                  minWidth: double.infinity,
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const RegistrationPageWidget()));
                  },
                  child: const Text(
                    "Get Started",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an Account?",
                      style: TextStyle(color: Colors.blue),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          const Gap(30),
        ],
      ),
    );
  }
}
