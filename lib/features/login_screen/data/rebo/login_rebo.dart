
import 'package:add_ques/core/models/sign_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
   Future<UserCredential> signInWithEmail(SignModel signModel);
   Future<void> signOut();
   Stream<bool> get isSignedIn;
}
