import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_image_picker_plus/multi_image_picker_plus.dart';
import 'package:nft_marketplace/colors.dart';
import 'package:path_provider/path_provider.dart';

class CollectionProvider extends ChangeNotifier {
  List<String> _images = [];

  List<String> get images => _images;

  Future pickImages(bool isMultiple) async {
    List<Asset> resultList = [];
    List<File> files = [];
    resultList = await MultiImagePicker.pickImages(
      materialOptions: MaterialOptions(
        maxImages: isMultiple ? null : 1,
        enableCamera: true,
        allViewTitle: "All Photos",
        useDetailsView: false,
        statusBarColor: ColorsData.selectiveYellow,
        actionBarColor: ColorsData.selectiveYellow,
      ),
    );
    for (Asset asset in resultList) {
      final ByteData byteData = await asset.getByteData();
      final List<int> byteList = byteData.buffer.asUint8List();
      final docDir = await getApplicationDocumentsDirectory();
      final File file = File("${docDir.path}/${asset.name}");
      await file.writeAsBytes(byteList);
      debugPrint(file.toString());
      files.add(file);
    }
    _images = files.map((file) => file.path).toList();

    notifyListeners();
  }

  Future removeImage() async {
    _images = [];
    notifyListeners();
  }
}
