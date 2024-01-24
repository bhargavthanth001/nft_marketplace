import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nft_marketplace/utils/bottmsheet.dart';

import '../Createpage/collection_pages/view_nft.dart';
import '../data manager/database_handler.dart';
import '../data_variables.dart';

class CollectedNFTsPageWidget extends StatelessWidget {
  final String id;

  const CollectedNFTsPageWidget({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: DataBase.getCollectedNft(id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final resultData = snapshot.data;
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const SizedBox();
              case ConnectionState.done:
                return const SizedBox();
              case ConnectionState.waiting:
                return const CircularProgressIndicator();
              case ConnectionState.active:
                if (resultData != null && resultData.isNotEmpty) {
                  return GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: 1,
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
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: CachedNetworkImage(
                                    imageUrl: resultData[index].imageUrl!,
                                    height: 200,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    placeholder: (context, text) => Image.asset(
                                      "assets/images/logo.jpg",
                                      height: 140,
                                    ),
                                  ),
                                ),
                                resultData[index].rate != null
                                    ? Positioned(
                                        top: 5,
                                        right: 5,
                                        child: Image.asset(
                                          "assets/images/on_sell.gif",
                                          height: 18,
                                          width: 18,
                                        ),
                                      )
                                    : resultData[index].currentOwner == user.uid
                                        ? Positioned(
                                            top: 4,
                                            right: 4,
                                            child: Container(
                                              height: 28,
                                              width: 28,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  100,
                                                ),
                                                color: Colors.white,
                                              ),
                                              child: IconButton(
                                                onPressed: () {
                                                  showBottomSheetMethod(
                                                    context,
                                                    resultData[index],
                                                  );
                                                },
                                                icon: Image.asset(
                                                  "assets/images/auction.png",
                                                ),
                                              ),
                                            ),
                                          )
                                        : const SizedBox(),
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
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.collections_sharp,
                          color: Colors.black45,
                          size: 50,
                        ),
                        Gap(8),
                        Text(
                          "No NFTs Collected",
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
