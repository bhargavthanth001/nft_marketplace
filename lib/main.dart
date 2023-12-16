import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nft_marketplace/authentication%20pages/intro_page.dart';
import 'package:nft_marketplace/provider/sign_in_provider.dart';
import 'package:nft_marketplace/splash_screen.dart';
import 'package:provider/provider.dart';

// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:nft_marketplace/authentication%20pages/registration_page.dart';
import 'package:nft_marketplace/on_boarding_screen.dart';

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
        ChangeNotifierProvider(create: (context) => SignInProvider())
      ],
      child: MaterialApp(
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
        home: const SplashScreen(),
      ),
    );
  }
}
