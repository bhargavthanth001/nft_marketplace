// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nft_marketplace/buyer_module/provider/internet_provider.dart';
import 'package:nft_marketplace/buyer_module/provider/more_page_provider.dart';
import 'package:nft_marketplace/buyer_module/provider/sign_in_provider.dart';
import 'package:nft_marketplace/colors.dart';
import 'package:nft_marketplace/splash_screen.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SignInProvider()),
        ChangeNotifierProvider(create: (context) => InternetProvider()),
        ChangeNotifierProvider(create: (context) => MorePageProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.blue,
              centerTitle: true,
            ),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: ColorsData.selectiveYellow,
            ),
          ),
          home: const SplashScreen()),
    );
  }
}
