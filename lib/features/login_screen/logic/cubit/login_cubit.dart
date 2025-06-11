import 'package:add_ques/core/helpers/cache_helper.dart';
import 'package:add_ques/core/models/sign_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  Future<void> signIn() async {
    emit(AuthLoading());
    try {
      await authRepository
          .signInWithEmail(SignModel(email: emailController.text, password: passwordController.text))
          .then((value) async {
            await CacheHelper.putString(key: "uid", value: value.user!.uid);
            FirebaseFirestore.instance
                .collection('users')
                .doc(value.user!.uid)
                .get()
                .then((value) async {
                  await CacheHelper.putString(
                    key: "name",
                    value: value.data()!['name'],
                  );
                  await CacheHelper.putString(
                    key: "email",
                    value: value.data()!['email'],
                  );
                  await CacheHelper.putString(
                    key: "phone",
                    value: value.data()!['phone'],
                  );

                  emit(AuthSuccess());

            });
          });
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }

  Future<void> signOut() async {
    await authRepository.signOut();
    emit(AuthInitial());
  }
}
