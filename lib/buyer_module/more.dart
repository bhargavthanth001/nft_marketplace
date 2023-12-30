import 'package:flutter/material.dart';
import 'package:nft_marketplace/buyer_module/provider/more_page_provider.dart';
import 'package:nft_marketplace/buyer_module/provider/sign_in_provider.dart';
import 'package:nft_marketplace/wallet/wallet_page.dart';
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
  Future<void> getProvider() async {
    final mp = Provider.of<MorePageProvider>(context);
    await mp.getData();
  }

  @override
  void initState() {
    super.initState();
    getProvider();
  }

  @override
  Widget build(BuildContext context) {
    final mp = context.read<MorePageProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "More",
        ),
        forceMaterialTransparency: true,
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
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const WalletPageWidget()));
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
        ],
      ),
    );
  }

  Future<void> handelSignOut() async {
    final sp = context.read<SignInProvider>();
    sp.signOutGoogle().then((value) => SessionManager.logOutSession());
  }
}
