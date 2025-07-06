import 'package:add_ques/features/doctor/presentaion/screens/home_screen/data/models/post_model.dart';
import 'package:add_ques/features/saved_posts/data/rebo/get_saved_posts.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'get_saved_posts_state.dart';

class GetSavedPostsCubit extends Cubit<GetSavedPostsState> {
  GetSavedPosts getSavedPosts;
  GetSavedPostsCubit(this.getSavedPosts) : super(GetSavedPostsInitial());

  List<PostModel> posts=[];
  Future<void> getPostsData() async {
    emit(GetPostsLoading());
    try {
      posts = await getSavedPosts.getSavedPosts();
      emit(GetPostsSuccess(posts));
    } catch (e) {
      emit(GetPostsFailure(e.toString()));
    }
  }
}
