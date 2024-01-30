import 'package:flutter/material.dart';
import 'package:nft_marketplace/data%20manager/database_handler.dart';
import 'package:searchable_listview/searchable_listview.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> searchList = [];

  _getList() async {
    searchList = await DataBase.getSearchList();
  }

  @override
  void initState() {
    _getList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Search",
        ),
      ),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(10),
        child: SearchableList(
          initialList: [],
          filter: (value) => searchList
              .where(
                (element) => element.toLowerCase().contains(value),
              )
              .toList(),
          emptyWidget: const Center(
            child: Text("Not Found anything"),
          ),
          inputDecoration: InputDecoration(
            labelText: "Search Collection/User",
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.blue,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          builder: (list, index, item) {
            return Container(
              width: double.infinity,
              height: 50,
              margin: const EdgeInsets.only(bottom: 5),
              color: Colors.red,
              child: Text(
                list[index],
              ),
            );
          },
        ),
      ),
    );
  }
}
