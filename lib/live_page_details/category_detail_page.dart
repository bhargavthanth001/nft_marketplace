import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../Createpage/collection_pages/view_nft.dart';
import '../data manager/database_handler.dart';

class LiveCategoryDetailPageWidget extends StatelessWidget {
  final String category;

  const LiveCategoryDetailPageWidget({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: StreamBuilder(
        stream: DataBase.getOnSellNFTs(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final resultData = snapshot.data;
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const SizedBox();
              case ConnectionState.done:
                return const SizedBox();
              case ConnectionState.waiting:
                return const SizedBox();
              case ConnectionState.active:
                if (resultData != null && resultData.isNotEmpty) {
                  return GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: 0.62,
                    padding: const EdgeInsets.only(top: 10, right: 8),
                    children: List.generate(
                      resultData.length,
                      (index) {
                        return Container(
                          margin: const EdgeInsets.only(left: 8, top: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(0, 0),
                                color: Colors.black12,
                                blurRadius: 5,
                              )
                            ],
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ViewNftPageWidget(
                                    nftModel: resultData[index],
                                  ),
                                ),
                              );
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: resultData[index].imageUrl!,
                                        height: 200,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        placeholder: (context, text) =>
                                            Image.asset(
                                          "assets/images/app_logo.png",
                                          height: 140,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 5,
                                      right: 5,
                                      child: Image.asset(
                                        "assets/images/on_sell.gif",
                                        height: 18,
                                        width: 18,
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        width: 110,
                                        child: Text(
                                          resultData[index].title!,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: 5, right: 5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                          color: Colors.white,
                                          boxShadow: const [
                                            BoxShadow(
                                              offset: Offset(0, 0),
                                              color: Colors.black26,
                                              blurRadius: 0.8,
                                            ),
                                          ],
                                        ),
                                        child: Text(
                                          "#${resultData[index].title!}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                resultData[index].rate == null
                                    ? const SizedBox()
                                    : Padding(
                                        padding: const EdgeInsets.only(
                                          left: 5,
                                          right: 5,
                                          bottom: 2,
                                        ),
                                        child: Row(
                                          children: [
                                            const Text(
                                              "Buy now",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                            const Gap(5),
                                            Text(
                                              "${resultData[index].rate!} ${resultData[index].chain == "Ethereum" ? "ETH" : "BTC"}",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const Center(
                    child: Column(
                      children: [
                        Gap(300),
                        Icon(
                          Icons.collections_sharp,
                          color: Colors.black45,
                          size: 50,
                        ),
                        Gap(8),
                        Text(
                          "No NFTs Added",
                          style: TextStyle(
                            color: Colors.black45,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                }
            }
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
