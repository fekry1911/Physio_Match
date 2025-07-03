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
  Future<void> savePost(PostModel postModel)async {
    emit(SavePostLoading());
    try {
     var result= await getPosts.savePost(postModel);
      if(result){
        emit(SavePostsucc());
      }
      else{
        emit(AlreadySaved());
      }
    } catch (e) {
      emit(SavePostFail(e.toString()));
    }
  }

  Future<void> applyNow(PostModel postModel)async {
    try{
     var result= await getPosts.applyNow(postModel);
     if(result){
       emit(ApplyDone());
     }
     else{
       emit(ApplyBefore());

     }
    }
        catch(e){
          emit(ApplyFail());
        }
  }
}
