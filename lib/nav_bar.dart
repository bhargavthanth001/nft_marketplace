import 'package:flutter/material.dart';
import 'package:nft_marketplace/HomePage/home_page.dart';
import 'package:nft_marketplace/more.dart';
import 'package:nft_marketplace/profile.dart';
import 'package:nft_marketplace/search.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'package:motion_tab_bar_v2/motion-tab-controller.dart';
import 'package:motion_tab_bar_v2/motion-badge.widget.dart';
import 'package:motion_tab_bar_v2/motion-tab-item.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> with TickerProviderStateMixin {
  int selectedIndex = 0;
  List<Widget> widgets = [
    const HomePage(),
    const SearchPage(),
    const ProfilePage(),
    const MorePage(),
  ];

  MotionTabBarController? _motionTabBarController;

  @override
  void initState() {
    super.initState();

    _motionTabBarController = MotionTabBarController(
      initialIndex: 1,
      length: 4,
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
        labels: const ["Home", "Search", "Profile", "More"],
        icons: const [Icons.home, Icons.search, Icons.person, Icons.settings],
        tabIconColor: Colors.blue[600],
        tabIconSize: 28.0,
        tabIconSelectedSize: 26.0,
        tabSelectedColor: Colors.blue,
        tabIconSelectedColor: Colors.white,
        onTabItemSelected: (int value) {
          setState(() {
            selectedIndex = value;
          });
        },
        // bottomNavigationBar: BottomNavigationBar(
        //   selectedItemColor: Colors.blue,
        //   unselectedItemColor: Colors.grey,
        //   showUnselectedLabels: true,
        //   selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        //   items: const <BottomNavigationBarItem>[
        //     BottomNavigationBarItem(
        //       icon: Icon(
        //         Icons.home,
        //       ),
        //       label: "Home",
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(
        //         Icons.search,
        //       ),
        //       label: "Search",
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(
        //         Icons.person_outline_sharp,
        //       ),
        //       label: "Profile",
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(
        //         Icons.more_horiz_outlined,
        //       ),
        //       label: "More",
        //     ),
        //   ],
        //   onTap: (int index) {
        //     setState(() {
        //       selectedIndex = index;
        //     });
        //   },
        //   currentIndex: selectedIndex,
        // ),
      ),
    );
  }
}
