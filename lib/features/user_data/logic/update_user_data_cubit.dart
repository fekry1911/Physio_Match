import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/helpers/cache_helper.dart';
import '../../../core/models/user_model.dart';
import '../../doctor/data/models/doctor_model.dart';
import '../../quiz/data/models/score_models.dart';
import '../../type_register/data/models/register_model.dart';
import '../data/update_user_rebo.dart';

part 'update_user_data_state.dart';

class UpdateUserDataCubit extends Cubit<UpdateUserDataState> {
  UpdateUserRebo updateUserRebo;

  UpdateUserDataCubit(this.updateUserRebo) : super(UpdateUserDataInitial()) {
    final uid = CacheHelper.getString(key: "uid");
    final type = CacheHelper.getString(key: "type");

    if (uid != null) {
      if(type=="doctor"){
        getDoctorData(uid);
      }
      else{
        getStudentData(uid);
      }
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
        email: "studentModel!.email",
        phone: phone.text,
        imageUrl: "studentModel!.imageUrl",
        tries: studentModel!.tries!,
      ),
    ).then((value) {
      getStudentData(CacheHelper.getString(key: "uid"));
      emit(UpdateUserDataDone());
    }).catchError((onError) {
      emit(UpdateUserDataFail(onError.toString()));
    });
  }

  DoctorModel? studentModel;


  Future<void> getStudentData(id) async {
    emit(GetUserDataLoad());
    await FirebaseFirestore.instance
        .collection('type_register')
        .doc(id)
        .get()
        .then((value) async {
          studentModel = DoctorModel.fromMap(value.data()!);
          emit(GetUserDataDone());
        })
        .catchError((onError) {
          emit(GetUserDataFail());
        });
  }
  DoctorModel? doctortModel;

  Future<void> getDoctorData(id) async {
    emit(GetUserDataLoad());
    await FirebaseFirestore.instance
        .collection('doctors')
        .doc(id)
        .get()
        .then((value) async {
      doctortModel = DoctorModel.fromMap(value.data()!);
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
