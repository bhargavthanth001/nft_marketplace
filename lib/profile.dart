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
      // body: Center(
      //   child: FutureBuilder<UserModel>(
      //       future: DataBase.getSingleUser(),
      //       builder: (context, snapshot) {
      //         if (snapshot.hasError) {
      //           return Center(
      //             child: Text(
      //               "No Data Found",
      //               style: TextStyle(
      //                 color: Colors.red.shade400,
      //                 fontWeight: FontWeight.bold,
      //                 fontSize: 25,
      //               ),
      //             ),
      //           );
      //         } else {
      //           if (snapshot.hasData) {
      //             final resultData = snapshot.data;
      //             if (resultData == null) {
      //               debugPrint("No Data Found");
      //               debugPrint(snapshot.error.toString());
      //               return const SizedBox();
      //             } else {
      //               return Column(
      //                 children: [
      //                   const Gap(70),
      //                   Image.asset(
      //                     "assets/images/profile.png",
      //                     height: 120,
      //                     width: 120,
      //                   ),
      //                   const Gap(15),
      //                   Text(
      //                     resultData.name!,
      //                     style: const TextStyle(
      //                       fontWeight: FontWeight.bold,
      //                       fontSize: 20,
      //                     ),
      //                   ),
      //                   const Gap(5),
      //                   Text(
      //                     resultData.id!,
      //                     style: const TextStyle(
      //                       fontSize: 10,
      //                     ),
      //                   ),
      //                   const Gap(20),
      //                 ],
      //               );
      //             }
      //           } else {
      //             debugPrint("No Data Found 2");
      //             debugPrint(snapshot.error.toString());
      //             return const SizedBox();
      //           }
      //         }
      //       }),
      // ),
    );
  }
}
