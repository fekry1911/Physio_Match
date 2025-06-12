import 'package:add_ques/features/quiz/data/rebo/add.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data/models/score_models.dart';

part 'save_score_state.dart';

class SaveScoreCubit extends Cubit<SaveScoreState> {
  AddScore addScore;

  SaveScoreCubit(this.addScore) : super(SaveScoreInitial());

  void saveScore({required correctAnswers,required totalQuestions}) async {
    emit(SaveScoreLoad());

    await addScore.AddSCore(ScoreModel(correctAnswers: correctAnswers, totalQuestions: totalQuestions)).then((onValue){
      emit(SaveScoreSucc());
    }).catchError((onError){
      print(onError.toString());
      emit(SaveScoreFail(onError));
    });

  }
}
