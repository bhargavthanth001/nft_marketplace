import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../Createpage/collection_pages/view_nft.dart';
import '../data manager/database_handler.dart';
import '../data_variables.dart';
import '../model/nft_model.dart';

class CollectedNFTsPageWidget extends StatefulWidget {
  final String id;

  const CollectedNFTsPageWidget({super.key, required this.id});

  @override
  State<CollectedNFTsPageWidget> createState() =>
      _CollectedNFTsPageWidgetState();
}

class _CollectedNFTsPageWidgetState extends State<CollectedNFTsPageWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: DataBase.getCollectedNft(widget.id),
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
                    crossAxisCount: 3,
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

  showBottomSheetMethod(NftModel nftModel) {
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
                            keyboardType: TextInputType.number,
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
                    color: Colors.blue,
                    successColor: Colors.blue,
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
