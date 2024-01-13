import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nft_marketplace/Createpage/collection_pages/view_nft.dart';
import 'package:nft_marketplace/colors.dart';
import 'package:nft_marketplace/data%20manager/database_handler.dart';
import 'package:nft_marketplace/model/collection_model.dart';
import 'package:nft_marketplace/model/nft_model.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../data_variables.dart';
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
                      bottom: 20,
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
      • category ${widget.collectionModel.category}  • chain ${widget.collectionModel.chain}   
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
                          crossAxisCount: 2,
                          padding: const EdgeInsets.only(top: 10, right: 8),
                          childAspectRatio: 1,
                          children: List.generate(
                            resultData.length,
                            (index) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 8, top: 8),
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
                                          width: 200,
                                          fit: BoxFit.cover,
                                          placeholder: (context, text) =>
                                              Image.asset(
                                            "assets/images/logo.jpg",
                                          ),
                                        ),
                                      ),
                                      resultData[index].rate != null
                                          ? Positioned(
                                              top: 5,
                                              right: 5,
                                              child: Image.asset(
                                                "assets/images/on_sell.gif",
                                                height: 15,
                                                width: 15,
                                              ),
                                            )
                                          : resultData[index].currentOwner ==
                                                  user.uid
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
                                                        _showBottomSheet(
                                                            resultData[index]);
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
                        category: widget.collectionModel.category,
                        chain: widget.collectionModel.chain,
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
                    provider.removeImage();
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

  _showBottomSheet(NftModel nftModel) {
    final rate = TextEditingController();
    final buttonController = RoundedLoadingButtonController();
    var formKey = GlobalKey<FormState>();
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (builder) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SizedBox(
              height: 250,
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/auction.png",
                        height: 35,
                        width: 35,
                      ),
                      const Gap(8),
                      const Text(
                        "Ready to sell",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  const Gap(20),
                  Row(
                    children: [
                      const Gap(20),
                      Image.asset(
                        nftModel.chain == "Ethereum"
                            ? "assets/images/ethereum.png"
                            : "assets/images/bitcoin.png",
                        height: 50,
                        width: 50,
                      ),
                      const Gap(10),
                      SizedBox(
                        width: 260,
                        child: Form(
                          key: formKey,
                          child: TextFormField(
                            controller: rate,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "amount must be needed";
                              } else {
                                return null;
                              }
                            },
                            decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(),
                                border: OutlineInputBorder(),
                                hintText: "Enter the amount",
                                contentPadding: EdgeInsets.all(10)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(20),
                  RoundedLoadingButton(
                    width: 320,
                    controller: buttonController,
                    color: ColorsData.selectiveYellow,
                    successColor: ColorsData.selectiveYellow,
                    onPressed: () {
                      final valid = formKey.currentState!.validate();
                      if (valid) {
                        Future.delayed(const Duration(seconds: 3))
                            .then((value) {
                          buttonController.success();
                        }).then((value) {
                          nftModel.rate = rate.text;
                          DataBase.setToSell(nftModel);
                          Navigator.pop(context);
                        });
                      } else {
                        buttonController.reset();
                        formKey.currentState!.validate();
                      }
                    },
                    child: const Text(
                      "Mint Now",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
