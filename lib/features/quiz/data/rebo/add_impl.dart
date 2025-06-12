import 'package:add_ques/core/helpers/cache_helper.dart';
import 'package:add_ques/features/quiz/data/models/score_models.dart';
import 'package:add_ques/features/quiz/data/rebo/add.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppScoreImpl implements AddScore {
  FirebaseFirestore fire;

  AppScoreImpl(this.fire);

  @override
  Future<void> AddSCore(ScoreModel scoreModel) async {
    await fire.collection("users")
        .doc(CacheHelper.getString(key: "uid"))
        .collection("score")
        .add(scoreModel.toMap());
  }

}