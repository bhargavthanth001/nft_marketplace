// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nft_marketplace/provider/collection_provider.dart';
import 'package:nft_marketplace/provider/dropdown_provider.dart';
import 'package:nft_marketplace/provider/internet_provider.dart';
import 'package:nft_marketplace/provider/meta_mask_provider.dart';
import 'package:nft_marketplace/provider/more_page_provider.dart';
import 'package:nft_marketplace/provider/refresh_screen_provider.dart';
import 'package:nft_marketplace/provider/sign_in_provider.dart';
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
        ChangeNotifierProvider(create: (context) => CollectionProvider()),
        ChangeNotifierProvider(create: (context) => DropDownProvider()),
        ChangeNotifierProvider(create: (context) => MetaMaskProvider()),
        ChangeNotifierProvider(create: (context) => RefreshScreenProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
                centerTitle: true,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                )),
          ),
          home: const SplashScreen()),
    );
  }
}
