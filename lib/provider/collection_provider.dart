import 'dart:core';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';

class CollectionProvider extends ChangeNotifier {
  String _thumbnail = "";

  String get thumbnail => _thumbnail;

  Future pickThumbnail(bool isMultiple) async {
    final filePicker = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: isMultiple,
      allowedExtensions: [
        "PNG",
        "GIF",
        "JPG",
        "JPEG",
      ],
    );
    _thumbnail = File(filePicker!.files.single.path!).path;
    notifyListeners();
  }

  Future removeImage() async {
    _thumbnail = "";
    notifyListeners();
  }
}
