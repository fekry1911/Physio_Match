
import 'package:add_ques/core/models/sign_model.dart';
import 'package:add_ques/core/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
   Future<UserCredential> signInWithEmail(SignModel signModel);
   Future<UserModel> getUserModel(uid);
   Future<void> signOut();
   Stream<bool> get isSignedIn;
}
