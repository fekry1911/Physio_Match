import 'package:add_ques/core/helpers/cache_helper.dart';
import 'package:add_ques/core/models/sign_model.dart';
import 'package:add_ques/features/quiz/data/models/score_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/user_model.dart';
import '../../data/rebo/login_rebo.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  AuthRepository authRepository;

  LoginCubit(this.authRepository) : super(Initial());
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  int c = 1;

  bool isLoading = false;

  bool isSecure = true;

  void toggleSecure() {
    isSecure = !isSecure;
    print(isSecure);
    emit(ToggleSecure(isSecure: isSecure));
  }

  UserModel? model;
  List<ScoreModel> scoreModel = [];

  Future<void> signIn() async {
    emit(AuthLoading());
    try {
      await authRepository
          .signInWithEmail(
            SignModel(
              email: emailController.text,
              password: passwordController.text,
            ),
          )
          .then((value) async {
            await CacheHelper.putString(key: "uid", value: value.user!.uid);
            getUserData(value.user!.uid).then((onValue) {
              emit(AuthSuccess());
            });
          });
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }

  Future<void> signOut() async {
    emit(SignOutLoad());

    await authRepository
        .signOut()
        .then((onValue) {
          CacheHelper.removeString(key: "uid");
          emit(SignOutDone());
        })
        .catchError((onError) {
          emit(SignOutFail(onError));
        });
  }

  Future<void> getUserData(id) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .get()
        .then((value) async {
          model = UserModel.fromMap(value.data()!);
          emit(GetDataDone());
        })
        .catchError((onError) {
          emit(GetDataFail());
        });
  }

  Future<void> getUserScores(id) async {
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
              scoreModel.add(ScoreModel.fromMap(doc.data()));
            }
          }
          else {
            scoreModel = [];
          }
          emit(GetScoreDone());
        })
        .catchError((onError) {
          emit(GetScoreFail());
        });
  }
}
