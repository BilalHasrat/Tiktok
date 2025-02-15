import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tiktok2/controller/auth_controller.dart';
import 'package:tiktok2/view/screens/add_video_screen.dart';
import 'package:tiktok2/view/screens/profile_screen.dart';
import 'package:tiktok2/view/screens/search_screen.dart';
import 'package:tiktok2/view/screens/video_screen.dart';


List pages = [
  VideoScreen(),
  SearchScreen(),
  const AddVideoScreen(),
  Text('Message Screen'),
  ProfileScreen(uid: authController.user.uid),
];

// COLORS
const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;

// Firebase instances
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var fireStore = FirebaseFirestore.instance;

// Controller
var authController = AuthController.instance;
