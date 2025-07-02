import 'package:add_ques/features/doctor/presentaion/screens/home_screen/data/models/post_model.dart';
import 'package:add_ques/features/doctor/presentaion/screens/home_screen/data/rebo/get_posts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetPostsImpl extends GetPosts{
  FirebaseFirestore firebaseFirestore;
  GetPostsImpl(this.firebaseFirestore);
  @override
  Future<List<PostModel>> getPosts() async {
    try{
      final results= await firebaseFirestore.collection("posts").orderBy("date").get();
      final posts= results.docs.map((e) => PostModel.fromJson(e.data())).toList();
      print(results.docs);
      print("import 'package:add_ques/features/doctor/presentaion/screens/home_screen/data/models/post_model.dart';"
          "import 'package:add_ques/features/doctor/presentaion/screens/home_screen/data/rebo/get_posts.dart';"
          "import 'package:cloud_firestore/cloud_firestore.dart';");
      print(posts);
      return posts;
    }catch(e){
      rethrow;
    }
  }
}