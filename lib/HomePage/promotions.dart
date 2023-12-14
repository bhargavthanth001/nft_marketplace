import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

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
    return SizedBox(
      height: 250,
      child: Swiper(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: NetworkImage(images[index]),
                fit: BoxFit.cover,
              ),
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                height: 65,
                width: double.infinity,
                padding: const EdgeInsets.only(left: 15, top: 3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titles[index].toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                    // const SizedBox(
                    //   height: 5,
                    // ),
                    Text(
                      "\$ ${prices[index]}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        duration: 1200,
        viewportFraction: 1,
        autoplay: true,
        transformer: ScaleAndFadeTransformer(
          fade: 1,
        ),
      ),
    );
  }
}
