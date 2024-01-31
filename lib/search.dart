import 'package:flutter/material.dart';
import 'package:nft_marketplace/provider/search_provider.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SearchProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Search",
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 50,
              width: 340,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 0),
                    color: Colors.black12,
                    blurRadius: 5,
                  )
                ],
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 290,
                    child: TextFormField(
                      controller: provider.searchController,
                      onChanged: (value) => {provider.onChange()},
                      decoration: const InputDecoration(
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 10),
                        hintText: "Search Collection/User...",
                      ),
                    ),
                  ),
                  if (provider.searchController.text == "")
                    IconButton(
                      onPressed: () {
                        if (provider.searchController.text == "") {}
                      },
                      icon: const Icon(
                        Icons.search,
                        color: Colors.blue,
                      ),
                    )
                  else
                    IconButton(
                      onPressed: () {
                        provider.clearSearch();
                      },
                      icon: const Icon(
                        Icons.cancel_outlined,
                        color: Colors.blue,
                      ),
                    )
                ],
              ),
            ),
            provider.searchController.text == ""
                ? const SizedBox()
                : Expanded(
                    child: ListView.builder(
                      itemCount: provider.filteredList().length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(provider.filteredList()[index]),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
