import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:gap/gap.dart';
import 'package:nft_marketplace/data_variables.dart';
import 'package:nft_marketplace/profile_page_details/collected_nfts_page.dart';

import 'data manager/database_handler.dart';
import 'model/user_model.dart';

class ProfilePage extends StatelessWidget {
  final String userId;

  ProfilePage({Key? key, required this.userId}) : super(key: key);

  _container(String count, String title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          count,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        const Gap(5),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final myTabs = <Widget>[
      CollectedNFTsPageWidget(id: userId),
      const Center(
        child: Text("Created"),
      ),
    ];
    debugPrint("User id => $userId");
    debugPrint("current user => ${user.uid}");
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
        ),
      ),
      body: FutureBuilder<UserModel>(
        future: DataBase.getUser(userId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            debugPrint(snapshot.error.toString());
            return Center(
              child: Text(
                "No Data Found",
                style: TextStyle(
                  color: Colors.red.shade400,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            );
          } else {
            if (snapshot.hasData) {
              final resultData = snapshot.data;
              if (resultData == null) {
                debugPrint("No Data Found");
                return const SizedBox();
              } else {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Gap(70),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Image.asset(
                                  "assets/images/profile.png",
                                  height: 70,
                                  width: 70,
                                ),
                                Text(
                                  resultData.username!,
                                  style: const TextStyle(
                                    // fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            const Gap(20),
                            SizedBox(
                              width: 230,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  userId == user.uid
                                      ? _container(
                                          "${resultData.collected!.length}",
                                          "collected")
                                      : const SizedBox(),
                                  _container("0", "followers"),
                                  _container("0", "following")
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(5),
                    userId == user.uid
                        ? Expanded(child: CollectedNFTsPageWidget(id: userId))
                        : Expanded(
                            child: Container(
                              margin:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: ContainedTabBarView(
                                tabBarProperties: const TabBarProperties(
                                  height: 40,
                                  width: double.infinity,
                                  indicatorColor: Colors.black,
                                  labelColor: Colors.black,
                                  padding: EdgeInsets.zero,
                                ),
                                tabs: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.grid_view_outlined),
                                      const Gap(12),
                                      const Text('Collected'),
                                      const Gap(8),
                                      Text("${resultData.collected!.length}"),
                                    ],
                                  ),
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.format_paint),
                                      Gap(12),
                                      Text('Created'),
                                      Gap(8),
                                      Text('0'),
                                    ],
                                  ),
                                ],
                                views: myTabs,
                                onChange: (index) => {},
                              ),
                            ),
                          ),
                  ],
                );
              }
            } else {
              debugPrint("No Data Found 2");
              debugPrint(snapshot.error.toString());
              return const SizedBox();
            }
          }
        },
      ),
    );
  }
}
