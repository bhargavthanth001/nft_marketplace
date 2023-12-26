import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_audio_player/widgets/players/basic_audio_player.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:just_audio/just_audio.dart';
import 'package:nft_marketplace/colors.dart';
import 'package:vimeo_video_player_custom/vimeo_video_player_custom.dart';

class UploadNftPageWidget extends StatefulWidget {
  final String type;

  const UploadNftPageWidget({super.key, required this.type});

  @override
  State<UploadNftPageWidget> createState() => _UploadNftPageWidgetState();
}

class _UploadNftPageWidgetState extends State<UploadNftPageWidget> {
  File? thumbnailImage;
  File? audioFile;
  File? file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Item"),
      ),
      body: Center(
        child: widget.type == "audio"
            ? Column(
                children: [
                  const Gap(20),
                  audioFile == null
                      ? SizedBox(
                          height: 150,
                          width: 300,
                          child: DottedBorder(
                            color: ColorsData.selectiveYellow,
                            child: Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MaterialButton(
                                    height: 30,
                                    minWidth: 40,
                                    shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                          color: Colors.blueAccent,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    onPressed: () async {
                                      pickAudio();
                                    },
                                    child: const Text("choose Audio")),
                                const Gap(8),
                                const Text(
                                  "Upload MP3, FLAC",
                                  style: TextStyle(color: Colors.black45),
                                ),
                                const Gap(5),
                                const Text(
                                  "File size - Max 20mb",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            )),
                          ),
                        )
                      : Container(
                          height: 135,
                          width: 300,
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: ColorsData.selectiveYellow,
                          ),
                          child: BasicAudioPlayer(
                            autoPlay: false,
                            playlist: ConcatenatingAudioSource(
                              children: [
                                AudioSource.uri(
                                  Uri.parse(
                                    audioFile!.path,
                                  ),
                                  tag: thumbnailImage != null
                                      ? MediaItem(
                                          id: '1',
                                          artUri: Uri.parse(
                                            thumbnailImage!.path,
                                          ),
                                          title: 'Audio Title ',
                                          album: 'amazing album')
                                      : MediaItem(
                                          id: '1',
                                          artUri: Uri.parse(
                                              "assets/images/logo.jpg"),
                                          title: 'Audio Title ',
                                          album: 'amazing album'),
                                ),
                              ],
                            ),
                          ),
                        ),
                  const Gap(15),
                  SizedBox(
                    height: 300,
                    width: 300,
                    child: DottedBorder(
                      color: ColorsData.selectiveYellow,
                      child: Center(
                        child: thumbnailImage == null
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  MaterialButton(
                                      height: 30,
                                      minWidth: 40,
                                      shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                            color: Colors.blueAccent,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      onPressed: () async {
                                        pickProfileFromGallary();
                                      },
                                      child: const Text("choose Thumbnail")),
                                  const Gap(8),
                                  const Text(
                                    "Upload PNG,GIF,JPG,JPEG",
                                    style: TextStyle(color: Colors.black45),
                                  ),
                                  const Gap(5),
                                  const Text(
                                    "File size - Max 25mb",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              )
                            : Container(
                                height: 300,
                                width: 300,
                                margin: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: FileImage(
                                      File(thumbnailImage!.path),
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                      ),
                    ),
                  )
                ],
              )
            : SizedBox(
                height: 300,
                width: 300,
                child: DottedBorder(
                  color: ColorsData.selectiveYellow,
                  child: Center(
                      child: file == null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MaterialButton(
                                    height: 30,
                                    minWidth: 40,
                                    shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                          color: Colors.blueAccent,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    onPressed: () {
                                      if (widget.type == "video") {
                                        pickVideo();
                                      } else {
                                        pickProfileFromGallary();
                                      }
                                    },
                                    child: widget.type == "image"
                                        ? const Text("choose image")
                                        : const Text("choose video")),
                                const Gap(8),
                                Text(
                                  widget.type == "image"
                                      ? "Upload PNG,GIF,JPG,JPEG"
                                      : "Upload MP4, WAV",
                                  style: const TextStyle(color: Colors.black45),
                                ),
                                const Gap(5),
                                Text(
                                  widget.type == "image"
                                      ? "File size - Max 25mb"
                                      : "File size - Max 100mb",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            )
                          : Container(
                              height: 300,
                              width: 300,
                              padding: const EdgeInsets.all(10),
                              child: widget.type == "image"
                                  ? Image.file(
                                      File(
                                        file!.path,
                                      ),
                                      fit: BoxFit.cover,
                                    )
                                  : VimeoVideoPlayer(
                                      url: file!.path,
                                      // onFinished: () => onFinishedVimeo(),
                                    ),
                            )),
                ),
              ),
      ),
    );
  }

  Future pickProfileFromGallary() async {
    final thumbnailImagePicker = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        "PNG",
        "GIF",
        "JPG",
        "JPEG",
      ],
    );
    debugPrint('image path');
    setState(() {
      file = File(thumbnailImagePicker!.files.single.path!);
    });
  }

  Future pickAudio() async {
    final thumbnailImagePicker = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: [
      "MP3",
      "FLAC",
    ]);
    debugPrint('image path');
    setState(() {
      audioFile = File(thumbnailImagePicker!.files.single.path!);
    });
  }

  Future pickVideo() async {
    final thumbnailImagePicker = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: [
      "MP4",
      "WAV",
    ]);
    debugPrint('image path');
    setState(() {
      file = File(thumbnailImagePicker!.files.single.path!);
    });
  }
}
