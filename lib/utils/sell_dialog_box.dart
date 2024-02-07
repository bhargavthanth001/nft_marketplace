import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../data manager/database_handler.dart';
import '../model/nft_model.dart';

showDialogBox(NftModel nftModel, BuildContext context) {
  final rate = TextEditingController();
  final buttonController = RoundedLoadingButtonController();
  var formKey = GlobalKey<FormState>();
  return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: Container(
          height: 190,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Gap(10),
              Row(
                mainAxisSize: MainAxisSize.min,
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
                    width: 180,
                    child: Form(
                      key: formKey,
                      child: TextFormField(
                        controller: rate,
                        keyboardType: TextInputType.number,
                        autofocus: true,
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
              const Spacer(),
              RoundedLoadingButton(
                width: 250,
                height: 40,
                controller: buttonController,
                color: Colors.blue,
                successColor: Colors.blue,
                onPressed: () {
                  final valid = formKey.currentState!.validate();
                  if (valid) {
                    Future.delayed(const Duration(seconds: 3)).then((value) {
                      buttonController.success();
                    }).then((value) {
                      Future.delayed(const Duration(seconds: 1), () {
                        nftModel.rate = rate.text;
                        DataBase.setToSell(nftModel);
                        Navigator.pop(context);
                      });
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
                    fontSize: 16,
                  ),
                ),
              ),
              const Gap(15)
            ],
          ),
        ));
      });
}
