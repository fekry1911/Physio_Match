import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/helpers/cache_helper.dart';
import '../../../core/models/user_model.dart';
import '../../quiz/data/models/score_models.dart';
import '../data/update_user_rebo.dart';

part 'update_user_data_state.dart';

class UpdateUserDataCubit extends Cubit<UpdateUserDataState> {
  UpdateUserRebo updateUserRebo;

  UpdateUserDataCubit(this.updateUserRebo) : super(UpdateUserDataInitial()) {
    final uid = CacheHelper.getString(key: "uid");
    if (uid != null) {
      getUserData(uid);
      getUserScores(uid);
      getUserScoresLimit(uid);
    }
  }

  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  final formKey = GlobalKey<FormState>();

  String? updateImageUrl;

  Future<void> pickAndUploadImage() async {
    final result = await updateUserRebo.UpdateUserImage();
    if (result != null) {
      updateImageUrl = result;
      emit(EditProfileImageUpdated()); // حدث يخلّي الـ UI يعيد البناء
    }
  }

  Future<void> updateData() async {
    emit(UpdateUserDataLoad());
    await updateUserRebo.UpdateUserData(
      UserModel(
        name: name.text,
        email: model!.email,
        phone: phone.text,
        imageUrl: model!.imageUrl,
        tries: model!.tries,
      ),
    ).then((value) {
      getUserData(CacheHelper.getString(key: "uid"));
      emit(UpdateUserDataDone());
    }).catchError((onError) {
      emit(UpdateUserDataFail(onError.toString()));
    });
  }

  UserModel? model;

  Future<void> getUserData(id) async {
    emit(GetUserDataLoad());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .get()
        .then((value) async {
          model = UserModel.fromMap(value.data()!);
          emit(GetUserDataDone());
        })
        .catchError((onError) {
          emit(GetUserDataFail());
        });
  }
  List<ScoreModel> scoreModel = [];

  Future<void> getUserScores(String id) async {
    scoreModel.clear(); // 👈 أضف دي هنا
    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection("score")
        .orderBy("date", descending: true)
        .get()
        .then((onValue) {
      if (onValue.docs.isNotEmpty) {
        for (var doc in onValue.docs) {
          scoreModel.add(ScoreModel.fromMap(doc.data()));
        }
      }
      emit(GetScoreDone());
    }).catchError((onError) {
      emit(GetScoreFail());
    });
  }
  List<ScoreModel> scoreModelLimit = [];

  Future<void> getUserScoresLimit(id) async {
    scoreModelLimit.clear(); // ضروري قبل التكرار
    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection("score")
        .orderBy("date", descending: true)
        .limit(5)
        .get()
        .then((onValue) {
      print(onValue.docs);
      if (onValue.docs.isNotEmpty) {
        for (var doc in onValue.docs) {
          print(doc.data());
          scoreModelLimit.add(ScoreModel.fromMap(doc.data()));
        }
      }
      else {
        scoreModelLimit = [];
      }
      emit(GetScoreDone());
    })
        .catchError((onError) {
      emit(GetScoreFail());
    });
  }

}
