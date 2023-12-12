import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animated_button_bar/animated_button_bar.dart';
import 'package:gap/gap.dart';
import 'package:nft_marketplace/HomePage/promotions.dart';
import 'package:nft_marketplace/HomePage/top.dart';
import 'package:nft_marketplace/HomePage/trending.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool trend = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "NFT MarketPlace",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ButtonBar(
              alignment: MainAxisAlignment.start,
              children: [
                MaterialButton(
                  height: 30,
                  padding: const EdgeInsets.all(10),
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onPressed: () {},
                  child: const Text("All"),
                ),
                MaterialButton(
                  height: 30,
                  padding: const EdgeInsets.all(10),
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onPressed: () {},
                  child: const Text("Art"),
                ),
                MaterialButton(
                  height: 30,
                  padding: const EdgeInsets.all(10),
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onPressed: () {},
                  child: const Text("Gaming"),
                ),
                MaterialButton(
                  height: 30,
                  padding: const EdgeInsets.all(10),
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onPressed: () {},
                  child: const Text("Music"),
                ),
              ],
            ),
            PromotionWidget(),
            const Gap(10),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                height: 50,
                width: 200,
                margin: const EdgeInsets.only(left: 20),
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.shade200,
                ),
                child: AnimatedButtonBar(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.grey.shade200,
                  radius: 12,
                  children: [
                    ButtonBarEntry(
                      onTap: () {
                        trend = true;
                        setState(() {});
                      },
                      child: const Text(
                        'Trending',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    ButtonBarEntry(
                      onTap: () {
                        trend = false;
                        setState(() {});
                      },
                      child: const Text(
                        'Top',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            trend ? TrendingWidget() : TopWidget(),
          ],
        ),
      ),
    );
  }
}
