part of 'save_score_cubit.dart';

@immutable
sealed class SaveScoreState {}

final class SaveScoreInitial extends SaveScoreState {}

final class SaveScoreLoad extends SaveScoreState {}


final class SaveScoreSucc extends SaveScoreState {}


final class SaveScoreFail extends SaveScoreState {
  final String error;
  SaveScoreFail(this.error);
}

