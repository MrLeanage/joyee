import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:joyee/utils/custom_widgets/toastMessage.dart';

class FirebaseApiService{

    Future<bool> uploadFiles(Map<String, File> mapFiles, String userID) async {
     FirebaseStorage storage = FirebaseStorage.instance;

    // var imageUrls = await Future.wait(mapFiles.forEach((_image) => uploadSingleFile(_image)));

    List<String> imageURLList = [];
     try{
        mapFiles.forEach((key, value) async {


        Reference ref = storage.ref().child('image_files/$userID/' +key);
        UploadTask uploadTask = ref.putFile(value);
        // uploadTask.then((res) {
        //   return res.ref.getDownloadURL();
        // });
        final snapshot = await uploadTask.whenComplete(() {});

        imageURLList.add(await snapshot.ref.getDownloadURL());


      });
     return true;
   }on Exception catch(ignoredException){
          ToastMessage.showErrorToast("Error Occurred while Retrieving Data. Please Try again");
   }
   return false;

  }

   UploadTask? uploadSingleImage(String key, File value, String userID){
    FirebaseStorage storage = FirebaseStorage.instance;
     try{
       Reference ref = storage.ref().child('image_files/$userID/' +key);
       return ref.putFile(value);

     }on FirebaseException catch(e){
       return null;
     }
  }

   Future<UploadTask?> uploadImageList(Map<String, File> mapFiles, String userID) async{
    UploadTask? task;
    try{
      mapFiles.forEach((key, value) async {
       task = uploadSingleImage(key, value, userID)!;
      });
    }on Exception catch(ignoredException){
      ToastMessage.showErrorToast("Error Occurred while Retrieving Data. Please Try again");
    }
    return task;
  }
}