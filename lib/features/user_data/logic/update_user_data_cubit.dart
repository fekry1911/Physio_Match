import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/helpers/cache_helper.dart';
import '../../../core/models/user_model.dart';
import '../../doctor/data/models/doctor_model.dart';
import '../../quiz/data/models/score_models.dart';
import '../../type_register/data/models/register_model.dart';
import '../data/update_user_rebo.dart';

part 'update_user_data_state.dart';

class UpdateUserDataCubit extends Cubit<UpdateUserDataState> {
  UpdateUserRebo updateUserRebo;

  UpdateUserDataCubit(this.updateUserRebo) : super(UpdateUserDataInitial()) {}

  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  final formKey = GlobalKey<FormState>();

  String? updateImageUrl;

  Future<void> updateImage()async {
    try{
    final respnse = await  updateUserRebo.UpdateUserImage();
    FirebaseFirestore.instance.collection("doctors").doc(FirebaseAuth.instance.currentUser!.uid).update(
        {
          "imageUrl":respnse
        }
    );
    doctortModel=null;
    getDoctorData(FirebaseAuth.instance.currentUser!.uid);
    emit(EditProfileImageUpdated());
    }catch(e){

      emit(EditProfileImageFail());
    }

  }
  String? updateCvUrl="";

  Future<void> updateCv()async {
    try{
      final respnse = await  updateUserRebo.UpdateUser();
      FirebaseFirestore.instance.collection("doctors").doc(FirebaseAuth.instance.currentUser!.uid).update(
          {
            "resume":respnse
          }
      ).then((onValue){
        updateCvUrl=respnse;

        doctortModel=null;
        getDoctorData(FirebaseAuth.instance.currentUser!.uid);
        emit(EditProfileCvUpdated());
      });
      Timer(Duration(seconds: 4), () {
        updateCvUrl="";
      });

    }
    catch(e){
      emit(EditProfileCvFail());

    }
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

  Future<void> openPDFLink(String url) async {
    final Uri uri = Uri.parse(url);

    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication, // 👈 افتح الرابط خارج التطبيق
    )) {
      print('❌ لا يمكن فتح الرابط');
    }
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
