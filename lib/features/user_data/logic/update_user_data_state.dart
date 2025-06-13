part of 'update_user_data_cubit.dart';

@immutable
sealed class UpdateUserDataState {}

final class UpdateUserDataInitial extends UpdateUserDataState {}

final class UpdateUserImageDone extends UpdateUserDataState {}

final class UpdateUserImageFail extends UpdateUserDataState {}


final class GetUserDataLoad extends UpdateUserDataState {}

final class GetUserDataDone extends UpdateUserDataState {}

final class GetUserDataFail extends UpdateUserDataState {}


final class UpdateUserDataLoad extends UpdateUserDataState {}

final class UpdateUserDataDone extends UpdateUserDataState {}

final class UpdateUserDataFail extends UpdateUserDataState {
  String error;
  UpdateUserDataFail(this.error);
}

final class EditProfileImageUpdated extends UpdateUserDataState {}

final class GetScoreDone extends UpdateUserDataState {}


final class GetScoreFail extends UpdateUserDataState {}



