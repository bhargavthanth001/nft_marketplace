import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../data manager/database_handler.dart';
import '../model/nft_model.dart';
import 'colors.dart';

showBottomSheetMethod(BuildContext context, NftModel nftModel) {
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
                      Future.delayed(const Duration(seconds: 3)).then((value) {
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
