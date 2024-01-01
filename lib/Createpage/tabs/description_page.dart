import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nft_marketplace/colors.dart';

class NftDescriptionPageWidget extends StatelessWidget {
  NftDescriptionPageWidget({super.key});

  final title = TextEditingController();
  final description = TextEditingController();
  final category = TextEditingController();
  final price = TextEditingController();
  final email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "NFT Details ",
          style: TextStyle(),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  controller: title,
                  maxLines: 1,
                  decoration: const InputDecoration(
                    hintText: "Enter the title",
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: ColorsData.black,
                      ),
                    ),
                  ),
                ),
                const Gap(15),
                TextFormField(
                  controller: description,
                  maxLines: 1,
                  decoration: const InputDecoration(
                    hintText: "Enter the description",
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: ColorsData.black,
                      ),
                    ),
                  ),
                ),
                const Gap(15),
                TextFormField(
                  controller: category,
                  maxLines: 1,
                  decoration: const InputDecoration(
                    hintText: "Enter the category",
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: ColorsData.black,
                      ),
                    ),
                  ),
                ),
                const Gap(15),
                TextFormField(
                  controller: price,
                  maxLines: 1,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: "Enter the price in USD",
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: ColorsData.black,
                      ),
                    ),
                  ),
                ),
                const Gap(15),
                TextFormField(
                  controller: email,
                  maxLines: 1,
                  decoration: const InputDecoration(
                    hintText: "Enter the email for receipt",
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: ColorsData.black,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: MaterialButton(
                      color: ColorsData.selectiveYellow,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    NftDescriptionPageWidget()));
                      },
                      child: const Text("Next"),
                    ),
                  ),
                ),
                const Gap(5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
