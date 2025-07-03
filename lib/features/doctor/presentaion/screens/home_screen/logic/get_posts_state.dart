part of 'get_posts_cubit.dart';

@immutable
sealed class GetPostsState {}

final class GetPostsInitial extends GetPostsState {}

final class GetPostsLoading extends GetPostsState {}
final class GetPostsSuccess extends GetPostsState {}
final class GetPostsFailure extends GetPostsState {
  final String error;
  GetPostsFailure(this.error);
}
final class SavePostLoading extends GetPostsState {}
final class SavePostsucc extends GetPostsState {}
final class AlreadySaved extends GetPostsState {}
final class SavePostFail extends GetPostsState {
  final String error;
  SavePostFail(this.error);}

final class ApplyDone extends GetPostsState {}
final class ApplyBefore extends GetPostsState {}
final class ApplyFail extends GetPostsState {}