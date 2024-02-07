import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nft_marketplace/HomePage/art_collection.dart';
import 'package:nft_marketplace/HomePage/category_side/category_page.dart';
import 'package:nft_marketplace/HomePage/drawing_collection.dart';
import 'package:nft_marketplace/HomePage/entertainment_colection.dart';
import 'package:nft_marketplace/HomePage/game_collection.dart';
import 'package:nft_marketplace/HomePage/music_collection.dart';
import 'package:nft_marketplace/HomePage/photography_collection.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool trend = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "NFT MarketPlace",
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const Gap(10),
                // PromotionWidget(),
                const Gap(10),
                CategoryWidget(),
                const Gap(10),
                const GameCollectionWidget(),
                const Gap(10),
                const EntertainmentCollectionWidget(),
                const Gap(10),
                const ArtCollectionWidget(),
                const Gap(10),
                const MusicCollectionWidget(),
                const Gap(10),
                const DrawingCollectionWidget(),
                const Gap(10),
                const PhotographyCollectionWidget(),
                const Gap(15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
