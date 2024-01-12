import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';

void openSnackBar(context, snackMessage, color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      action: SnackBarAction(
        label: "OK",
        textColor: Colors.white,
        onPressed: () {},
      ),
      content: Text(
        snackMessage,
        style: const TextStyle(fontSize: 14),
      ),
    ),
  );
}

String generateRandomToken() {
  final randomBytes = _generateRandomBytes();
  final base64String = base64UrlEncode(randomBytes);
  return base64String;
}

Uint8List _generateRandomBytes({int length = 32}) {
  final random = Random.secure();
  final bytes = Uint8List(length);
  for (int i = 0; i < length; i++) {
    bytes[i] = random.nextInt(256);
  }
  return bytes;
}
