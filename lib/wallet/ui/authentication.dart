import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nft_marketplace/colors.dart';
import 'package:nft_marketplace/data%20manager/database_handler.dart';
import 'package:nft_marketplace/data_variables.dart';
import 'package:nft_marketplace/model/wallet_model.dart';
import 'package:nft_marketplace/wallet/net/wallet_data_manager.dart';
import 'package:nft_marketplace/wallet/ui/wallet_home_page.dart';

import '../../data manager/session_manager.dart';

class Authentication extends StatefulWidget {
  Authentication({Key? key}) : super(key: key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  final TextEditingController _emailField = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: DataBase.currentUser(),
      builder: (context, snapshot) {
        final data = snapshot.data;
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsData.selectiveYellow,
                  ),
                  onPressed: () async {
                    debugPrint(data!.email);
                    EmailOTP myAuth = EmailOTP();
                    myAuth.setConfig(
                      appEmail: "nft_marketplace@gmail.com",
                      appName: "Email OTP",
                      userEmail: data!.email,
                      otpLength: 6,
                      otpType: OTPType.digitsOnly,
                    );
                    debugPrint(myAuth.sendOTP().toString());
                    if (await myAuth.sendOTP() == true) {
                      final model = WalletModel(
                          walletId: user.uid,
                          coin: CoinList(ethereum: 100.0, bitcoin: 10.0),
                          transactions: [
                            TransactionList(
                              from: "nft_marketplace",
                              to: user.uid,
                              amount: 100.0,
                              coinType: "Ethereum",
                              transactedAt: DateTime.now().toLocal().toString(),
                            ),
                            TransactionList(
                              from: "nft_marketplace",
                              to: user.uid,
                              amount: 10.0,
                              coinType: "Bitcoin",
                              transactedAt: DateTime.now().toLocal().toString(),
                            ),
                          ],
                          createdAt: DateTime.now().toLocal().toString());
                      WalletDataManager.createWallet(model);
                      SessionManager.setWalletSession();
                      _showDialog(myAuth, data.email!);
                    }
                  },
                  child: const Text(
                    "Create wallet",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ));
  }

  _showDialog(EmailOTP auth, String emailId) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.white,
            child: Container(
              height: 265,
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Gap(15),
                  Image.asset(
                    "assets/images/email.png",
                    height: 50,
                    width: 50,
                  ),
                  const Gap(5),
                  Text(
                    "OTP received on \n$emailId",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black45,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(12),
                  TextField(
                    controller: _otpController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      hintText: "Enter the OTP",
                    ),
                  ),
                  const Gap(12),
                  MaterialButton(
                    color: ColorsData.selectiveYellow,
                    onPressed: () {
                      debugPrint(
                          "OTP Text=> ${auth.verifyOTP(otp: _otpController.text)}");
                      debugPrint(
                          "OTP => ${auth.verifyOTP(otp: _otpController.text)}");
                      if (auth.verifyOTP(otp: _otpController.text) == true) {
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => WalletHomePage(),
                          ),
                        );
                      } else {
                        debugPrint("invalid otp");
                      }
                    },
                    child: const Text(
                      "Verify",
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
