import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    _auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    _auth.signInWithEmailAndPassword(email: email, password: password);
    // Implement sign-in logic here
  }
}

final authServiceProvider = Provider<AuthService>((ref) => AuthService());
