import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../data manager/database_handler.dart';

class TopWidget extends StatelessWidget {
  const TopWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: DataBase.getAllCollections(),
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            final result = snapShot.data;
            if (result != null) {
              return Wrap(
                children: List.generate(result.length, (index) {
                  return Container(
                    height: 60,
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Gap(5),
                        Text(
                          (index + 1).toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        const Gap(8),
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: ClipRRect(
                            clipBehavior: Clip.antiAlias,
                            borderRadius: BorderRadius.circular(5),
                            child: CachedNetworkImage(
                              imageUrl: result[index].thumbnail!,
                              fit: BoxFit.cover,
                              placeholder: (context, text) =>
                                  Image.asset("assets/images/logo.jpg"),
                            ),
                          ),
                        ),
                        const Gap(
                          5,
                        ),
                        Text(
                          result[index].name!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.more_vert),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  );
                }),
              );
            } else {
              return const Center(
                child: Text("No Data Found"),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
