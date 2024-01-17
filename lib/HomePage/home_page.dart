import 'package:animated_button_bar/animated_button_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nft_marketplace/HomePage/promotions.dart';
import 'package:nft_marketplace/HomePage/top.dart';
import 'package:nft_marketplace/HomePage/trending.dart';
import 'package:nft_marketplace/colors.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool trend = true;

  @override
  void initState() {
    super.initState();
    // getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "NFT MarketPlace",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: ColorsData.selectiveYellow,
        forceMaterialTransparency: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Gap(10),
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
                trend ? const TrendingWidget() : const TopWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
