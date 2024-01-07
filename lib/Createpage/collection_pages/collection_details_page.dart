import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nft_marketplace/colors.dart';
import 'package:nft_marketplace/data%20manager/database_handler.dart';
import 'package:nft_marketplace/model/collection_model.dart';
import 'package:nft_marketplace/model/nft_model.dart';
import 'package:provider/provider.dart';

import '../../data manager/data_variables.dart';
import '../../provider/collection_provider.dart';

class CollectionDetailsPageWidget extends StatefulWidget {
  final CollectionModel collectionModel;

  const CollectionDetailsPageWidget({super.key, required this.collectionModel});

  @override
  State<CollectionDetailsPageWidget> createState() =>
      _CollectionDetailsPageWidgetState();
}

class _CollectionDetailsPageWidgetState
    extends State<CollectionDetailsPageWidget> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CollectionProvider>(context);
    final checkUser = widget.collectionModel.createdBy == user.uid;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.collectionModel.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        forceMaterialTransparency: true,
      ),
      body: Column(
        children: [
          checkUser
              ? const SizedBox()
              : Stack(
                  children: [
                    widget.collectionModel.bgImage == null
                        ? Container(
                            height: 250,
                            width: double.infinity,
                            color: Colors.white,
                          )
                        : SizedBox(
                            height: 250,
                            width: double.infinity,
                            child: Image.network(
                              widget.collectionModel.bgImage!,
                              fit: BoxFit.values[0],
                            ),
                          ),
                    Positioned(
                      bottom: -2,
                      child: Image.asset(
                        "assets/images/shadow.png",
                        color: Colors.white,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      left: 25,
                      bottom: 0,
                      child: Container(
                        height: 120,
                        width: 120,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: widget.collectionModel.thumbnail,
                            fit: BoxFit.cover,
                            placeholder: (context, text) =>
                                Image.asset("assets/images/logo.jpg"),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
          if (checkUser)
            const SizedBox()
          else
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(20),
                    Text(
                      widget.collectionModel.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                      ),
                    ),
                    Text(
                      widget.collectionModel.description,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '''• created by ${user.displayName}   • items ${widget.collectionModel.items.length}
• category ${widget.collectionModel.category}
                    ''',
                      textAlign: TextAlign.justify,
                    )
                  ],
                ),
              ),
            ),
          Expanded(
            child: StreamBuilder(
              stream: DataBase.getNftInCollections(widget.collectionModel.id!),
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
                          crossAxisCount: 3,
                          padding: const EdgeInsets.only(top: 10, right: 8),
                          childAspectRatio: 1,
                          children: List.generate(
                            resultData.length,
                            (index) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 8, top: 8),
                                child: CachedNetworkImage(
                                  imageUrl: resultData[index].imageUrl!,
                                  fit: BoxFit.cover,
                                  placeholder: (context, text) =>
                                      Image.asset("assets/images/logo.jpg"),
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
          ),
          const Gap(20),
        ],
      ),
      floatingActionButton: widget.collectionModel.createdBy == user.uid
          ? FloatingActionButton.extended(
              onPressed: () {
                provider.pickImages(true, false).then(
                  (value) {
                    for (int index = 0;
                        index < provider.images.length;
                        index++) {
                      debugPrint(
                          "This is the image => ${provider.images[index]}");
                      Random random = Random();
                      String title = random.nextInt(1000).toString();
                      final nftModel = NftModel(
                        title: title,
                        description: widget.collectionModel.description,
                        collectionName: widget.collectionModel.name,
                        collectionId: widget.collectionModel.id,
                        imageUrl: provider.images[index],
                        currentOwner: user.uid,
                        owners: [
                          user.uid,
                        ],
                        createdBy: user.uid,
                        createdAt: DateTime.now().toString(),
                        updatedAt: DateTime.now().toString(),
                      );
                      DataBase.addNft(nftModel);
                    }
                  },
                );
              },
              backgroundColor: ColorsData.selectiveYellow,
              icon: const Icon(Icons.add),
              label: const Text("NFTs"),
            )
          : Container(),
    );
  }
}
