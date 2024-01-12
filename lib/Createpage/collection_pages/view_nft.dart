import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nft_marketplace/colors.dart';
import 'package:nft_marketplace/data%20manager/database_handler.dart';
import 'package:nft_marketplace/data_variables.dart';
import 'package:nft_marketplace/model/nft_model.dart';
import 'package:nft_marketplace/model/wallet_model.dart';
import 'package:nft_marketplace/wallet/net/wallet_data_manager.dart';

import '../../snack_bar.dart';

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
                ],
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: MaterialButton(
                minWidth: 300,
                color: ColorsData.selectiveYellow,
                onPressed: () async {
                  final wallet = await WalletDataManager.existWallet();
                  if (wallet) {
                    _showPurchaseBottomSheet(widget.nftModel);
                  } else {
                    openSnackBar(context, "Create a Walllet", Colors.red);
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
              MaterialButton(
                onPressed: () async {
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
                child: const Text("Pay now"),
              ),
            ],
          ),
        );
      },
    );
  }
}
