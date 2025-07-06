import '../../../doctor/presentaion/screens/home_screen/data/models/post_model.dart';

abstract class GetSavedPosts{
  Future<List<PostModel>> getSavedPosts();

}