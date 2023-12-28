import 'package:flutter/material.dart';
import 'package:nft_marketplace/buyer_module/create_page.dart';
import 'package:nft_marketplace/buyer_module/data%20manager/database_handler.dart';
import 'package:nft_marketplace/colors.dart';

class AddCollectionPageWidget extends StatefulWidget {
  const AddCollectionPageWidget({super.key});

  @override
  State<AddCollectionPageWidget> createState() =>
      _AddCollectionPageWidgetState();
}

class _AddCollectionPageWidgetState extends State<AddCollectionPageWidget> {
  final title = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Make Collection",
          style: TextStyle(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey,
                ),
                child: const Center(
                  child: Icon(
                    Icons.folder_copy_rounded,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Form(
                key: formKey,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
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
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const CreatePageWidget()),
                                (route) => false);
                            DataBase.createCollection(title.text);
                            title.text = "";
                          } else {
                            debugPrint("Hello");
                            formKey.currentState!.validate();
                          }
                        },
                        child: const Text("Add"),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
