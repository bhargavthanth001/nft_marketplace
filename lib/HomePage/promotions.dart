import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PromotionWidget extends StatelessWidget {
  PromotionWidget({Key? key}) : super(key: key);

  final List<String> images = [
    "https://img.freepik.com/free-vector/hand-drawn-nft-style-ape-illustration_23-2149622021.jpg",
    "https://img.freepik.com/free-vector/hand-drawn-nft-style-ape-illustration_23-2149611030.jpg?size=626&ext=jpg&ga=GA1.1.1289019487.1670938516&semt=ais",
    "https://img.freepik.com/free-vector/hand-drawn-nft-style-ape-illustration_23-2149622052.jpg?size=626&ext=jpg&ga=GA1.1.1289019487.1670938516&semt=ais",
    "https://img.freepik.com/free-vector/hand-drawn-nft-style-ape-illustration_23-2149619499.jpg?size=626&ext=jpg&ga=GA1.1.1289019487.1670938516&semt=ais",
    "https://img.freepik.com/free-vector/hand-drawn-nft-style-ape-illustration_23-2149619508.jpg?size=626&ext=jpg&ga=GA1.1.1289019487.1670938516&semt=ais",
  ];

  final List<String> titles = [
    "First NFT Marketplace",
    "Second NFT Marketplace",
    "Third NFT Marketplace",
    "Fourth NFT Marketplace",
    "Fifth NFT Marketplace",
  ];

  final List<String> prices = [
    "2.3",
    "4.5",
    "4.6",
    "2.0",
    "6.54",
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrain) {
        final width = constrain.maxWidth;
        return Row(
          children: [
            Column(
              children: [
                Container(
                  height: width / 2,
                  width: (width - 4) / 2,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(
                      "https://img.freepik.com/free-vector/hand-drawn-nft-style-ape-illustration_23-2149622021.jpg"),
                ),
                const Text("Promotion 1...")
              ],
            ),
            const Gap(4),
            Column(
              children: [
                Container(
                  // height: width / 2,
                  width: (width - 4) / 2,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(
                    "https://img.freepik.com/free-vector/hand-drawn-nft-style-ape-illustration_23-2149622021.jpg",
                  ),
                ),
                const Text("Promotion 2...")
              ],
            ),
          ],
        );
      },
    );
  }
}
