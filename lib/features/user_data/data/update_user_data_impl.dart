import 'dart:io';

import 'package:add_ques/core/helpers/cache_helper.dart';
import 'package:add_ques/core/models/user_model.dart';
import 'package:add_ques/features/doctor/presentaion/screens/home_screen/data/models/post_model.dart';
import 'package:add_ques/features/user_data/data/update_user_rebo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_selector/file_selector.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../doctor/data/models/doctor_model.dart';

class UpdateUserDataImpl implements UpdateUserRebo {
  FirebaseFirestore fireStore;

  UpdateUserDataImpl( this.fireStore);

  @override
  Future<void> UpdateUserData(DoctorModel userModel) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final docRef = fireStore.collection("doctors").doc(uid);

    // اقرأ البيانات القديمة
    final snapshot = await docRef.get();
    final oldData = snapshot.data() ?? {};

    // البيانات الجديدة
    final newData = userModel.toMap();

    // دمج الجديد على القديم (مع تجاهل القيم null)
    final merged = {
      ...oldData,
      ...newData..removeWhere((key, value) => value == null),
    };

    // حدّث بالبيانات المدموجة
    await docRef.update(merged);
  }


  @override
  Future<String?> UpdateUserImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      // ✅ لو المستخدم ما اختارش صورة، رجّع null
      if (pickedFile == null) return null;

      final file = File(pickedFile.path);
      final compressedBytes = await FlutterImageCompress.compressWithFile(
        file.path,
        quality: 70,
      );

      if (compressedBytes == null) return null;

      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) return null;

      final userFilePath = 'public/${uid}_profile.jpg';
      final storageRef = Supabase.instance.client.storage.from('images');

      await storageRef.uploadBinary(
        userFilePath,
        compressedBytes,
        fileOptions: const FileOptions(upsert: true, contentType: 'image/jpeg'),
      );

      final imageUrl = storageRef.getPublicUrl(userFilePath);
      final refreshedUrl = '$imageUrl?${DateTime.now().millisecondsSinceEpoch}';

      await FirebaseAuth.instance.currentUser?.updatePhotoURL(refreshedUrl);

      print('✅ رابط الصورة الجديد: $refreshedUrl');
      return refreshedUrl;

    } catch (e) {
      print('❌ حدث خطأ أثناء تغيير الصورة: $e');
      return null; // ✅ خلي الخطأ كمان يرجع null
    }
  }

  @override
  Future<String?> UpdateUser() async {
    try {
      final typeGroup = XTypeGroup(label: 'PDF', extensions: ['pdf']);
      final XFile? file = await openFile(acceptedTypeGroups: [typeGroup]);

      if (file == null) {
        print('🚫 لم يتم اختيار ملف');
        return null; // ✅ return null بدل رسالة نصية
      }

      final fileBytes = await file.readAsBytes();
      final fileName = file.name;

      final sizeInMB = fileBytes.lengthInBytes / (1024 * 1024);
      print('📏 حجم CV: ${sizeInMB.toStringAsFixed(2)} MB');

      if (sizeInMB > 50) {
        print('❌ الملف أكبر من الحد المسموح به (50MB)');
        return null; // ✅ return null بدل رسالة نصية
      }

      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) {
        print('❌ المستخدم غير مسجل دخول');
        return null; // ✅ return null بدل رسالة نصية
      }

      final userFilePath = '${uid}_cv.pdf';
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
      return null; // ✅ صرّح بالـ null
    }
  }

  @override
  Future<List<PostModel>> getSavedPosts() async {
    try {
      final results =
          await fireStore.collection("doctors").doc(CacheHelper.getString(key: "uid")).collection("saved_posts").get();
      final posts =
      results.docs.map((e) => PostModel.fromJson(e.data())).toList();
      print(results.docs);
      print(posts);
      return posts;
    } catch (e) {
      rethrow;
    }
  }
}
