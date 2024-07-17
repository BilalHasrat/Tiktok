
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok2/constants.dart';
import 'package:tiktok2/model/user_model.dart' as model;

import '../view/screens/auth/login_screen.dart';
import '../view/screens/home_screen.dart';

class AuthController extends GetxController{

  static AuthController instance = Get.find();

  late Rx<User?> _user;
  late Rx<File?> _pickedImage;
  File? get profilePhoto => _pickedImage.value;
  User get user => _user.value!;
  // ye initstate jaisa kam karta he ye current user ko check karay ga ke login pe jana he ya homescreen pe
  @override
  void onReady() {
    _user  = firebaseAuth.currentUser.obs;
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialScreen);
    super.onReady();
  }
  _setInitialScreen(User? user){
    if(user == null){
      Get.offAll( LoginScreen());
    }else{
      Get.offAll(const HomeScreen());
    }
  }


  // Picking image from gallary
  void pickImage()async{
    final pickedImage  = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(pickedImage != null){
      Get.snackbar('Profile Picture', 'Select Successfully');
    }
    _pickedImage = File(pickedImage!.path).obs;
  }

  // Upload Image to firebase Storage
  Future<String> _uploadToStorage(File image)async{

    Reference ref = firebaseStorage.ref().child('profilePic').child(firebaseAuth.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);

    TaskSnapshot snapshot = await uploadTask;

    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }


  // Registering  User
  void registerUser(String userName, String email, String password, File? image)async{
    try{
      if(userName.isNotEmpty && email.isNotEmpty && password.isNotEmpty && image != null){

        // To save user to the Auth and fireStore Database
        UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

        String downloadUrl = await _uploadToStorage(image);

        model.User user = model.User(name: userName , email: email,uid: userCredential.user!.uid, profilePhoto: downloadUrl);

        await fireStore.collection('users').doc(userCredential.user!.uid).set(user.toJson());

      }else{
        Get.snackbar('Error Creating Account', 'Please Enter all the fields');
      }
    }catch(e){
      Get.snackbar('Error Creating Account', e.toString());
    }
  }


  // For Logging User
  void loginUser(String email, String password)async{
    try{
      if(email.isNotEmpty && password.isNotEmpty){

       await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
       print('Login success');

      }else{
        Get.snackbar('Error', 'Please enter all the Fields');
      }
    }catch(e){
      Get.snackbar('Error in Logging', e.toString());
    }
  }

  void signOut()async{
    await firebaseAuth.signOut();
  }

}