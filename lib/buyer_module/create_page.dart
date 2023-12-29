import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nft_marketplace/buyer_module/tabs/add_collection.dart';
import 'package:nft_marketplace/buyer_module/tabs/collaction_page_tab.dart';
import 'package:nft_marketplace/buyer_module/tabs/single_page_tab.dart';
import 'package:nft_marketplace/colors.dart';

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
        tabBarProperties: const TabBarProperties(
          height: 40,
          indicatorColor: ColorsData.black,
          labelColor: ColorsData.black,
          indicatorSize: TabBarIndicatorSize.tab,
          padding: EdgeInsets.zero,
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
                builder: (context) => const AddCollectionPageWidget(),
              ),
            );
          } else {
            debugPrint("single NFTs");
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
