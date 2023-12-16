import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:gap/gap.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          const Gap(70),
          Container(
            margin: const EdgeInsets.only(left: 15),
            child: const CircleAvatar(
              radius: 60,
              backgroundColor: Colors.blue,
            ),
          ),
          const Gap(15),
          const Text(
            "UserName",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          )
        ],
      ),
    );
  }
}
