import '../../models/rate_model.dart';

abstract class RateRebo{
  Future<void> addRate(RateModel rateModel,String uid);
  Future<List<RateModel>> getAllRates(String uid);
}