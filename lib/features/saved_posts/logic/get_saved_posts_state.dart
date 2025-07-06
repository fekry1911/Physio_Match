part of 'get_saved_posts_cubit.dart';

@immutable
sealed class GetSavedPostsState {}

final class GetSavedPostsInitial extends GetSavedPostsState {}
final class GetPostsLoading extends GetSavedPostsState {}
final class GetPostsSuccess extends GetSavedPostsState {
  final List<PostModel> posts;
  GetPostsSuccess(this.posts);
}
final class GetPostsFailure extends GetSavedPostsState {
  final String error;
  GetPostsFailure(this.error);
}
