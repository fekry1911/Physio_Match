import 'dart:io';

import 'package:add_ques/core/helpers/cache_helper.dart';
import 'package:add_ques/core/models/user_model.dart';
import 'package:add_ques/features/user_data/data/update_user_rebo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class UpdateUserDataImpl implements UpdateUserRebo{

  FirebaseStorage fireStorage;
  FirebaseFirestore fireStore;
  UpdateUserDataImpl(this.fireStorage,this.fireStore);
  @override
  Future<void> UpdateUserData(UserModel userModel) async {
   await fireStore.collection("users").doc(CacheHelper.getString(key: "uid")).update(userModel.toMap());
  }

  @override
  Future<String?> UpdateUserImage() async {
      final picker = ImagePicker();

      // Pick image from gallery
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        File file = File(pickedFile.path);

        try {
          // Create unique file name using timestamp
          String fileName = DateTime.now().millisecondsSinceEpoch.toString();

          // Upload to Firebase Storage
          Reference ref = FirebaseStorage.instance.ref().child('user_images/$fileName.jpg');
          UploadTask uploadTask = ref.putFile(file);

          // Wait until upload is complete and get download URL
          TaskSnapshot snapshot = await uploadTask;
          String downloadUrl = await snapshot.ref.getDownloadURL();

          print('Image uploaded. URL: $downloadUrl');
          return downloadUrl;
        } catch (e) {
          print('Upload error: $e');
          return null;
        }
      } else {
        print('No image selected.');
        return null;
      }
    }

}