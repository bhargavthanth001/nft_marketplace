import 'package:flutter/material.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'package:motion_tab_bar_v2/motion-tab-controller.dart';
import 'package:nft_marketplace/create_page.dart';
import 'package:nft_marketplace/data_variables.dart';
import 'package:nft_marketplace/profile.dart';
import 'package:nft_marketplace/search.dart';

import 'home_page.dart';
import 'more.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>
    with TickerProviderStateMixin {
  int selectedIndex = 0;
  List<Widget> widgets = [
    HomePage(),
    SearchPage(),
    const CreatePageWidget(),
    ProfilePage(
      userId: user.uid,
    ),
    const MorePage(),
  ];

  MotionTabBarController? _motionTabBarController;

  @override
  void initState() {
    super.initState();

    _motionTabBarController = MotionTabBarController(
      initialIndex: 1,
      length: 5,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _motionTabBarController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgets[selectedIndex],
      bottomNavigationBar: MotionTabBar(
        controller: _motionTabBarController,
        initialSelectedTab: "Home",
        useSafeArea: true,
        labels: const ["Home", "Search", "Create", "Profile", "More"],
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
        icons: const [
          Icons.home,
          Icons.search,
          Icons.add,
          Icons.person,
          Icons.settings
        ],
        tabIconSize: 25,
        tabIconSelectedSize: 20,
        tabSize: 35,
        tabBarHeight: 50,
        tabSelectedColor: Colors.blue,
        tabIconSelectedColor: Colors.white,
        onTabItemSelected: (int value) {
          setState(
            () {
              selectedIndex = value;
            },
          );
        },
      ),
    );
  }
}
