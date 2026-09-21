import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nyro_cryto/model/user_models.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<UserCredential> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String username,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = credential.user;
    if (user == null) {
      throw Exception('User creation failed');
    }
    await _firestore.collection('users').doc(user.uid).set({
      'id': user.uid,
      'email': email,
      'username': username,
      'createdAt': FieldValue.serverTimestamp(),
    });
    return credential;
  }

  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  User? get currentUser => _auth.currentUser;
}

Future<UserModels?> getCurrentUser() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    return null;
  }
  final userDoc = await FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .get();
  if (!userDoc.exists) {
    return null;
  }
  return UserModels.fromJson(userDoc.data()!);
}

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

final currentUserProvider = FutureProvider<UserModels?>((ref) async {
  return await getCurrentUser();
});
