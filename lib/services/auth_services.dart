import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final firebaseAuth = FirebaseAuth.instance;

  Future<void> signUp(String email, String password) async {
    await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signIn(String email, String password) async {
    await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
