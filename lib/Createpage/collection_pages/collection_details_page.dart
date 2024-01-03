import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nft_marketplace/colors.dart';
import 'package:nft_marketplace/data%20manager/database_handler.dart';
import 'package:nft_marketplace/model/collection_model.dart';
import 'package:nft_marketplace/model/nft_model.dart';
import 'package:provider/provider.dart';

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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          widget.collectionModel.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        forceMaterialTransparency: true,
      ),
      body: Center(
        child: widget.collectionModel.items.isNotEmpty
            ? const SizedBox()
            : Text(
                "No NFTs Added",
                style: TextStyle(
                  color: Colors.red.shade200,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          provider.pickImages(true).then((value) {
            for (int index = 0; index < provider.images.length; index++) {
              debugPrint("This is the image => ${provider.images[index]}");
              Random random = Random();
              String title = random.nextInt(1000).toString();
              final nftModel = NftModel(
                title: title,
                description: widget.collectionModel.description,
                collectionName: widget.collectionModel.name,
                collectionId: widget.collectionModel.id,
                imageUrl: provider.images[index],
                currentOwner: DataBase.user.uid,
                owners: [
                  DataBase.user.uid,
                ],
                createdBy: DataBase.user.uid,
                createdAt: DateTime.now().toString(),
                updatedAt: DateTime.now().toString(),
              );
              DataBase.addNft(nftModel);
            }
          });
        },
        backgroundColor: ColorsData.selectiveYellow,
        icon: const Icon(Icons.add),
        label: const Text("NFTs"),
      ),
    );
  }
}
