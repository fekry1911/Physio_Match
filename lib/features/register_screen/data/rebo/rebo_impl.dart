// features/auth/register/data/auth_repository.dart

import 'package:add_ques/features/register_screen/data/rebo/rebo.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/models/sign_model.dart';

class AuthRepositorySignUp implements RegisterRebo {
   FirebaseAuth _auth ;
   AuthRepositorySignUp(this._auth);


  @override
  Future<UserCredential> signUpWithEmail({required SignModel signModel}) async => await _auth.createUserWithEmailAndPassword(email: signModel.email,password: signModel.password);
}
