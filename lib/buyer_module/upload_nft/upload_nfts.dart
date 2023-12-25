import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gallery_picker/gallery_picker.dart';
import 'package:gap/gap.dart';
import 'package:nft_marketplace/colors.dart';

class UploadNftPageWidget extends StatefulWidget {
  final String type;

  const UploadNftPageWidget({super.key, required this.type});

  @override
  State<UploadNftPageWidget> createState() => _UploadNftPageWidgetState();
}

class _UploadNftPageWidgetState extends State<UploadNftPageWidget> {
  List<MediaFile>? mediaFile;

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
                  SizedBox(
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
                                      borderRadius: BorderRadius.circular(30)),
                                  onPressed: () {},
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
                          ),
                        ),
                      )),
                  const Gap(15),
                  SizedBox(
                      height: 300,
                      width: 300,
                      child: DottedBorder(
                        color: ColorsData.selectiveYellow,
                        child: Center(
                            child: mediaFile == null
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
                                            mediaFile =
                                                await GalleryPicker.pickMedia(
                                                    context: context,
                                                    singleMedia: true);
                                          },
                                          child:
                                              const Text("choose Thumbnail")),
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
                                : Padding(
                                    padding: EdgeInsets.all(5),
                                    // child: Image.file(),
                                  )),
                      ))
                ],
              )
            : SizedBox(
                height: 300,
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
                                borderRadius: BorderRadius.circular(30)),
                            onPressed: () {},
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
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
