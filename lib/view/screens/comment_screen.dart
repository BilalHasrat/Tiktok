import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok2/controller/comment_controller.dart';
import 'package:timeago/timeago.dart' as tago;

import '../../constants.dart';

class CommentScreen extends StatelessWidget {
  final String id;
   CommentScreen({super.key, required this.id});
   final TextEditingController controller = TextEditingController();
   final CommentController commentController = Get.put(CommentController());

  @override
  Widget build(BuildContext context) {
    commentController.updatePostId(id);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Expanded(
                  child: Obx((){
                    return  ListView.builder(
                        itemCount: commentController.comments.length,
                        itemBuilder: (context, index){
                          var comment = commentController.comments[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.black,
                              backgroundImage: NetworkImage(comment.profilePhoto),
                            ),
                            title: Row(
                              children: [
                                Text(comment.username + ':',style: TextStyle(fontSize: 20,color: Colors.red,fontWeight: FontWeight.w700),),
                                SizedBox(width: 10,),
                                Text(comment.comment,style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.w700),),
                              ],),
                            subtitle: Row(
                              children: [
                                Text(tago.format(comment.datePublished.toDate()),style: TextStyle(color: Colors.white,fontSize: 12),),
                                SizedBox(width: 10,),
                                Text('${comment.likes.length} Likes',style: TextStyle(fontSize: 12,color: Colors.white),),
                              ],
                            ),
                            trailing: InkWell(
                              onTap: (){
                                commentController.likeComments(comment.id);
                              },
                              child: comment.likes.contains(authController.user.uid) ?
                              Icon(Icons.favorite,color: Colors.red,size: 25,) :
                              Icon(Icons.favorite_border,color: Colors.red,size: 25,),
                            ),
                          );
                        });
                  })
              ),
              const Divider(),
              ListTile(
                title: TextFormField(
                  controller: controller,
                  style: TextStyle(fontSize: 16,color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Comment',
                    labelStyle: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w700),

                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                ),
                trailing: TextButton(
                  onPressed: (){
                    commentController.postComment(controller.text);
                  }, child: Text('Send',style: TextStyle(fontSize: 16,color: Colors.white),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
