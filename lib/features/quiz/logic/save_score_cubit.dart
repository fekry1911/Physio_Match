import 'package:add_ques/features/quiz/data/rebo/add.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../user_data/logic/update_user_data_cubit.dart'; // استيراد الكيوبت
import '../../../core/helpers/cache_helper.dart'; // لو هتحتاج uid
import '../data/models/score_models.dart';

part 'save_score_state.dart';

class SaveScoreCubit extends Cubit<SaveScoreState> {
  final AddScore addScore;
  final UpdateUserDataCubit updateCubit;

  SaveScoreCubit(this.addScore, this.updateCubit) : super(SaveScoreInitial());

  void saveScore({
    required int correctAnswers,
    required int totalQuestions,
    required String uid,
  }) async {
    emit(SaveScoreLoad());
    try {
      await addScore.AddSCore(
        ScoreModel(
          correctAnswers: correctAnswers,
          totalQuestions: totalQuestions,
        ),
      );

      await updateCubit.getStudentData(uid);
      await updateCubit.getUserScores(uid);
      await updateCubit.getUserScoresLimit(uid);


      emit(SaveScoreSucc());
    } catch (e) {
      emit(SaveScoreFail(e.toString()));
    }
  }
}
