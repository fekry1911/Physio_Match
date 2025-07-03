import '../models/post_model.dart';

abstract class GetPosts{
  Future<List<PostModel>> getPosts();
  Future<bool> savePost(PostModel post);
  Future<bool> applyNow(PostModel postModel);
}