import 'dart:io';

import 'package:awesome_icons/awesome_icons.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nft_marketplace/provider/dropdown_provider.dart';
import 'package:nft_marketplace/utils/snack_bar.dart';
import 'package:nft_marketplace/wallet/net/wallet_data_manager.dart';
import 'package:provider/provider.dart';

import '../../data manager/database_handler.dart';
import '../../data_variables.dart';
import '../../model/collection_model.dart';
import '../../provider/collection_provider.dart';

class AddCollectionPageWidget extends StatefulWidget {
  const AddCollectionPageWidget({super.key});

  @override
  State<AddCollectionPageWidget> createState() =>
      _AddCollectionPageWidgetState();
}

class _AddCollectionPageWidgetState extends State<AddCollectionPageWidget> {
  final title = TextEditingController();
  final description = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CollectionProvider>(context);
    final dropDownProvider = Provider.of<DropDownProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            provider.removeImage();
            provider.removeBGImage();
          },
          icon: const Icon(Icons.arrow_back_sharp),
        ),
        title: const Text(
          "Make Collection",
          style: TextStyle(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: 300,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.yellow.shade100,
              ),
              child: const Text(
                "Warning : You can not delete or edit this collection after it created you can only add NFTs inside collection",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            const Gap(15),
            provider.images.isEmpty
                ? SizedBox(
                    height: 300,
                    width: 300,
                    child: GestureDetector(
                      onTap: () {
                        provider.pickImages(false, false);
                      },
                      child: DottedBorder(
                        color: Colors.black,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              MaterialButton(
                                height: 30,
                                minWidth: 40,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                    color: Colors.blueAccent,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                onPressed: () {
                                  provider.pickImages(false, false);
                                },
                                child: const Text(
                                  "choose Thumbnail",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : Image.file(
                    File(provider.images.first),
                    height: 300,
                    width: 300,
                    fit: BoxFit.cover,
                  ),
            const SizedBox(
              height: 15,
            ),
            provider.bgImage.isEmpty
                ? SizedBox(
                    height: 50,
                    width: 300,
                    child: TextButton(
                      style: ButtonStyle(
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: const BorderSide(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        provider.pickImages(false, true);
                      },
                      child: const Row(
                        children: [
                          Gap(10),
                          Icon(
                            FontAwesomeIcons.image,
                            color: Colors.black87,
                          ),
                          Gap(5),
                          Text(
                            "Choose a background image",
                            style:
                                TextStyle(color: Colors.black87, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  )
                : Image.file(
                    File(provider.bgImage),
                    height: 300,
                    width: 300,
                    fit: BoxFit.cover,
                  ),
            const SizedBox(
              height: 10,
            ),
            Form(
              key: formKey,
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    TextFormField(
                      controller: title,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "title must needed";
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder:
                            OutlineInputBorder(borderSide: BorderSide()),
                        hintText: "Enter the title",
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: description,
                      minLines: 2,
                      maxLines: null,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "description must needed";
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder:
                            OutlineInputBorder(borderSide: BorderSide()),
                        hintText: "Enter the description",
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DropdownButtonFormField2<String>(
                      isExpanded: true,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      hint: const Text(
                        'Select Your Category',
                        style: TextStyle(fontSize: 14),
                      ),
                      items: categoryList
                          .map(
                            (item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select category.';
                        }
                        return null;
                      },
                      onChanged: (value) =>
                          dropDownProvider.selectCatagory(value),
                      buttonStyleData: const ButtonStyleData(
                        padding: EdgeInsets.only(right: 8),
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black45,
                        ),
                        iconSize: 24,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                    const Gap(10),
                    DropdownButtonFormField2<String>(
                      isExpanded: true,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      hint: const Text(
                        'Select Your Chain',
                        style: TextStyle(fontSize: 14),
                      ),
                      items: chain
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select category.';
                        }
                        return null;
                      },
                      onChanged: (value) => dropDownProvider.selectChain(value),
                      buttonStyleData: const ButtonStyleData(
                        padding: EdgeInsets.only(right: 8),
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black45,
                        ),
                        iconSize: 24,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                    const Gap(10),
                    MaterialButton(
                      color: Colors.blue,
                      onPressed: () async {
                        bool valid = formKey.currentState!.validate();
                        if (valid) {
                          if (provider.images.isNotEmpty &&
                              provider.bgImage.isNotEmpty) {
                            if (await WalletDataManager.existWallet()) {
                              debugPrint(
                                  "selected Catagory is => ${dropDownProvider.selectedCategory}");

                              final model = CollectionModel(
                                name: title.text,
                                description: description.text,
                                thumbnail: provider.images.first,
                                chain: dropDownProvider.selectedChain,
                                bgImage: provider.bgImage,
                                category: dropDownProvider.selectedCategory,
                                items: [],
                                createdBy: user.uid,
                              );
                              DataBase.createCollection(model);
                              title.text = "";
                              description.text = "";
                              provider.removeImage();
                              provider.removeBGImage();
                              Navigator.pop(context);
                            } else {
                              openSnackBar(
                                  context, "create a wallet first", Colors.red);
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(provider.images.isEmpty
                                    ? "Please choose a thumbnail"
                                    : "Please choose a background image"),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        } else {
                          debugPrint("Hello");
                          formKey.currentState!.validate();
                        }
                      },
                      child: const Text("Add"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
