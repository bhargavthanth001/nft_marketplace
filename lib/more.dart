import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nft_marketplace/data%20manager/database_handler.dart';
import 'package:nft_marketplace/data%20manager/session_manager.dart';
import 'package:provider/provider.dart';
import 'package:gap/gap.dart';
import 'authentication pages/login_page.dart';
import 'provider/sign_in_provider.dart';

class MorePage extends StatefulWidget {
  const MorePage({Key? key}) : super(key: key);

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  @override
  Widget build(BuildContext context) {
    final sp = context.read<SignInProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "More",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              handelSignOut().then((value) => Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(
                      builder: (context) => const LoginPageWidget())));
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
              // DataBase.becomeSeller();
            },
            child: ListTile(
              title: Text(
                "Become a seller",
                style: TextStyle(
                  color: Colors.green.shade800,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Icon(
                Icons.person,
                color: Colors.green.shade800,
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
