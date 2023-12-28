import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:audio_service/audio_service.dart';
// ignore: depend_on_referenced_packages
import 'package:dotted_border/dotted_border.dart';
// ignore: depend_on_referenced_packages
import 'package:easy_audio_player/widgets/players/basic_audio_player.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:gap/gap.dart';
// ignore: depend_on_referenced_packages
import 'package:just_audio/just_audio.dart';
import 'package:nft_marketplace/buyer_module/provider/pick_provider.dart';
import 'package:nft_marketplace/buyer_module/upload_nft/description_page.dart';
import 'package:nft_marketplace/colors.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

class UploadNftPageWidget extends StatefulWidget {
  final String type;

  const UploadNftPageWidget({super.key, required this.type});

  @override
  State<UploadNftPageWidget> createState() => _UploadNftPageWidgetState();
}

class _UploadNftPageWidgetState extends State<UploadNftPageWidget> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PickerProvider>(context);
    debugPrint(provider.imageFile);
    bool isNext = false;
    if (provider.thumbnailFile != "" &&
        provider.audioFile != "" &&
        provider.imageFile != "") {
      isNext = true;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Item"),
      ),
      body: Center(
        child: widget.type == "audio"
            ? Column(
                children: [
                  const Gap(20),
                  provider.audioFile == ""
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
                                      provider.pickAudio();
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
                                    provider.audioFile,
                                  ),
                                  tag: provider.imageFile != ""
                                      ? MediaItem(
                                          id: '1',
                                          artUri: Uri.parse(
                                            provider.imageFile,
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
                        child: provider.thumbnailFile == ""
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
                                        provider.pickImage(true);
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
                                      File(provider.thumbnailFile),
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  provider.isImagePicked && provider.isAudioPicked
                      ? Padding(
                          padding: const EdgeInsets.only(right: 25),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: MaterialButton(
                              color: ColorsData.selectiveYellow,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            NftDescriptionPageWidget()));
                              },
                              child: const Text("Next"),
                            ),
                          ),
                        )
                      : const SizedBox(),
                  const Gap(20),
                ],
              )
            : SizedBox(
                height: 300,
                width: 300,
                child: DottedBorder(
                  color: ColorsData.selectiveYellow,
                  child: Center(
                    child: provider.imageFile == ""
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
                                    borderRadius: BorderRadius.circular(30)),
                                onPressed: () {
                                  provider.pickImage(false);
                                },
                                child: const Text("choose image"),
                              ),
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
                                  File(provider.imageFile),
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                  ),
                ),
              ),
      ),
    );
  }
}
