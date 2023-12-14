import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nft_marketplace/nav_bar.dart';
import 'HomePage/home_page.dart';

// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyARdra6g61zejEeGE-g1bsoLhfS2uUGvOo",
      appId: "1:463517057371:android:7ee66e36e8ae01ce80da7e",
      messagingSenderId: "463517057371",
      projectId: "nft-marketplace-d4250",
    ),
  );

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
          backgroundColor: Colors.blue,
          centerTitle: true,
        ),
      ),
      home: const NavBar(),
    );
  }
}
