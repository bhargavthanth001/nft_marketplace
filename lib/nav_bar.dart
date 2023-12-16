import 'package:flutter/material.dart';
import 'package:nft_marketplace/HomePage/home_page.dart';
import 'package:nft_marketplace/more.dart';
import 'package:nft_marketplace/profile.dart';
import 'package:nft_marketplace/search.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int selectedIndex = 0;
  List<Widget> widgets = [
    const HomePage(),
    const SearchPage(),
    const ProfilePage(),
    const MorePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgets[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
            ),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline_sharp,
            ),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.more_horiz_outlined,
            ),
            label: "More",
          ),
        ],
        onTap: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },
        currentIndex: selectedIndex,
      ),
    );
  }
}
