import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:just_audio/just_audio.dart';
import 'package:nft_marketplace/data%20manager/database_handler.dart';
import 'package:nft_marketplace/data_variables.dart';
import 'package:nft_marketplace/model/nft_model.dart';
import 'package:nft_marketplace/model/wallet_model.dart';
import 'package:nft_marketplace/utils/colors.dart';
import 'package:nft_marketplace/wallet/net/wallet_data_manager.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

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
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              child: Column(
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
                  Text(widget.nftModel.title!),
                  Text(
                    "by ${widget.nftModel.createdBy}",
                    style: const TextStyle(fontSize: 11),
                  ),
                  Text(widget.nftModel.description!),
                  Text(widget.nftModel.rate == null ? "" : "On Sell"),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.nftModel.blockchain!.length,
                    itemBuilder: (context, index) {
                      final data = widget.nftModel.blockchain!;
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                              "--------------------------------------------"),
                          Text("From : ${data[index].from}"),
                          Text("Amount : ${data[index].amount}"),
                          Text("To : ${data[index].to}"),
                          const Text(
                              "--------------------------------------------\n\n"),
                        ],
                      );
                    },
                  )
                ],
              ),
            ),
            const Spacer(),
            widget.nftModel.rate == null
                ? const SizedBox()
                : widget.nftModel.currentOwner == user.uid
                    ? const SizedBox()
                    : Align(
                        alignment: Alignment.bottomCenter,
                        child: MaterialButton(
                          minWidth: 300,
                          color: ColorsData.selectiveYellow,
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
                          child: const Text("Buy now"),
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
                onPressed: () {
                  Future.delayed(const Duration(seconds: 2), () async {
                    controller.success();
                  }).then(
                    (value) async {
                      final audio = AudioPlayer();
                      await audio.setAsset("assets/audio/payment_success.mp3");
                      await audio.play();
                      WalletModel model =
                          await WalletDataManager.getWallet(user.uid);
                      if (nftModel.chain == "Ethereum") {
                        if (model.coin!.ethereum! <
                            double.parse(nftModel.rate!)) {
                          debugPrint("Not Enough Balance");
                        } else {
                          DataBase.buyNft(nftModel);
                        }
                      } else {
                        if (model.coin!.bitcoin! <
                            double.parse(nftModel.rate!)) {
                          debugPrint("Not Enough Balance");
                        } else {
                          DataBase.buyNft(nftModel);
                        }
                      }
                      Navigator.pop(context);
                    },
                  );
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
