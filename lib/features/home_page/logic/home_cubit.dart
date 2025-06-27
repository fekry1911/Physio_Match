import 'package:add_ques/features/home_page/data/rebo/get_all_ques.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../../core/helpers/cache_helper.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  GetAllQues getAllQues;
  HomeCubit(this.getAllQues) : super(HomeInitial());

  List<Map<String,dynamic>> questions=[];

  Future<void> getRandomQues(String specialty)async {
    emit(GetLoading());
    await getAllQues.getAllQues(specialty).then((onValue) async {
      questions=onValue;
      await FirebaseFirestore.instance
      .collection("doctors").doc(CacheHelper.getString(key: "uid")).update({
        "tries": FieldValue.increment(-1),
      }).then((onValue){
        emit(GetSucc());
      });
    }).catchError((onError){
      emit(GetFail(onError));
    });

  }
  void resetState() {
    questions=[];
    emit(HomeInitial());
  }

}
