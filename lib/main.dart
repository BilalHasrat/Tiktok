
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:tiktok2/constants.dart';
import 'package:tiktok2/view/screens/auth/login_screen.dart';

import 'controller/auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyDCCmketASP_JxQMvz7jxQmm5p_xW_rmUM",
        appId: "1:342388099801:android:489def47d2d826c8514cc8",
        messagingSenderId: "342388099801",
        projectId: "tiktok2-b9330",
        storageBucket:'tiktok2-b9330.appspot.com'
    )
  ).then((value){
    Get.put(AuthController());
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor
      ),
      debugShowCheckedModeBanner: false,
      home:  LoginScreen(),
    );
  }
}
