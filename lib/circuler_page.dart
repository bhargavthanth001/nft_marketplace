import 'dart:async';

import 'package:flutter/material.dart';

class CircularPageIndicator extends StatefulWidget {
  const CircularPageIndicator({super.key});

  @override
  State<CircularPageIndicator> createState() => _CircularPageIndicatorState();
}

class _CircularPageIndicatorState extends State<CircularPageIndicator> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      Navigator.pop(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 50,
        width: 50,
        child: CircularProgressIndicator(
          color: Colors.blue,
        ),
      ),
    );
  }
}
