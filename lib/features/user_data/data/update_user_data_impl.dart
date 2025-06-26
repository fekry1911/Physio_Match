import 'dart:io';

import 'package:add_ques/core/helpers/cache_helper.dart';
import 'package:add_ques/core/models/user_model.dart';
import 'package:add_ques/features/user_data/data/update_user_rebo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_selector/file_selector.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:supabase_flutter/supabase_flutter.dart';

class UpdateUserDataImpl implements UpdateUserRebo{

  FirebaseStorage fireStorage;
  FirebaseFirestore fireStore;
  UpdateUserDataImpl(this.fireStorage,this.fireStore);
  @override
  Future<void> UpdateUserData(UserModel userModel) async {
   await fireStore.collection("doctors").doc(FirebaseAuth.instance.currentUser!.uid).update(userModel.toMap());
  }


  @override
  Future<String?> UpdateUserImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return '🚫 لم يتم اختيار صورة';

      final file = File(pickedFile.path);
      final compressedBytes = await FlutterImageCompress.compressWithFile(
        file.path,
        quality: 70,
      );

      if (compressedBytes == null) return '❌ فشل في ضغط الصورة';

      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) return "❌ المستخدم غير مسجل دخول";

      final userFilePath = 'public/${uid}_profile.jpg';
      final storageRef = Supabase.instance.client.storage.from('images');

      await storageRef.uploadBinary(
        userFilePath,
        compressedBytes,
        fileOptions: const FileOptions(
          upsert: true,
          contentType: 'image/jpeg',
        ),
      );

      final imageUrl = storageRef.getPublicUrl(userFilePath);
      final refreshedUrl = '$imageUrl?${DateTime.now().millisecondsSinceEpoch}';

      await FirebaseAuth.instance.currentUser?.updatePhotoURL(refreshedUrl);

      print('✅ رابط الصورة الجديد: $refreshedUrl');
      return refreshedUrl;

    } catch (e) {
      print('❌ حدث خطأ أثناء تغيير الصورة: $e');
      return '❌ حدث خطأ أثناء تغيير الصورة';
    }
  }

  @override
  Future<String?> UpdateUser() async {
      try {
        final typeGroup = XTypeGroup(label: 'PDF', extensions: ['pdf']);
        final XFile? file = await openFile(acceptedTypeGroups: [typeGroup]);

        if (file == null) {
          print('🚫 لم يتم اختيار ملف');
          return '🚫 لم يتم اختيار ملف';
        }

        final fileBytes = await file.readAsBytes();
        final fileName = file.name;

        final sizeInMB = fileBytes.lengthInBytes / (1024 * 1024);
        print('📏 حجم CV: ${sizeInMB.toStringAsFixed(2)} MB');

        if (sizeInMB > 50) {
          print('❌ الملف أكبر من الحد المسموح به (50MB)');
          return '❌ الملف أكبر من الحد المسموح به (50MB)';
        }


        final uid = FirebaseAuth.instance.currentUser?.uid;
        if (uid == null) {
          print('❌ المستخدم غير مسجل دخول');
          return '❌ المستخدم غير مسجل دخول';
        }

        final userFilePath = '${uid}_cv.pdf'; // ✅ لا تضع "public/"
        final storageRef = Supabase.instance.client.storage.from('documents');

        await storageRef.uploadBinary(
          userFilePath,
          fileBytes,
          fileOptions: const FileOptions(
            upsert: true,
            contentType: 'application/pdf',
          ),
        );

        final publicUrl = storageRef.getPublicUrl(userFilePath);
        print('📄 تم رفع CV: $publicUrl');
        return publicUrl;

      } catch (e) {
        print('❌ Error: $e');
      }
    }




}