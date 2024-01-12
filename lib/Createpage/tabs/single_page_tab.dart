import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nft_marketplace/Createpage/collection_pages/view_nft.dart';
import 'package:nft_marketplace/colors.dart';
import 'package:nft_marketplace/model/nft_model.dart';

import '../../data manager/database_handler.dart';

class SingleNftTab extends StatefulWidget {
  const SingleNftTab({super.key});

  @override
  State<SingleNftTab> createState() => _SingleNftTabState();
}

class _SingleNftTabState extends State<SingleNftTab> {
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
        stream: DataBase.getNft(),
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
                  padding: const EdgeInsets.only(top: 10, left: 8, right: 8),
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
                                builder: (context) => ViewNftPageWidget(
                                  nftModel: result[index],
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
                                  imageUrl: result[index].imageUrl!,
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
                                  bottom: 10,
                                  child: Text(
                                    result[index].title!,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: IconButton(
                                    onPressed: () {
                                      _showAlertDialog(result[index]);
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
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
        },
      ),
    );
  }

  _showAlertDialog(NftModel nftModel) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Delete NFT ?",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          content: const Text(
              "deleted NFTs can't be retrieved \nDo you agree with it"),
          actions: [
            TextButton(
                onPressed: () {
                  DataBase.deleteNft(nftModel);
                  Navigator.pop(context);
                },
                child: const Text("Yes")),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"))
          ],
        );
      },
    );
  }
}
