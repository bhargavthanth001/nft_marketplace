import 'package:awesome_icons/awesome_icons.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nft_marketplace/buyer_module/upload_nft/add_collection.dart';
import 'package:nft_marketplace/colors.dart';

class CreatePageWidget extends StatefulWidget {
  const CreatePageWidget({super.key});

  @override
  State<CreatePageWidget> createState() => _CreatePageWidgetState();
}

class _CreatePageWidgetState extends State<CreatePageWidget> {
  _widget(IconData icon, String text) {
    return SizedBox(
      height: 100,
      width: 100,
      child: DottedBorder(
        color: ColorsData.selectiveYellow,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 25,
              ),
              const Gap(8),
              Text(
                text,
                style: const TextStyle(fontSize: 18),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final provider = context.read<PickerProvider>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Upload your own ",
              style: TextStyle(),
            ),
            Gap(1),
            Text(
              "NFTs",
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddCollectionPageWidget(),
                  ),
                );
              },
              child: _widget(FontAwesomeIcons.plus, "Collection"),
            ),
          ],
        ),
      ),
    );
  }
}
