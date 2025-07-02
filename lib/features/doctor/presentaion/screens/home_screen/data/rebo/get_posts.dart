import '../models/post_model.dart';

abstract class GetPosts{
  Future<List<PostModel>> getPosts();
}