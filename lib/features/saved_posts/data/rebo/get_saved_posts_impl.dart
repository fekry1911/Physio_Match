import 'package:add_ques/features/doctor/presentaion/screens/home_screen/data/models/post_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/helpers/cache_helper.dart';
import 'get_saved_posts.dart';

class GetSavedPostsImpl extends GetSavedPosts{
  FirebaseFirestore fireStore ;
  GetSavedPostsImpl(this.fireStore);

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