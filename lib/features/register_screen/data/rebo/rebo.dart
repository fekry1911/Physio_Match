

import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/models/sign_model.dart';



abstract class RegisterRebo {
   Future<UserCredential> signUpWithEmail({required SignModel signModel});
   Future<bool> checkAndCacheEmailVerified();

}