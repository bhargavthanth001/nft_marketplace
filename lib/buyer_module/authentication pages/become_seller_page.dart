import 'dart:math';

import 'package:datepicker_cupertino/datepicker_cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:gap/gap.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:nft_marketplace/buyer_module/buyer_module.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../data manager/database_handler.dart';
import '../model/user_model.dart';

class BecomeSellerPageWidget extends StatefulWidget {
  const BecomeSellerPageWidget({super.key});

  @override
  State<BecomeSellerPageWidget> createState() => _BecomeSellerPageWidgetState();
}

class _BecomeSellerPageWidgetState extends State<BecomeSellerPageWidget> {
  var formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final dateController = TextEditingController();
  final phoneController = TextEditingController();
  final bankController = TextEditingController();
  final accountController = TextEditingController();
  final ifscController = TextEditingController();
  final otpCodeController = TextEditingController();
  final RoundedLoadingButtonController submitController =
      RoundedLoadingButtonController();

  String countryCode = "91";
  String dob = "";
  String phNo = "";

  Widget colum(
      String text, TextEditingController controller, IconButton? icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        const Gap(5),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
              border: const OutlineInputBorder(),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blueAccent,
                  width: 1.8,
                ),
              ),
              suffixIcon: icon ?? const SizedBox(),
              contentPadding: const EdgeInsets.all(12),
              hintText:
                  controller.text == "" ? "Enter the $text" : controller.text),
        ),
        const Gap(10),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<UserModel>(
        future: DataBase.getUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final result = snapshot.data;
            if (result != null) {
              nameController.text = result.name!;
              emailController.text = result.email!;
              return SingleChildScrollView(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(50),
                      Image.asset(
                        "assets/images/logo.jpg",
                        height: 80,
                        width: 80,
                      ),
                      const Gap(8),
                      const Text(
                        "Become a Seller",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 25,
                        ),
                      ),
                      const Gap(20),
                      Text(
                        result.name!,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text(
                        result.email!,
                        style: const TextStyle(fontSize: 15),
                      ),
                      const Gap(10),
                      const Text(
                        "DOB",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const Gap(5),
                      DatePickerCupertino(
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          hintText: 'Select Data of Birth',
                          onDateTimeChanged: (date) {
                            dob = date.toString();
                          }),
                      const Gap(10),
                      const Text(
                        "PhNo.",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const Gap(5),
                      IntlPhoneField(
                        controller: phoneController,
                        initialCountryCode: "IN",
                        onCountryChanged: (phone) {
                          countryCode = phone.dialCode;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blueAccent,
                              width: 1.8,
                            ),
                          ),
                          contentPadding: EdgeInsets.all(12),
                        ),
                      ),
                      colum("Bank", bankController, null),
                      colum("Account No.", accountController, null),
                      colum("IFSC Code", ifscController, null),
                      const Gap(10),
                      RoundedLoadingButton(
                        controller: submitController,
                        successColor: Colors.blue,
                        color: Colors.blue,
                        onPressed: () {
                          String first =
                              result.name!.substring(0, 5).toLowerCase();
                          String last = Random().nextInt(9000).toString();
                          String sellerId = first + last;
                          phNo = "+$countryCode ${phoneController.text}";

                          final user = UserModel(
                            id: result.id,
                            name: result.name,
                            email: result.email,
                            imageUrl: result.imageUrl,
                            isSeller: true,
                            sellerId: sellerId,
                            dob: dob,
                            phNo: phNo,
                            bank: bankController.text,
                            accountNo: accountController.text,
                            ifsc: ifscController.text,
                            createdAt: result.createdAt,
                            updatedAt: DateTime.now().toString(),
                          );
                          verification(user);
                        },
                        child: const Text(
                          "Become a seller",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const SizedBox();
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future verification(UserModel userModel) async {
    debugPrint(phNo);
    FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phNo,
        verificationCompleted: (AuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (String verificationId, int? forceResendingToken) {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text(
                    "Enter Code",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  backgroundColor: Colors.white,
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: otpCodeController,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.password_sharp,
                              color: Colors.black,
                            ),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    const BorderSide(color: Colors.red)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    const BorderSide(color: Colors.grey)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    const BorderSide(color: Colors.grey))),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final code = otpCodeController.text.trim();
                          PhoneAuthProvider.credential(
                              verificationId: verificationId, smsCode: code);
                          DataBase.becomeSeller(userModel).then(
                            (value) => Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const BuyerModule()),
                                (route) => false),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue),
                        child: const Text(
                          "Confirm",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              });
        },
        codeAutoRetrievalTimeout: (String verification) {});
  }
}
