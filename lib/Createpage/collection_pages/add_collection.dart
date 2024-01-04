import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nft_marketplace/Createpage/tabs/description_page.dart';
import 'package:nft_marketplace/colors.dart';
import 'package:nft_marketplace/provider/dropdown_provider.dart';
import 'package:provider/provider.dart';

import '../../data manager/database_handler.dart';
import '../../model/collection_model.dart';
import '../../provider/collection_provider.dart';

class AddCollectionPageWidget extends StatefulWidget {
  final bool isSingleNft;

  const AddCollectionPageWidget({super.key, required this.isSingleNft});

  @override
  State<AddCollectionPageWidget> createState() =>
      _AddCollectionPageWidgetState();
}

class _AddCollectionPageWidgetState extends State<AddCollectionPageWidget> {
  final title = TextEditingController();
  final description = TextEditingController();
  final category = TextEditingController();
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
          },
          icon: const Icon(Icons.arrow_back_sharp),
        ),
        title: const Text(
          "Make Collection",
          style: TextStyle(),
        ),
        forceMaterialTransparency: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            provider.images.isEmpty
                ? SizedBox(
                    height: 300,
                    width: 300,
                    child: GestureDetector(
                      onTap: () {
                        provider.pickImages(false);
                      },
                      child: DottedBorder(
                        color: ColorsData.black,
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
                                  provider.pickImages(false);
                                },
                                child: Text(
                                  widget.isSingleNft
                                      ? "choose NFTs"
                                      : "choose Thumbnail",
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
              height: 10,
            ),
            widget.isSingleNft
                ? const SizedBox()
                : Form(
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
                                return 'Please select gender.';
                              }
                              return null;
                            },
                            onChanged: (value) {},
                            onSaved: (value) => dropDownProvider.onSaved(value),
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
                            color: ColorsData.selectiveYellow,
                            onPressed: () async {
                              bool valid = formKey.currentState!.validate();
                              if (valid) {
                                if (provider.images.isNotEmpty) {
                                  final model = CollectionModel(
                                    name: title.text,
                                    description: description.text,
                                    thumbnail: provider.images.first,
                                    category: dropDownProvider.selectedCategory,
                                    items: [],
                                    createdBy: DataBase.user.uid,
                                  );
                                  DataBase.createCollection(model);
                                  title.text = "";
                                  provider.removeImage();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text("Please choose a Thumbnail"),
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
            widget.isSingleNft
                ? Align(
                    alignment: Alignment.center,
                    child: MaterialButton(
                      color: ColorsData.selectiveYellow,
                      onPressed: () async {
                        if (provider.images.first == "") {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please choose a Image"),
                              backgroundColor: Colors.red,
                            ),
                          );
                        } else {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NftDescriptionPageWidget(
                                imageUrl: provider.images.first,
                              ),
                            ),
                          );
                        }
                      },
                      child: const Text("Next"),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
