import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:nft_marketplace/colors.dart';
import 'package:nft_marketplace/data_variables.dart';
import 'package:nft_marketplace/provider/refresh_screen_provider.dart';
import 'package:nft_marketplace/wallet/net/wallet_data_manager.dart';
import 'package:provider/provider.dart';

class TransactionScreenWidget extends StatelessWidget {
  const TransactionScreenWidget({super.key});

  String formattedDate(String date) {
    return DateFormat("dd-MMM-yy").format(DateTime.parse(date));
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RefreshScreenProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transaction"),
        forceMaterialTransparency: true,
      ),
      body: RefreshIndicator(
        onRefresh: provider.onRefresh,
        color: Colors.white,
        backgroundColor: ColorsData.selectiveYellow,
        strokeWidth: 2,
        child: FutureBuilder(
          future: WalletDataManager.getWallet(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final resultData = snapshot.data!.transactions;
              return ListView.builder(
                itemCount: resultData!.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 60,
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Gap(10),
                        Image.asset(
                          resultData[index].coinType == "Ethereum"
                              ? "assets/images/ethereum.png"
                              : "assets/images/bitcoin.png",
                          height: 40,
                          width: 40,
                        ),
                        const Gap(8),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              resultData[index].from!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            const Gap(4),
                            Text(
                              formattedDate(resultData[index].transactedAt!),
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Text(
                          resultData[index].amount!.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: resultData[index].to! == user.uid
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                        const Gap(10),
                      ],
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: ColorsData.selectiveYellow,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
