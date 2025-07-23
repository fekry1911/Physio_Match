import 'package:add_ques/core/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/helpers/cache_helper.dart';
import '../../../../core/models/sign_model.dart';
import 'login_rebo.dart';

class AuthRepositoryImpl implements AuthRepository {
  FirebaseAuth auth;
  FirebaseFirestore firebaseFirestore;
  AuthRepositoryImpl(this.auth,this.firebaseFirestore);

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

  @override
  Future<UserModel> getUserModel(uid) async {
    UserModel userModel;
    var result=await firebaseFirestore.collection("users").doc(uid).get();
    userModel=UserModel.fromMap(result.data()!);
    return userModel;
  }

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
