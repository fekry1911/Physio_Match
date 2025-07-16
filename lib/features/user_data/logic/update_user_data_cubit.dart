import 'dart:async';

import 'package:add_ques/core/helpers/cache_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../doctor/data/models/doctor_model.dart';
import '../../quiz/data/models/score_models.dart';
import '../data/update_user_rebo.dart';

part 'update_user_data_state.dart';

class UpdateUserDataCubit extends Cubit<UpdateUserDataState> {
  UpdateUserRebo updateUserRebo;

  UpdateUserDataCubit(this.updateUserRebo) : super(UpdateUserDataInitial());

  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> updateData() async {
    emit(UpdateUserDataLoad());
    await updateUserRebo.UpdateUserData(
      DoctorModel(
        fullName: name.text,
        phone: phone.text,
      )
    )
        .then((value) {
      CacheHelper.putString(key: "name", value: name.text);
      emit(UpdateUserDataDone());
    })
        .catchError((onError) {
          emit(UpdateUserDataFail(onError));
    });
  }
  String? updateImageUrl;

  Future<void> updateImage() async {
    try {
      final respnse = await updateUserRebo.UpdateUserImage();

      if (respnse == null) {
        print("❌ المستخدم لم يختر صورة");
        return; // ❌ ما تعملش update
      }

      await FirebaseFirestore.instance
          .collection("doctors")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({"imageUrl": respnse}).then((onValue){
            CacheHelper.putString(key: "image", value: respnse);
      });

      updateImageUrl = respnse; // لو حبيت تستخدمه بعدين
      doctortModel = null;
      await getDoctorData(FirebaseAuth.instance.currentUser!.uid);
      emit(EditProfileImageUpdated());
    } catch (e) {
      print("❌ خطأ أثناء تحديث الصورة: $e");
      emit(EditProfileImageFail());
    }
  }


  String? updateCvUrl = "";

  Future<void> updateCv() async {
    try {
      final respnse = await updateUserRebo.UpdateUser();

      // ✅ تأكد إن المستخدم اختار CV فعلاً
      if (respnse == null || respnse.startsWith("❌")) {
        print("❌ لم يتم اختيار CV أو حدث خطأ أثناء الرفع");
        return;
      }

      await FirebaseFirestore.instance
          .collection("doctors")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({"resume": respnse});

      updateCvUrl = respnse;

      doctortModel = null;
      await getDoctorData(FirebaseAuth.instance.currentUser!.uid);
      emit(EditProfileCvUpdated());

      Timer(Duration(seconds: 4), () {
        updateCvUrl = "";
      });
    } catch (e) {
      print("❌ خطأ أثناء رفع CV: $e");
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

  Future<void> getUserScores(String id,String specialization) async {
    scoreModel.clear(); // 👈 أضف دي هنا
    await FirebaseFirestore.instance
        .collection('doctors')
        .doc(id)
        .collection("score").doc(specialization).collection("items")
        .get()
        .then((onValue) {
          if (onValue.docs.isNotEmpty) {
            for (var doc in onValue.docs) {
              scoreModel.add(ScoreModel.fromMap(doc.data()));
            }
          }
          emit(GetScoreDone());
        })
        .catchError((onError) {
          emit(GetScoreFail());
        });
  }
}
