import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

Future<double?> getPrice(String id) async {
  try {
    var url = "https://api.coingecko.com/api/v3/coins/" + id;
    var response = await http.get(Uri.parse(url));
    var json = jsonDecode(response.body);
    debugPrint("API Data is => $json");
    var value = json['market_data']['current_price']['usd'].toString();
    return double.parse(value);
  } catch (e) {
    print(e.toString());
  }
}
