import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MorePage extends StatelessWidget {
  const MorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "More",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            backgroundColor: Colors.white,
          ),
        ),
      ),
      body: const Column(
        children: [],
      ),
    );
  }
}
