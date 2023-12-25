import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  // ignore: non_constant_identifier_names
  TextWidget(String text) {
    return Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    );
  }

  ContainerWidget() {
    return Container(
      height: 230,
      width: 180,
      decoration: BoxDecoration(
        color: Colors.deepPurple,
        borderRadius: BorderRadius.circular(15),
        image: const DecorationImage(
          image: NetworkImage(
              "https://img.freepik.com/premium-vector/create-nft-using-vr-tech_701961-5324.jpg?size=626&ext=jpg&ga=GA1.1.1828301296.1702556871&semt=ais"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          const Spacer(),
          Container(
            height: 80,
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 0),
                    color: Colors.black12,
                    blurRadius: 5,
                  )
                ]),
            child: const Column(
              children: [
                Gap(5),
                Text(
                  "Bhargav Thanth TYBCA",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Search",
          ),
        ),
        body: SafeArea(
          child: ListView.builder(itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.all(5),
              height: 100,
              width: 360,
              color: Colors.red,
            );
          }),
        ));
  }
}
