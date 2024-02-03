import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nft_marketplace/data%20manager/database_handler.dart';

import 'Createpage/collection_pages/view_nft.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 34;
    // container(Color color, String title) {
    //   return Container(
    //     height: 70,
    //     width: width / 2,
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(5),
    //       color: color,
    //     ),
    //     child: Center(
    //       child: Text(
    //         title,
    //         style: const TextStyle(
    //             color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18),
    //       ),
    //     ),
    //   );
    // }
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "On Sell NFTs",
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 4, right: 4, top: 8),
          child: Column(
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     Column(
              //       children: [
              //         GestureDetector(
              //           onTap: () {
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                 builder: (context) =>
              //                     const SearchCategoryDetailPageWidget(
              //                   category: "Art",
              //                 ),
              //               ),
              //             );
              //           },
              //           child: container(Colors.green, "Art"),
              //         ),
              //         const Gap(10),
              //         container(Colors.brown, "Photography"),
              //         const Gap(10),
              //         container(Colors.red, "Game")
              //       ],
              //     ),
              //     const Gap(10),
              //     Column(
              //       children: [
              //         container(Colors.deepPurple, "Music"),
              //         const Gap(10),
              //         container(Colors.blue, "Drawing"),
              //         const Gap(10),
              //         container(Colors.lime, "Entertainment")
              //       ],
              //     ),
              //   ],
              // ),
              // const Gap(10),
              StreamBuilder(
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
                            childAspectRatio: 0.65,
                            padding: const EdgeInsets.only(right: 8),
                            children: List.generate(
                              resultData.length,
                              (index) {
                                return Container(
                                  margin:
                                      const EdgeInsets.only(left: 8, top: 8),
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
                                          builder: (context) =>
                                              ViewNftPageWidget(
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
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(5),
                                                topRight: Radius.circular(5),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    resultData[index].imageUrl!,
                                                height: 200,
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                                placeholder: (context, text) =>
                                                    Image.asset(
                                                  "assets/images/logo.jpg",
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
                                                  resultData[index]
                                                      .collectionName!,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      overflow: TextOverflow
                                                          .ellipsis),
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
                                                        fontWeight:
                                                            FontWeight.w300,
                                                      ),
                                                    ),
                                                    const Gap(5),
                                                    Text(
                                                      "${resultData[index].rate!} ${resultData[index].chain == "Ethereum" ? "ETH" : "BTC"}",
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
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
            ],
          ),
        )

        // body: Center(
        //   child: Column(
        //     children: [
        //       Container(
        //         height: 50,
        //         width: 340,
        //         margin: const EdgeInsets.all(10),
        //         decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(8),
        //           color: Colors.white,
        //           boxShadow: const [
        //             BoxShadow(
        //               offset: Offset(0, 0),
        //               color: Colors.black12,
        //               blurRadius: 5,
        //             )
        //           ],
        //         ),
        //         child: Row(
        //           children: [
        //             SizedBox(
        //               width: 290,
        //               child: TextFormField(
        //                 controller: provider.searchController,
        //                 onChanged: (value) => {provider.onChange()},
        //                 decoration: const InputDecoration(
        //                   focusedBorder: InputBorder.none,
        //                   enabledBorder: InputBorder.none,
        //                   contentPadding: EdgeInsets.only(left: 10),
        //                   hintText: "Search Collection/User...",
        //                 ),
        //               ),
        //             ),
        //             if (provider.searchController.text == "")
        //               IconButton(
        //                 onPressed: () {
        //                   if (provider.searchController.text == "") {}
        //                 },
        //                 icon: const Icon(
        //                   Icons.search,
        //                   color: Colors.blue,
        //                 ),
        //               )
        //             else
        //               IconButton(
        //                 onPressed: () {
        //                   provider.clearSearch();
        //                 },
        //                 icon: const Icon(
        //                   Icons.cancel_outlined,
        //                   color: Colors.blue,
        //                 ),
        //               )
        //           ],
        //         ),
        //       ),
        //       provider.searchController.text == ""
        //           ? const SizedBox()
        //           : Expanded(
        //               child: ListView.builder(
        //                 itemCount: provider.filteredList().length,
        //                 itemBuilder: (context, index) {
        //                   return ListTile(
        //                     title: Text(provider.filteredList()[index]),
        //                   );
        //                 },
        //               ),
        //             ),
        //     ],
        //   ),
        // ),
        );
  }
}
