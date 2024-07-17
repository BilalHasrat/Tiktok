import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok2/controller/search_screen_controller.dart';
import 'package:tiktok2/view/screens/profile_screen.dart';

import '../../model/user_model.dart';
class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final SearchScreenController searchScreenController = Get.put(SearchScreenController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
            title: TextFormField(
              decoration: const InputDecoration(
                filled: false,
                hintText: 'Search',
                hintStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.white
                )
              ),
              onFieldSubmitted: (value){
                searchScreenController.searchUser(value);
              },
            ),
          ),
          body:searchScreenController.searchedUsers.isEmpty ?  const Center(
            child: Text('Search for Users! ',style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),),
          ): ListView.builder(
            itemCount: searchScreenController.searchedUsers.length,
              itemBuilder: (context, index){
              User user = searchScreenController.searchedUsers[index];
                return InkWell(
                  onTap: (){},
                  child: InkWell(
                    onTap: (){
                      Get.to(ProfileScreen(uid: user.uid));
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(user.profilePhoto),
                      ),
                      title: Text(user.name,style: const TextStyle(color: Colors.white,fontSize: 18),),
                    ),
                  ),
                );
              }),
        );
      }
    );
  }
}

