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
