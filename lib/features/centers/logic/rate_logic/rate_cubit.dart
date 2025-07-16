import 'package:add_ques/core/helpers/cache_helper.dart';
import 'package:add_ques/features/centers/data/rebo/rate_rebo/rate_rebo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../data/models/rate_model.dart';

part 'rate_state.dart';

class RateCubit extends Cubit<RateState> {
  RateRebo rateRebo;
  TextEditingController commet = TextEditingController();
  double rateing = 0;

  RateCubit(this.rateRebo) : super(RateInitial());

  Future<void> AddRate(String uid) async {
    emit(AddRateLoading());
    String image = CacheHelper.getString(key: "image")??"";
    String userId = CacheHelper.getString(key: "uid");
    String userName = CacheHelper.getString(key: "name") ?? "fekry";
    double rating = rateing;
    String comment = commet.text.isNotEmpty ? commet.text : "";
    DateTime timestamp = DateTime.now();
    await rateRebo
        .addRate(
          RateModel(
            comment: comment,
            userId: userId,
            userName: userName,
            rating: rating,
            timestamp: timestamp,
            image: image,
          ),
          uid,
        )
        .then((value) {
          emit(AddRateSuccess());
        })
        .catchError((onError) {
          emit(AddRateError(onError));
        });
  }

  Future<void> getAllRates(String uid) async {}

  changeRate(double rate) {
    rateing = rate;
    emit(ChangeRate());
  }

  List<RateModel> rates = [];

  getAllReview(uid) async {
    emit(LoadingReviews());
    var results = await rateRebo.getAllRates(uid);
    if (kDebugMode) {
      print(results);
    }

    try {
      rates = results;
      print(rates);
      emit(SuccReviews(rates));
    } catch (e) {
      print(e.toString());
      emit(ErrorReviews(e.toString()));
    }
  }
}
