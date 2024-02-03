import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nft_marketplace/Createpage/collection_pages/collection_details_page.dart';
import 'package:nft_marketplace/data%20manager/database_handler.dart';

class EntertainmentCollectionWidget extends StatelessWidget {
  const EntertainmentCollectionWidget({super.key});

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
              "Entertainment",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const Gap(8),
            SizedBox(
              height: 138,
              child: StreamBuilder(
                stream: DataBase.getCategorizedCollections("Entertainment"),
                builder: (context, snapshot) {
                  final resultData = snapshot.data;
                  if (snapshot.hasData) {
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
                              child: Container(
                                margin: const EdgeInsets.only(right: 8),
                                width: cellWidth,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl: resultData[index].thumbnail,
                                        height: cellWidth,
                                        width: cellWidth,
                                        placeholder: (context, url) =>
                                            Image.asset(
                                          "assets/images/logo.jpg",
                                          height: cellWidth,
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                      width: cellWidth,
                                      child: Text(
                                        resultData[index].name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
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
