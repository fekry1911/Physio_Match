part of 'rate_cubit.dart';

@immutable
sealed class RateState {}

final class RateInitial extends RateState {}

class ChangeRate extends RateState {}

class AddRateLoading extends RateState {}

class AddRateSuccess extends RateState {}

class AddRateError extends RateState {
  final String error;

  AddRateError(this.error);
}

class LoadingReviews extends RateState {}

class SuccReviews extends RateState {
  List<RateModel> rates = [];

  SuccReviews(this.rates);
}

class ErrorReviews extends RateState {
  String error;

  ErrorReviews(this.error);
}

