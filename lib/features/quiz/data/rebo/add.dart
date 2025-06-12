import '../models/score_models.dart';

abstract class AddScore{
  Future<void> AddSCore(ScoreModel scorModel);
}