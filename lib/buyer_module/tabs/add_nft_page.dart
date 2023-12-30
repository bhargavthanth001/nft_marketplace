import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:nft_marketplace/buyer_module/data%20manager/database_handler.dart';
import 'package:nft_marketplace/buyer_module/model/collection_model.dart';
import 'package:nft_marketplace/buyer_module/provider/collection_provider.dart';
import 'package:nft_marketplace/colors.dart';
import 'package:provider/provider.dart';

class AddNftPageWidget extends StatefulWidget {
  const AddNftPageWidget({super.key});

  @override
  State<AddNftPageWidget> createState() => _AddNftPageWidgetState();
}

class _AddNftPageWidgetState extends State<AddNftPageWidget> {
  final title = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CollectionProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add NFT",
          style: TextStyle(),
        ),
        forceMaterialTransparency: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            provider.thumbnail.isEmpty
                ? SizedBox(
                    height: 300,
                    width: 300,
                    child: GestureDetector(
                      onTap: () {
                        provider.pickThumbnail(false);
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
                                  provider.pickThumbnail(true);
                                },
                                child: const Text("choose Thumbnail"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : Image.file(
                    File(provider.thumbnail),
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
                    MaterialButton(
                      color: ColorsData.selectiveYellow,
                      onPressed: () async {
                        bool valid = formKey.currentState!.validate();
                        if (valid) {
                          if (provider.thumbnail.isNotEmpty) {
                            final model = CollectionModel(
                              name: title.text,
                              thumbnail: provider.thumbnail,
                              createdBy: DataBase.user.uid,
                              items: [],
                            );
                            DataBase.createCollection(model);
                            Navigator.pop(context);
                            title.text = "";
                            provider.removeImage();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please choose a Thumbnail"),
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
