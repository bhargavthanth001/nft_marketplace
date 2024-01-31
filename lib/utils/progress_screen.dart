import 'package:flutter/material.dart';

Widget progressIndicatorScreen(BuildContext context) {
  Future.delayed(const Duration(seconds: 2), () {
    Navigator.pop(context);
  });
  return SafeArea(
      child: Container(
    width: double.infinity,
    height: double.infinity,
    color: Colors.black12,
    child: const Center(
      child: CircularProgressIndicator(),
    ),
  ));
}
