import 'package:flutter/material.dart';
import 'package:nft_marketplace/chat%20bot/chat_home_page.dart';
import 'package:nft_marketplace/privecy_policy/about_us_page.dart';
import 'package:nft_marketplace/privecy_policy/privecy_policy_page.dart';
import 'package:nft_marketplace/provider/sign_in_provider.dart';
import 'package:nft_marketplace/wallet/net/wallet_data_manager.dart';
import 'package:nft_marketplace/wallet/ui/authentication.dart';
import 'package:nft_marketplace/wallet/ui/wallet_home_page.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

import 'authentication pages/login_page.dart';
import 'data manager/session_manager.dart';

class MorePage extends StatefulWidget {
  const MorePage({Key? key}) : super(key: key);

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "More",
        ),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              handelSignOut().then(
                (value) => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const LoginPageWidget(),
                  ),
                ),
              );
            },
            child: ListTile(
              title: Text(
                "Log out",
                style: TextStyle(
                  color: Colors.red.shade600,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Icon(
                Icons.logout,
                color: Colors.red.shade600,
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              final bool isWallet = await WalletDataManager.existWallet();
              debugPrint("is wallet created => $isWallet");
              if (isWallet) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => WalletHomePage()));
              } else {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Authentication()));
              }
            },
            child: const ListTile(
              title: Text(
                "Wallet",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Icon(
                Icons.wallet,
                color: Colors.black,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const PrivacyPolicyPageWidget(),
                ),
              );
            },
            child: const ListTile(
              title: Text(
                "Privacy Policy",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Icon(
                Icons.privacy_tip_outlined,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AboutUsPageWidget(),
                ),
              );
            },
            child: ListTile(
                title: const Text(
                  "About Us",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Image.asset(
                  "assets/images/information-button.png",
                  height: 25,
                  width: 25,
                )),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ChatHomePage(),
                ),
              );
            },
            child: ListTile(
              title: const Text(
                "Chat with Aral",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Image.asset(
                "assets/images/aral.png",
                height: 25,
                width: 25,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> handelSignOut() async {
    final sp = context.read<SignInProvider>();
    sp.signOutGoogle().then((value) => SessionManager.logOutSession());
  }
}
