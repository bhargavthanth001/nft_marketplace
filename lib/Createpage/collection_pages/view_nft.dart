import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:just_audio/just_audio.dart';
import 'package:nft_marketplace/Createpage/collection_pages/collection_details_page.dart';
import 'package:nft_marketplace/data%20manager/database_handler.dart';
import 'package:nft_marketplace/data_variables.dart';
import 'package:nft_marketplace/model/nft_model.dart';
import 'package:nft_marketplace/model/wallet_model.dart';
import 'package:nft_marketplace/utils/display_formated_date.dart';
import 'package:nft_marketplace/wallet/net/wallet_data_manager.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../profile.dart';
import '../../utils/snack_bar.dart';

class ViewNftPageWidget extends StatefulWidget {
  final NftModel nftModel;

  const ViewNftPageWidget({super.key, required this.nftModel});

  @override
  State<ViewNftPageWidget> createState() => _ViewNftPageWidgetState();
}

class _ViewNftPageWidgetState extends State<ViewNftPageWidget> {
  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<NFTPageProvider>(context);
    debugPrint("building...");
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.flag,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 300,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: widget.nftModel.imageUrl!,
                        fit: BoxFit.cover,
                        placeholder: (context, text) =>
                            Image.asset("assets/images/logo.jpg"),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 5, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FutureBuilder(
                            future: DataBase.getNamedCollection(
                                widget.nftModel.collectionId!),
                            builder: (context, snapshot) {
                              return GestureDetector(
                                child: Text(
                                  widget.nftModel.collectionName!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.blue,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CollectionDetailsPageWidget(
                                              collectionModel: snapshot.data!),
                                    ),
                                  );
                                },
                              );
                            }),
                        const Gap(5),
                        Container(
                          padding: const EdgeInsets.only(
                              top: 2, bottom: 2, left: 10, right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.black,
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(0, 0),
                                color: Colors.black12,
                                blurRadius: 5,
                              )
                            ],
                          ),
                          child: Text(
                            "# ${widget.nftModel.title!}",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        const Gap(6),
                        Row(
                          children: [
                            const Text(
                              "Current Owner ",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 15),
                            ),
                            const Gap(5),
                            FutureBuilder(
                              future: DataBase.getUser(
                                  widget.nftModel.currentOwner!),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  final result = snapshot.data;
                                  if (result != null) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ProfilePage(
                                              userId: result.id!,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        snapshot.data!.username!,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.blueAccent,
                                        ),
                                      ),
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                } else {
                                  return const SizedBox();
                                }
                              },
                            )
                          ],
                        ),
                        const Gap(6),
                        Row(
                          children: [
                            const Text(
                              "Created By ",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 15),
                            ),
                            const Gap(5),
                            FutureBuilder(
                              future:
                                  DataBase.getUser(widget.nftModel.createdBy!),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  final result = snapshot.data;
                                  if (result != null) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ProfilePage(
                                              userId: result.id!,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        snapshot.data!.username!,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.blueAccent),
                                      ),
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                } else {
                                  return const SizedBox();
                                }
                              },
                            )
                          ],
                        ),
                        const Gap(5),
                        Row(
                          children: [
                            const Text(
                              "Chain",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const Gap(4),
                            Text(
                              widget.nftModel.chain!,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const Gap(6),
                        Text(
                          widget.nftModel.description!,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  const Gap(8),
                  widget.nftModel.rate == null
                      ? const SizedBox()
                      : Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.black26)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Gap(6),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(
                                  "Uploaded At ${formattedDate(
                                    widget.nftModel.createdAt!,
                                  )}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                              const Divider(
                                color: Colors.black26,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Current Price",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    const Gap(3),
                                    Row(
                                      children: [
                                        Text(
                                          widget.nftModel.rate!.toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20),
                                        ),
                                        const Gap(4),
                                        Text(
                                          widget.nftModel.chain == "Ethereum"
                                              ? "ETH "
                                              : "BTC",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20),
                                        ),
                                        // Text(data)
                                      ],
                                    ),
                                    const Gap(8)
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                  widget.nftModel.blockchain!.isEmpty
                      ? Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              const Gap(15),
                              Image.asset(
                                "assets/images/transaction_not.png",
                                height: 25,
                                width: 25,
                                color: Colors.black54,
                              ),
                              const Gap(8),
                              const Text(
                                "Transaction not found",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54),
                              ),
                            ],
                          ),
                        )
                      : Column(
                          children: [
                            const Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                "Blockchain",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const Gap(8),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: widget.nftModel.blockchain!.length,
                              reverse: true,
                              itemBuilder: (context, index) {
                                debugPrint(widget
                                    .nftModel.blockchain![index].amount
                                    .toString());
                                final data = widget.nftModel.blockchain!;
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 8),
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
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Gap(2),
                                            Text(
                                              data[index].to,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.green,
                                              ),
                                            ),
                                            const Gap(3),
                                            const Text(
                                              "From",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const Gap(3),
                                            Text(
                                              data[index].from,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.red),
                                            ),
                                            const Gap(2)
                                          ],
                                        ),
                                        const Spacer(),
                                        Container(
                                          height: 70,
                                          width: 70,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.only(
                                              topRight: Radius.circular(8),
                                              bottomRight: Radius.circular(8),
                                            ),
                                            color: index == 0
                                                ? Colors.blue
                                                : double.parse(data[index]
                                                            .amount) >
                                                        (double.parse(
                                                            data[index - 1]
                                                                .amount))
                                                    ? Colors.green
                                                    : Colors.red,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                data[index].amount,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                ),
                                              ),
                                              const Gap(5),
                                              Text(
                                                widget.nftModel.chain ==
                                                        "Ethereum"
                                                    ? "ETH"
                                                    : "BTC",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white,
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
                          ],
                        ),
                  const Gap(50)
                ],
              ),
            ),
            // const Spacer(),
            widget.nftModel.rate == null
                ? const SizedBox()
                : widget.nftModel.currentOwner == user.uid
                    ? const SizedBox()
                    : Align(
                        alignment: Alignment.bottomCenter,
                        child: MaterialButton(
                          minWidth: 300,
                          color: Colors.blue,
                          onPressed: () async {
                            final wallet =
                                await WalletDataManager.existWallet();
                            if (wallet) {
                              _showPurchaseBottomSheet(widget.nftModel);
                            } else {
                              openSnackBar(
                                  context, "Create a Walllet", Colors.red);
                            }
                          },
                          child: const Text(
                            "Buy now",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
          ],
        ),
      ),
    );
  }

  _showPurchaseBottomSheet(NftModel nftModel) {
    final controller = RoundedLoadingButtonController();
    return showModalBottomSheet(
      context: context,
      shape: const OutlineInputBorder(borderRadius: BorderRadius.zero),
      builder: (builder) {
        return Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    nftModel.rate!,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontSize: 25),
                  ),
                  const Gap(5),
                  Text(
                    nftModel.chain == "Ethereum" ? "ETH" : "BTC",
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              RoundedLoadingButton(
                controller: controller,
                color: Colors.red,
                successColor: Colors.red,
                onPressed: () async {
                  bool isSuccess = false;
                  WalletModel model =
                      await WalletDataManager.getWallet(user.uid);
                  if (nftModel.chain == "Ethereum") {
                    if (model.coin!.ethereum! < double.parse(nftModel.rate!)) {
                      debugPrint("Not Enough Balance");
                    } else {
                      isSuccess = true;
                    }
                  } else {
                    if (model.coin!.bitcoin! < double.parse(nftModel.rate!)) {
                      debugPrint("Not Enough Balance");
                    } else {
                      isSuccess = true;
                    }
                  }
                  debugPrint(isSuccess.toString());
                  if (isSuccess) {
                    Future.delayed(const Duration(seconds: 2), () async {
                      controller.success();
                    }).then(
                      (value) async {
                        final audio = AudioPlayer();
                        await audio
                            .setAsset("assets/audio/payment_success.mp3");
                        await audio.play();
                        DataBase.buyNft(nftModel);
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                    );
                  } else {
                    controller.reset();
                    Future.delayed(const Duration(seconds: 1), () {
                      Navigator.pop(context);
                      openSnackBar(context, "Not Enough Balance", Colors.red);
                    });
                  }
                },
                child: const Text(
                  "Pay now",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
/*
*                 onPressed: () async {
                  WalletModel model =
                      await WalletDataManager.getWallet(user.uid);
                  if (nftModel.chain == "Ethereum") {
                    if (model.coin!.ethereum! < double.parse(nftModel.rate!)) {
                      debugPrint("Not Enough Balance");
                    } else {
                      DataBase.buyNft(nftModel);
                    }
                  } else {
                    if (model.coin!.bitcoin! < double.parse(nftModel.rate!)) {
                      debugPrint("Not Enough Balance");
                    } else {
                      DataBase.buyNft(nftModel);
                    }
                  }
                },
*/
