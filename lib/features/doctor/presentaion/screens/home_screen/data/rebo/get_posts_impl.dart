import 'package:add_ques/core/helpers/cache_helper.dart';
import 'package:add_ques/features/doctor/presentaion/screens/home_screen/data/models/post_model.dart';
import 'package:add_ques/features/doctor/presentaion/screens/home_screen/data/rebo/get_posts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../data/models/doctor_model.dart';

class GetPostsImpl extends GetPosts {
  FirebaseFirestore firebaseFirestore;

  GetPostsImpl(this.firebaseFirestore);

  @override
  Future<List<PostModel>> getPosts() async {
    try {
      final results =
          await firebaseFirestore.collection("posts").orderBy("date", descending: true)
              .get();
      final posts =
          results.docs.map((e) => PostModel.fromJson(e.data())).toList();
      print(results.docs);
      print(posts);
      return posts;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> savePost(PostModel post) async {
    try {
      var uid = CacheHelper.getString(key: "uid");

      final savedRef = FirebaseFirestore.instance
          .collection('doctors')
          .doc(uid)
          .collection('saved_posts')
          .doc(post.id);
      final alreadySaved = await savedRef.get();
      if (alreadySaved.exists) {
        print("⚠️ تم التقديم بالفعل على هذا البوست");
        return false;
      } else {
        firebaseFirestore
            .collection("doctors")
            .doc(uid)
            .collection("saved_posts")
            .doc(post.id)
            .set(post.toJson());
        return true;
      }
    } catch (e) {
      throw ();
    }
  }

  @override
  Future<bool> applyNow(PostModel postModel) async {
    try {
      final uid = CacheHelper.getString(key: "uid");
      if (uid == null) throw Exception("❌ لا يوجد مستخدم");
      var response=await firebaseFirestore.collection("doctors").doc(uid).get();
      DoctorModel? doctortModel;
      doctortModel=DoctorModel.fromMap(response.data()!);


      final appliedRef = firebaseFirestore
          .collection('doctors')
          .doc(uid)
          .collection('applied_posts')
          .doc(postModel.id);

      final alreadyApplied = await appliedRef.get();

      if (alreadyApplied.exists) {
        print("⚠️ المستخدم قدّم بالفعل على هذا البوست");
        return false;
      }

      // حفظ التقديم في المستخدم
      firebaseFirestore
          .collection("doctors")
          .doc(uid)
          .collection("applied_posts")
          .doc(postModel.id)
          .set(postModel.toJson());
      firebaseFirestore
          .collection("admins")
          .doc(postModel.uid)
          .collection("my_posts")
          .doc(postModel.id)
          .collection("Applied")
          .add(doctortModel.toMap());
      print("✅ تم التقديم بنجاح");
      return true;
    } catch (e) {
      print("❌ خطأ أثناء التقديم: $e");
      rethrow;
    }
  }
}
