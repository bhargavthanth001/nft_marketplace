import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:gap/gap.dart';
import 'package:nft_marketplace/data%20manager/database_handler.dart';
import 'package:nft_marketplace/model/user_model.dart';

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
      body: Center(
        child: StreamBuilder<UserModel>(
            stream: DataBase.getSingleUser(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final resultData = snapshot.data!;
                return Column(
                  children: [
                    const Gap(70),
                    Image.asset(
                      "assets/images/profile.png",
                      height: 120,
                      width: 120,
                    ),
                    const Gap(15),
                    Text(
                      resultData.name!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const Gap(5),
                    Text(
                      resultData.id!,
                      style: const TextStyle(
                        fontSize: 10,
                      ),
                    ),
                    const Gap(20),
                  ],
                );
              } else {
                return const SizedBox();
              }
            }),
      ),
    );
  }
}
