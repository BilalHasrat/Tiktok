import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:tiktok2/constants.dart';
import 'package:tiktok2/model/video_model.dart';
import 'package:video_compress/video_compress.dart';

class UploadVideoController extends GetxController {

  _compressedVideo(String videoPath) async {
    final compressedVideo = await VideoCompress.compressVideo(
        videoPath, quality: VideoQuality.MediumQuality);
    return compressedVideo!.file;
  }

  Future<String>_uploadVideoToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child('videos').child(id);
    UploadTask uploadTask = ref.putFile(await _compressedVideo(videoPath));
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  _getThumbnail(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

  Future<String>_uploadImageToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child('thumbnails').child(id);
    UploadTask uploadTask = ref.putFile(await _getThumbnail(videoPath));
    TaskSnapshot snapshot = await uploadTask;
    String getDownloadUrl = await snapshot.ref.getDownloadURL();
    return getDownloadUrl;
  }

  // upload video
  uploadVideo(String songName, String caption, String videoPath) async {
    try {
      String uid = firebaseAuth.currentUser!.uid;
      DocumentSnapshot userDoc = await fireStore.collection('users').doc(uid).get();
      // get video id
      var allDocs = await fireStore.collection('videos').get();
      int len = allDocs.docs.length;
      String videoUrl = await _uploadVideoToStorage('video $len', videoPath);
      String thumbnail = await _uploadImageToStorage('video $len', videoPath);
      print('-----yessss-----');
      Video video = Video(
        username: (userDoc.data()! as Map<String, dynamic>) ['name'],
        uid: uid,
        id: 'video $len',
        likes: [],
        commentCount: 0,
        shareCount: 0,
        songName: songName,
        caption: caption,
        videoUrl: videoUrl,
        thumbnail: thumbnail,
        profilePhoto:(userDoc.data()! as Map<String, dynamic>) ['profilePhoto'],);
      print('-----okkkkkkkkkkkk-----');
      await fireStore.collection('videos').doc('video $len').set(video.toJson());
      print('-----noooooooooooo-----');

      Get.back();
    } catch (e) {
      Get.snackbar('Error Uploading video', e.toString());
    }
  }
}