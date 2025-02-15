import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok2/constants.dart';
import 'package:tiktok2/controller/video_controller.dart';
import 'package:tiktok2/view/screens/comment_screen.dart';
import 'package:tiktok2/view/widgets/circle_animation_wedget.dart';
import 'package:tiktok2/view/widgets/video_player_item.dart';

class VideoScreen extends StatelessWidget {
   VideoScreen({super.key});
   final VideoController videoController = Get.put(VideoController());


   buildProfile(String profileUrl) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Stack(
        children: [
          Positioned(
              left: 5,
              child: Container(
                height: 50,
                width: 50,
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image(image: NetworkImage(profileUrl),fit: BoxFit.cover,)),
              ))
        ],
      ),
    );
  }

  buildMusic(String profile){
    return SizedBox(
      width: 60,
      height: 60,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(11),
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Colors.grey,
                  Colors.white
                ]
              ),
              borderRadius: BorderRadius.circular(25),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child:  Image(image: NetworkImage(profile),
              fit: BoxFit.cover,),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Obx(() {
        return PageView.builder(
            controller: PageController(initialPage: 0, viewportFraction: 1),
            itemCount: videoController.videoList.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final data = videoController.videoList[index];
              return Stack(
                children: [
                  VideoPlayerItem(videoUrl: data.videoUrl),
                  Column(
                    children: [
                      const SizedBox(height: 100,),
                      Expanded(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 20),
                                    child:  Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Text(data.username,
                                          style: const TextStyle(fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),),

                                        Text(data.caption,
                                          style: const TextStyle(fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),),

                                        Row(
                                          children: [
                                            const Icon(Icons.music_note, size: 15,
                                              color: Colors.white,),
                                            Text(data.caption, style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),)
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                              ),
                              Container(
                                width: 100,
                                margin: EdgeInsets.only(top: size.height / 5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceEvenly,
                                  children: [
                                    buildProfile(data.profilePhoto),
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            videoController.likeVideo(data.id);
                                          },
                                          child:  Icon(
                                            Icons.favorite, color:data.likes.contains(authController.user.uid) ? Colors.red :   Colors.white,
                                            size: 40,),
                                        ),
                                        const SizedBox(height: 7,),
                                         Text(data.likes.length.toString(), style:  const TextStyle(
                                            fontSize: 20,
                                            color: Colors.white),),
                                        const SizedBox(height: 7,),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Get.to(CommentScreen(id: data.id,));
                                          },
                                          child:  const Icon(
                                            Icons.message, 
                                            color: Colors.white,
                                            size: 40,),
                                        ),
                                        const SizedBox(height: 7,),

                                         Text(data.commentCount.toString(), style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.white),),
                                        const SizedBox(height: 7,),
                                      ],
                                    ), Column(
                                      children: [
                                        InkWell(
                                          onTap: () {},
                                          child: const Icon(
                                            Icons.reply, color: Colors.white,
                                            size: 40,),
                                        ),
                                        const SizedBox(height: 7,),

                                         Text(data.shareCount.toString(), style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.white),),
                                        const SizedBox(height: 7,),
                                      ],
                                    ),
                                    CircleAnimation(
                                        child: buildMusic(data.profilePhoto))
                                  ],
                                ),
                              )
                            ],
                          )
                      )
                    ],
                  )
                ],
              );
            });
      }
      ),
    );
  }
}
