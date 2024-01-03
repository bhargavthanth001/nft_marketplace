import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nft_marketplace/Createpage/collection_pages/collection_details_page.dart';
import 'package:nft_marketplace/colors.dart';

import '../../data manager/database_handler.dart';

class CollectionTab extends StatelessWidget {
  const CollectionTab({super.key});

  _widget() {
    return const Center(
      child: Column(
        children: [
          Icon(
            Icons.collections_sharp,
            color: ColorsData.cardinal,
          ),
          Gap(5),
          Text(
            "No collection found",
            style: TextStyle(
              color: ColorsData.cardinal,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: DataBase.getCollections(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final result = snapshot.data;
              // ignore: unrelated_type_equality_checks
              if (AsyncSnapshot.waiting == true) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (result != null) {
                  return GridView.count(
                    crossAxisCount: 2,
                    padding: const EdgeInsets.only(top: 10, right: 8),
                    childAspectRatio: 1,
                    children: List.generate(
                      result.length,
                      (index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 8, top: 8),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CollectionDetailsPageWidget(
                                            collectionModel: result[index],
                                          )));
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: result[index].thumbnail!,
                                    fit: BoxFit.cover,
                                    placeholder: (context, text) =>
                                        Image.asset("assets/images/logo.jpg"),
                                  ),
                                  Positioned(
                                    bottom: -50,
                                    child: Image.asset(
                                      "assets/images/shadow.png",
                                      width: 170,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    left: 5,
                                    bottom: 15,
                                    child: Text(
                                      result[index].name!,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return _widget();
                }
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
