import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data/models/post_model.dart';
import '../data/rebo/get_posts.dart';

part 'get_posts_state.dart';

class GetPostsCubit extends Cubit<GetPostsState> {
  GetPosts getPosts;
  GetPostsCubit(this.getPosts) : super(GetPostsInitial());

  List<PostModel> posts = [];
  Future<void> getPostsData() async {
    emit(GetPostsLoading());
    try {
      posts = await getPosts.getPosts();
      emit(GetPostsSuccess());
    } catch (e) {
      emit(GetPostsFailure(e.toString()));
    }
  }
}
