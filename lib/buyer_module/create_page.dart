import 'package:awesome_icons/awesome_icons.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nft_marketplace/colors.dart';

class CreatePageWidget extends StatelessWidget {
  const CreatePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Create your NFT",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              "Create your NFTs",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            SizedBox(
              height: 200,
              width: 200,
              child: DottedBorder(
                strokeWidth: 1.5,
                color: ColorsData.selectiveYellow,
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(FontAwesomeIcons.image),
                      Gap(5),
                      Text("Create Single"),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 200,
              width: 200,
              child: DottedBorder(
                strokeWidth: 1.5,
                color: ColorsData.selectiveYellow,
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(FontAwesomeIcons.images),
                      Gap(5),
                      Text("Create Multiple"),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
