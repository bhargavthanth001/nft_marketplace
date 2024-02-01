import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CategoryWidget extends StatelessWidget {
  CategoryWidget({super.key});

  final List<String> imageList = [
    "assets/vectors/art.png",
    "assets/vectors/drawing.jpg",
    "assets/vectors/entertainment.jpg",
    "assets/vectors/game.jpg",
    "assets/vectors/music.jpg",
    "assets/vectors/photography.jpg",
  ];
  final List<String> titles = [
    "Art",
    "Drawing",
    "Entertainment",
    "Game",
    "Music",
    "Photography",
  ];

  final List<MaterialColor> colors = [
    Colors.green,
    Colors.deepPurple,
    Colors.lime,
    Colors.red,
    Colors.blue,
    Colors.brown
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        var width = constraint.maxWidth;
        var cellWidth = (width - 10) / 3;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Category",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 167,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 8),
                    child: Container(
                      height: cellWidth * 2 / 1.5,
                      width: cellWidth * 2 / 1.5,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: colors[index],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              imageList[index],
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const Gap(10),
                          Text(
                            titles[index],
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
