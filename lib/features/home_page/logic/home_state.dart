part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class GetLoading extends HomeState {}


final class GetSucc extends HomeState {}


final class GetFail extends HomeState {
  String error;
  GetFail(this.error);
}

final class OutOfTries extends HomeState {

  OutOfTries();
}

