import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nft_marketplace/live_page_details/category_detail_page.dart';

class SearchCategoryWidget extends StatelessWidget {
  const SearchCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    container(Color color, String title) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LiveCategoryDetailPageWidget(
                category: title,
              ),
            ),
          );
        },
        child: Container(
          height: 70,
          width: (width - 26) / 2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: color,
          ),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 18),
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              container(Colors.green, "Art"),
              const Gap(10),
              container(Colors.brown, "Photography"),
              const Gap(10),
              container(Colors.red, "Game")
            ],
          ),
          const Gap(10),
          Column(
            children: [
              container(Colors.deepPurple, "Music"),
              const Gap(10),
              container(Colors.blue, "Drawing"),
              const Gap(10),
              container(Colors.lime, "Entertainment")
            ],
          ),
        ],
      ),
    );
  }
}
