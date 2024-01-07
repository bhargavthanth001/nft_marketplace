import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nft_marketplace/provider/meta_mask_provider.dart';
import 'package:nft_marketplace/wallet/ui/home_view.dart';
import 'package:provider/provider.dart';

class WalletPageWidget extends StatefulWidget {
  const WalletPageWidget({super.key});

  @override
  State<WalletPageWidget> createState() => _WalletPageWidgetState();
}

class _WalletPageWidgetState extends State<WalletPageWidget> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MetaMaskProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          children: [
            const Text("My Wallet"),
            const Gap(30),
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.blueAccent,
              ),
              child: const Padding(
                padding: EdgeInsets.only(left: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Gap(2),
                    Row(
                      children: [
                        Text(
                          "Balance",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.wallet_giftcard,
                          color: Colors.white,
                          size: 50,
                        ),
                        Gap(30)
                      ],
                    ),
                    Text(
                      "\$ 22.34",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "xxxxxxx3454",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "8/28",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Gap(30)
                      ],
                    ),
                    Gap(2)
                  ],
                ),
              ),
            ),
            const Gap(10),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeView()));
                },
                child: const Text("Make Wallet"))
          ],
        ),
      ),
    );
  }
}
