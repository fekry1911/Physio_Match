import 'package:add_ques/features/register_screen/cubit/register_state.dart';
import 'package:add_ques/features/register_screen/data/rebo/add_user_data_rebo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/helpers/cache_helper.dart';
import '../../../core/models/sign_model.dart';
import '../../../core/models/user_model.dart';
import '../data/rebo/rebo.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  final formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController gender = TextEditingController();


  bool isSecure = true;

  void changeSecure() {
    isSecure = !isSecure;
    emit(ChangeSecure(isSecure));
  }

  RegisterRebo authRepository;
  AddUserData addUserData;

  RegisterCubit(this.authRepository, this.addUserData) : super(Initial());

  Future<void> registerUser() async {
    emit(RegisterLoading());
    try {
      await authRepository
          .signUpWithEmail(signModel:SignModel(email: email.text, password: password.text), )
          .then((onValue) async {
            await addUserData
                .addUserData(
                  userModel: UserModel(
                    tries: 3,
                    name: name.text,
                    email: email.text,
                    phone: phone.text,
                    imageUrl: "http://i0.wp.com/digitalhealthskills.com/wp-content/uploads/2022/11/3da39-no-user-image-icon-27.png?fit=500%2C500&ssl=1",
                  ),
                  userId: onValue.user!.uid,
                )
                .then((value) {
                  CacheHelper.putString(key: 'uid', value: onValue.user!.uid);
                  CacheHelper.putString(key: 'name', value: name.text);
                  CacheHelper.putString(key: 'phone', value: phone.text);
                  emit(RegisterSuccess(onValue.user!.uid));
                });
          });
    } on FirebaseAuthException catch (e) {
      emit(RegisterFailure(e.message ?? 'Registration failed'));
    } catch (e) {
      emit(RegisterFailure('An unknown error occurred'));
    }
  }
}
