import 'package:add_ques/core/helpers/cache_helper.dart';
import 'package:add_ques/features/centers/data/rebo/rate_rebo/rate_rebo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../data/models/rate_model.dart';

part 'rate_state.dart';

class RateCubit extends Cubit<RateState> {
  RateRebo rateRebo;
  TextEditingController commet = TextEditingController();
  double rateing = 0;

  RateCubit(this.rateRebo) : super(RateInitial());

  Future<void> AddRate(String uid) async {
    emit(AddRateLoading());
    String userId = CacheHelper.getString(key: "uid");
    String userName = CacheHelper.getString(key: "name") ?? "fekry";
    double rating = rateing;
    String comment = commet.text.isNotEmpty ? commet.text : "";
    DateTime timestamp = DateTime.now();
    await rateRebo.addRate(
      RateModel(
        image:"https://scontent.faly8-2.fna.fbcdn.net/v/t39.30808-6/516747391_3109974565838395_5692320429463937582_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=QOUe_cbvOb0Q7kNvwECnmES&_nc_oc=AdlVaR-sjnlccLU5aPlAqpcBFo39tve8kd0pfpKMP588AzTn-Ls14AUQ1MQ3IsqCHzQ&_nc_zt=23&_nc_ht=scontent.faly8-2.fna&_nc_gid=VlZ3XBAQy4WrxAA5a-tR4g&oh=00_AfS9uKhu8W_Tswe3kNc_pOFnxRagalo-Eja9dp47UlPS6Q&oe=687C06F1",
        comment: comment,
        userId: userId,
        userName: userName,
        rating: rating,
        timestamp: timestamp,
      ),
      uid,
    ).then((value) {
      emit(AddRateSuccess());
    }).catchError((onError) {
      emit(AddRateError(onError));
    });
  }

  Future<void> GetAllRates(String uid) async {}

  changeRate(double rate) {
    rateing = rate;
    emit(ChangeRate());
  }

  List<RateModel> rates=[];
  getAllReview(uid) async {
    emit(LoadingReviews());
    var results=await rateRebo.getAllRates(uid);
    print(results);

    try{
      rates=results;
      print(rates);
      emit(SuccReviews(rates));
    }
    catch(e){
      print(e.toString());
      emit(ErrorReviews(e.toString()));
    }
  }
}
