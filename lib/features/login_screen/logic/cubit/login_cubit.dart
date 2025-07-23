import 'package:add_ques/core/helpers/cache_helper.dart';
import 'package:add_ques/core/models/sign_model.dart';
import 'package:add_ques/features/quiz/data/models/score_models.dart';
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
            final isVerified =
                await authRepository.checkAndCacheEmailVerified();
          /*  if (!isVerified) {
              emit(AuthFailure(error: "يرجى تأكيد البريد الإلكتروني"));
              return;
            }*/
            print(isVerified);

            CacheHelper.putString(key: "uid", value: value.user!.uid);
            CacheHelper.putBoolean(key: "submitted", value: true);
            model = await authRepository.getUserModel(value.user!.uid);
            CacheHelper.putString(key: "image", value: model!.imageUrl);
            CacheHelper.putString(key: "name", value: model!.name);

            emit(AuthSuccess());
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
          CacheHelper.removeBool(key: "submitted");
          emit(SignOutDone());
        })
        .catchError((onError) {
          emit(SignOutFail(onError));
        });
  }
}
