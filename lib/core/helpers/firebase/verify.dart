import 'package:firebase_auth/firebase_auth.dart';

Future<void> sendVerificationEmail() async {
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null && !user.emailVerified) {
    await user.sendEmailVerification().then((_) {
      print("Verification email sent.");
    }).catchError((error) {
      print("Error sending verification email: $error");
    });
  }
}
