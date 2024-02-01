import 'package:blur/blur.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nft_marketplace/data%20manager/database_handler.dart';

class PhotographyCollectionWidget extends StatelessWidget {
  const PhotographyCollectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      var width = constraint.maxWidth;
      var height = constraint.maxHeight;
      var cellWidth = (width - 10) / 3;
      var cellHeight = (height - 10) / 3;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Photography",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 162,
            child: StreamBuilder(
                stream: DataBase.getCategorizedCollections("Photography"),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final resultData = snapshot.data;
                    if (resultData!.isNotEmpty) {
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: resultData.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(right: 8),
                              width: cellWidth * 2.5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: SizedBox(
                                      height: cellWidth,
                                      width: cellWidth * 2.5,
                                      child: CachedNetworkImage(
                                        imageUrl: resultData[index].thumbnail,
                                        placeholder: (context, url) =>
                                            Image.asset(
                                          "assets/images/logo.jpg",
                                          height: cellWidth,
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                        fit: BoxFit.cover,
                                      ),
                                    ).blurred(
                                        blur: 10,
                                        blurColor: Colors.black54,
                                        overlay: Container(
                                          padding: const EdgeInsets.all(10),
                                          child: Row(children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              clipBehavior: Clip.antiAlias,
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    resultData[index].thumbnail,
                                                height: 100,
                                                width: 100,
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) =>
                                                    Image.asset(
                                                  "assets/images/logo.jpg",
                                                  height: cellWidth,
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  bottom: 15),
                                              width: cellWidth,
                                              child: Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Text(
                                                  resultData[index].name,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: false,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ]),
                                        )),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    // width: cellWidth,
                                    child: Text(
                                      resultData[index].name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    // width: cellWidth,
                                    child: Text(
                                      resultData[index].description,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ),
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
                }),
          ),
        ],
      );
    });
  }
}
