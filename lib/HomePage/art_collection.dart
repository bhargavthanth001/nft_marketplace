import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nft_marketplace/Createpage/collection_pages/collection_details_page.dart';
import 'package:nft_marketplace/data%20manager/database_handler.dart';

class ArtCollectionWidget extends StatelessWidget {
  const ArtCollectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        var width = constraint.maxWidth;
        var cellWidth = (width - 10) / 3;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Gap(5),
                Text(
                  "Art",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ],
            ),
            const Gap(8),
            SizedBox(
              height: 335,
              child: StreamBuilder(
                stream: DataBase.getCategorizedCollections("Art"),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final resultData = snapshot.data;
                    if (resultData!.isNotEmpty) {
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: resultData.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        CollectionDetailsPageWidget(
                                      collectionModel: resultData[index],
                                    ),
                                  ),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl: resultData[index].thumbnail,
                                      height: 300,
                                      width: cellWidth * 2.1,
                                      placeholder: (context, url) =>
                                          Image.asset(
                                        "assets/images/logo.jpg",
                                        height: cellWidth,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const Gap(5),
                                  Row(
                                    children: [
                                      Container(
                                        height: 25,
                                        width: 25,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        clipBehavior: Clip.antiAlias,
                                        child: CachedNetworkImage(
                                          imageUrl: resultData[index].thumbnail,
                                          placeholder: (context, url) =>
                                              Image.asset(
                                            "assets/images/logo.jpg",
                                            height: cellWidth,
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      const Gap(3),
                                      Text(
                                        resultData[index].name,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            );
                          });
                    } else {
                      return const SizedBox();
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
