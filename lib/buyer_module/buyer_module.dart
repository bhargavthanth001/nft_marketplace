import 'package:flutter/material.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'package:motion_tab_bar_v2/motion-tab-controller.dart';
import 'package:nft_marketplace/buyer_module/create_page.dart';
import 'package:nft_marketplace/buyer_module/profile.dart';
import 'package:nft_marketplace/buyer_module/search.dart';
import 'package:nft_marketplace/colors.dart';

import 'HomePage/home_page.dart';
import 'more.dart';

class BuyerModule extends StatefulWidget {
  const BuyerModule({Key? key}) : super(key: key);

  @override
  State<BuyerModule> createState() => _BuyerModuleState();
}

class _BuyerModuleState extends State<BuyerModule>
    with TickerProviderStateMixin {
  int selectedIndex = 0;
  List<Widget> widgets = [
    const HomePage(),
    const SearchPage(),
    const CreatePageWidget(),
    const ProfilePage(),
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
        // ADD THIS if you need to change your tab programmatically
        initialSelectedTab: "Home",
        useSafeArea: true,
        // default: true, apply safe area wrapper
        labels: const ["Home", "Search", "Create", "Profile", "More"],
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
        icons: const [
          Icons.home,
          Icons.search,
          Icons.add,
          Icons.person,
          Icons.settings
        ],
        // tabIconColor: Colors.blue[600],
        tabIconSize: 25,
        tabIconSelectedSize: 20,
        tabSize: 35,
        tabBarHeight: 50,
        tabSelectedColor: ColorsData.selectiveYellow,
        tabIconSelectedColor: ColorsData.black,
        onTabItemSelected: (int value) {
          setState(() {
            selectedIndex = value;
          });
        },
      ),
    );
  }
}
