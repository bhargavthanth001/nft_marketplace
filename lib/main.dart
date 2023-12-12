import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nft_marketplace/nav_bar.dart';

import 'HomePage/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.blue,
              ),
              centerTitle: true)),
      home: const NavBar(),
    );
  }
}
