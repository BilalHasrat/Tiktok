import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok2/controller/upload_video_controller.dart';
import 'package:tiktok2/view/widgets/text_intput_feild.dart';
import 'package:video_player/video_player.dart';

class ConfirmScreen extends StatefulWidget {
  final File videoFile;
  final String videoPath;
  const ConfirmScreen({super.key,
    required this.videoFile,
    required this.videoPath
  });

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  late VideoPlayerController controller;
  final songNameController = TextEditingController();
  final captionController = TextEditingController();
  final videoController  =  Get.put(UploadVideoController());

  @override
  void initState() {
    setState(() {
      controller = VideoPlayerController.file(widget.videoFile);
    });
    controller.initialize();
    controller.play();
    controller.setVolume(1);
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [

            const SizedBox(height: 30,),

            SizedBox(
              height: MediaQuery.of(context).size.height/1.5,
              width: MediaQuery.of(context).size.width,
              child: VideoPlayer(controller),
            ),

            const SizedBox(height: 30,),

            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width - 20,
                    child: TextInputField(
                      controller: songNameController,
                      labelText: 'Song Name',
                      icon: Icons.music_note,
                    ),
                  ),

                  const SizedBox(height: 10,),

                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width - 20,
                    child: TextInputField(
                      controller: captionController ,
                      labelText: 'Caption',
                      icon: Icons.closed_caption,
                    ),
                  ),
                  ElevatedButton(
                      onPressed: ()=>
                        videoController.uploadVideo(songNameController.text, captionController.text, widget.videoPath),
                      child: const Text('Share',
                        style: TextStyle(fontSize: 20,color: Colors.white),))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
