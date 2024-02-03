import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'Createpage/collection_pages/add_collection.dart';
import 'Createpage/tabs/collaction_page_tab.dart';
import 'Createpage/tabs/single_page_tab.dart';

class CreatePageWidget extends StatefulWidget {
  const CreatePageWidget({super.key});

  @override
  State<CreatePageWidget> createState() => _CreatePageWidgetState();
}

class _CreatePageWidgetState extends State<CreatePageWidget>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  bool isCollection = true;
  List<Widget> myTabs = [
    const CollectionTab(),
    const SingleNftTab(),
  ];

  @override
  void initState() {
    tabController = TabController(vsync: this, length: myTabs.length);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "NFTs",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Gap(3),
            Text(
              "collections",
            ),
          ],
        ),
      ),
      body: ContainedTabBarView(
        tabBarProperties: TabBarProperties(
          height: 40,
          background: Container(
            color: Colors.blue,
          ),
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,
          padding: EdgeInsets.zero,
          unselectedLabelColor: Colors.white.withOpacity(0.85),
        ),
        tabs: const [
          Text('Collections'),
          Text('Single NFTs'),
        ],
        views: myTabs,
        onChange: (index) => {
          isCollection = !isCollection,
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (isCollection) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddCollectionPageWidget(
                  isSingleNft: false,
                ),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    const AddCollectionPageWidget(isSingleNft: true),
              ),
            );
          }
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
