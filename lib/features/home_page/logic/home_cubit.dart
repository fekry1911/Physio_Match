import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/helpers/cache_helper.dart';
import '../data/rebo/get_all_ques.dart';
part 'home_state.dart';



class HomeCubit extends Cubit<HomeState> {
  GetAllQues getAllQues;
  HomeCubit(this.getAllQues) : super(HomeInitial());

  List<Map<String,dynamic>> questions = [];
  bool isLoading = false;

  Future<void> getRandomQues(String specialty) async {
    if (isLoading) return;

    isLoading = true;
    emit(GetLoading());

    try {
      final doc = await FirebaseFirestore.instance
          .collection("doctors")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (doc.data()?["tries"] > 0) {
        final onValue = await getAllQues.getAllQues(specialty);
        questions = onValue;

        await FirebaseFirestore.instance
            .collection("doctors")
            .doc(CacheHelper.getString(key: "uid"))
            .update({
          "tries": FieldValue.increment(-1),
        });

        emit(GetSucc());
      } else {
        emit(OutOfTries());
      }
    } catch (e) {
      emit(GetFail(e.toString()));
    } finally {
      isLoading = false;
    }
  }

  void resetState() {
    questions = [];
    emit(HomeInitial());
  }
}
