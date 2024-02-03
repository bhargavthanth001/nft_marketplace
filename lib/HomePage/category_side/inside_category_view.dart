import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nft_marketplace/data%20manager/database_handler.dart';

import '../../Createpage/collection_pages/collection_details_page.dart';

class InsideCategoryView extends StatelessWidget {
  final String category;

  const InsideCategoryView({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: StreamBuilder(
        stream: DataBase.getCategorizedCollections(category),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final result = snapshot.data;
            // ignore: unrelated_type_equality_checks
            if (AsyncSnapshot.waiting == true) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (result!.isNotEmpty) {
                return GridView.count(
                  crossAxisCount: 2,
                  padding: const EdgeInsets.only(right: 8),
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
                                ),
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                CachedNetworkImage(
                                  imageUrl: result[index].thumbnail,
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
                                    result[index].name,
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
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.collections_sharp,
                        color: Colors.black,
                      ),
                      Gap(5),
                      Text(
                        "No collection found",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                );
                ;
              }
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
