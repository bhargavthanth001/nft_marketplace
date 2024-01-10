import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nft_marketplace/colors.dart';
import 'package:nft_marketplace/model/collection_model.dart';
import 'package:nft_marketplace/model/nft_model.dart';

class ViewNftPageWidget extends StatelessWidget {
  final NftModel nftModel;
  final CollectionModel collectionModel;

  const ViewNftPageWidget(
      {super.key, required this.nftModel, required this.collectionModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: nftModel.imageUrl!,
                fit: BoxFit.cover,
                placeholder: (context, text) =>
                    Image.asset("assets/images/logo.jpg"),
              ),
            ),
            Text(collectionModel.name),
            Text(
              "by ${collectionModel.createdBy}",
              style: const TextStyle(fontSize: 11),
            ),
            Text(collectionModel.description),
            MaterialButton(
              minWidth: double.infinity,
              color: ColorsData.selectiveYellow,
              onPressed: () {},
              child: const Text("Pay now"),
            )
          ],
        ),
      ),
    );
  }
}
