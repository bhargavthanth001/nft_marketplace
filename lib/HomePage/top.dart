import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TopWidget extends StatelessWidget {
  TopWidget({Key? key}) : super(key: key);

  final List<String> ranks = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
  ];
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      var width = constraint.maxWidth;
      var cellWidth = (width - 40);
      debugPrint(cellWidth.toString());
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              height: 300,
              child: Wrap(
                direction: Axis.vertical,
                children: List.generate(ranks.length, (index) {
                  return Container(
                    height: 60,
                    width: 300,
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Gap(5),
                        Text(
                          ranks[index],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        const Gap(8),
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.red,
                          ),
                        ),
                        const Gap(
                          5,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Hello ${ranks[index]}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              "Floor : ",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        const Text("\$ 2.5"),
                        IconButton(
                          icon: const Icon(Icons.more_vert),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ),
          const Gap(
            15,
          )
        ],
      );
    });
  }
}
