import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/models/sign_model.dart';
import 'login_rebo.dart';

class AuthRepositoryImpl implements AuthRepository {
  FirebaseAuth auth;
  AuthRepositoryImpl(this.auth);

  @override
  Future<UserCredential> signInWithEmail(SignModel signModel) async {
   return await auth.signInWithEmailAndPassword(email: signModel.email, password: signModel.password);
  }

  @override
  Future<void> signOut() async {
    await auth.signOut();
  }

  @override
  Stream<bool> get isSignedIn =>
      auth.authStateChanges().map((user) => user != null);
}
