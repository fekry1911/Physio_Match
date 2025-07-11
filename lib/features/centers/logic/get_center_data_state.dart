part of 'get_center_data_cubit.dart';

@immutable
sealed class GetCenterDataState {}

final class GetCenterDataInitial extends GetCenterDataState {}
final class GetAllCenterDataLoading extends GetCenterDataState {}
final class GetAllCenterDataSuccess extends GetCenterDataState {
  final List<AdminModel> adminList;
  GetAllCenterDataSuccess(this.adminList);
}
final class GetAllCenterDataError extends GetCenterDataState {
  final String error;
  GetAllCenterDataError(this.error);
}
final class GetCenterDataLoading extends GetCenterDataState {}
final class GetCenterDataError extends GetCenterDataState {
  final String error;
  GetCenterDataError(this.error);
}
final class GetCenterDataSuccess extends GetCenterDataState {
  final AdminModel adminModel;
  GetCenterDataSuccess(this.adminModel);
}

