import 'dart:core';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';

class PickerProvider extends ChangeNotifier {
  String _audioFile = "";
  String _imageFile = "";
  String _thumbnailFile = "";
  bool _isImagePicked = false;
  bool _isAudioPicked = false;

  String get audioFile => _audioFile;

  String get imageFile => _imageFile;

  String get thumbnailFile => _thumbnailFile;

  bool get isImagePicked => _isImagePicked;

  bool get isAudioPicked => _isAudioPicked;

  Future pickImage(bool isThumbnail) async {
    debugPrint("value is => $isThumbnail");
    final filePicker = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        "PNG",
        "GIF",
        "JPG",
        "JPEG",
      ],
    );
    if (isThumbnail) {
      _thumbnailFile = File(filePicker!.files.single.path!).path;
      _isImagePicked = true;

      notifyListeners();
    } else {
      _imageFile = File(filePicker!.files.single.path!).path;
      _isImagePicked = true;

      notifyListeners();
    }
    debugPrint("path is => $_thumbnailFile");
    debugPrint("path2 is => $_imageFile");
  }

  Future pickAudio() async {
    final filePicker = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        "MP3",
        "FLAC",
      ],
    );
    _audioFile = File(filePicker!.files.single.path!).path;
    _isAudioPicked = true;
    notifyListeners();
  }
}
