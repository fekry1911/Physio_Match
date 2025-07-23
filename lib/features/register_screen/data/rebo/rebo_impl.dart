// features/auth/register/data/auth_repository.dart

import 'package:add_ques/features/register_screen/data/rebo/rebo.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/helpers/cache_helper.dart';
import '../../../../core/models/sign_model.dart';

class AuthRepositorySignUp implements RegisterRebo {
   final FirebaseAuth _auth ;
   AuthRepositorySignUp(this._auth);


  @override
  Future<UserCredential> signUpWithEmail({required SignModel signModel}) async => await _auth.createUserWithEmailAndPassword(email: signModel.email,password: signModel.password);
   @override
   Future<bool> checkAndCacheEmailVerified() async {
     User? user = FirebaseAuth.instance.currentUser;

     if (user == null) return false;

     await user.reload();
     user = FirebaseAuth.instance.currentUser;

     final isVerified = user!.emailVerified;

     CacheHelper.putBoolean(key: "verified", value: isVerified);

     return isVerified;
   }
}
