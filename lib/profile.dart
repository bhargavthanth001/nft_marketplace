import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:gap/gap.dart';
import 'package:nft_marketplace/data_variables.dart';
import 'package:nft_marketplace/profile_page_details/collected_nfts_page.dart';

import 'data manager/database_handler.dart';
import 'model/user_model.dart';
import 'utils/colors.dart';

class ProfilePage extends StatelessWidget {
  final String userId;

  ProfilePage({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint("User id => $userId");
    debugPrint("current user => ${user.uid}");
    final myTabs = [
      CollectedNFTsPageWidget(id: userId),
      const Center(child: Text("Favorite tab")),
    ];
    if (userId != user.uid) {
      myTabs.add(
        const Center(
          child: Text("Favorite tab"),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
        ),
        forceMaterialTransparency: true,
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
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/images/profile.png",
                              height: 120,
                              width: 120,
                            ),
                            Text(
                              resultData.username!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(5),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        child: ContainedTabBarView(
                          tabBarProperties: const TabBarProperties(
                            height: 40,
                            width: double.infinity,
                            indicatorColor: ColorsData.black,
                            labelColor: ColorsData.black,
                            padding: EdgeInsets.zero,
                          ),
                          tabs: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.grid_view_outlined),
                                Gap(12),
                                Text('Collected'),
                                Gap(8),
                                Text('0'),
                              ],
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.favorite_border),
                                Gap(12),
                                Text('Favorite'),
                                Gap(8),
                                Text('0'),
                              ],
                            ),
                            if (userId != user.uid)
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
