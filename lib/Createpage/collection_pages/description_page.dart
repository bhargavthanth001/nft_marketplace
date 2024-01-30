import 'dart:math';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nft_marketplace/data%20manager/database_handler.dart';
import 'package:nft_marketplace/model/nft_model.dart';
import 'package:nft_marketplace/provider/collection_provider.dart';
import 'package:provider/provider.dart';

import '../../data_variables.dart';
import '../../provider/dropdown_provider.dart';

class NftDescriptionPageWidget extends StatelessWidget {
  final String imageUrl;

  NftDescriptionPageWidget({
    super.key,
    required this.imageUrl,
  });

  final title = TextEditingController();
  final description = TextEditingController();
  final price = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CollectionProvider>(context);
    final dropDownProvider = Provider.of<DropDownProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "NFT Details ",
          style: TextStyle(),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  controller: title,
                  maxLines: 1,
                  decoration: const InputDecoration(
                    hintText: "Enter the title",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const Gap(15),
                TextFormField(
                  controller: description,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    hintText: "Enter the description",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const Gap(15),
                DropdownButtonFormField2<String>(
                  isExpanded: true,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  hint: const Text(
                    'Select Your Category',
                    style: TextStyle(fontSize: 14),
                  ),
                  items: categoryList
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
                  onChanged: (value) {},
                  onSaved: (value) => dropDownProvider.selectCatagory(value),
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
                const Gap(15),
                DropdownButtonFormField2<String>(
                  isExpanded: true,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
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
                  onChanged: (value) {},
                  onSaved: (value) => dropDownProvider.selectChain(value),
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
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: MaterialButton(
                      color: Colors.blue,
                      onPressed: () {
                        for (var image in provider.images) {
                          Random random = Random();
                          String id = random.nextInt(1000).toString();
                          final nftModel = NftModel(
                            id: id,
                            title: title.text,
                            description: description.text,
                            currentOwner: user.uid,
                            category: dropDownProvider.selectedCategory,
                            chain: dropDownProvider.selectedChain,
                            owners: [
                              user.uid,
                            ],
                            imageUrl: image,
                            createdBy: user.uid,
                            createdAt: DateTime.now().toString(),
                            updatedAt: DateTime.now().toString(),
                          );

                          DataBase.addNft(nftModel);
                        }
                        Navigator.pop(context);
                      },
                      child: const Text("Next"),
                    ),
                  ),
                ),
                const Gap(5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
