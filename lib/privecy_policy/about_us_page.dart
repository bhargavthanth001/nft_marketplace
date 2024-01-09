import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nft_marketplace/privecy_policy/privecy_policy_page.dart';

class AboutUsPageWidget extends StatelessWidget {
  const AboutUsPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Us"),
        forceMaterialTransparency: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Image.asset(
              "assets/images/about_us.jpg",
              height: 200,
              width: 300,
            ),
            const Gap(10),
            const Text(
              "We're building an open \ndigital economy",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const Gap(8),
            const Text(
              '''At NFT Marketplace, we're excited about a brand new type of digital good called a non-fungible token, or NFT. NFTs have exciting new properties: they’re unique, provably scarce, tradeable, and usable across multiple applications. Just like physical goodsFA, you can do whatever you want with them! You could throw them in the trash, gift them to a friend across the world, or go sell them on an open marketplace. But unlike physical goods, they're armed with all the programmability of digital goods. A core part of our vision is that open protocols like Ethereum and interoperable standards like ERC-721 and ERC-1155 will enable vibrant new economies. We're building tools that allow consumers to trade their items freely, creators to launch new digital works, and developers to build rich, integrated marketplaces for their digital items. We're proud to be the first and largest marketplace for NFTs.''',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 15,
              ),
            ),
            const Gap(10),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PrivacyPolicyPageWidget()));
              },
              child: const Text(
                "Privacy Policy",
                style: TextStyle(
                  color: Colors.blueAccent,
                ),
              ),
            ),
            const Gap(15),
          ],
        ),
      ),
    );
  }
}
