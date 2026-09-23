import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nyro_cryto/model/user_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'auth_service.g.dart';

@riverpod
AuthService authService(Ref ref) {
  return AuthService();
}

@riverpod
Future<UserModels?> currentUser(Ref ref) async {
  final authService = ref.watch(authServiceProvider);

  return authService.getCurrentUser();
}

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
    await user.sendEmailVerification();
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
    return UserModels.fromMap(userDoc.data()!);
  }

  Future<bool> isEmailVerified() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return false;
    }
    await user.reload();
    return user.emailVerified;
  }

  Future<void> resendVerificationEmail() async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('No authenticated user');
    }

    if (user.emailVerified) {
      return;
    }

    await user.sendEmailVerification();
  }
}

// final authServiceProvider = Provider<AuthService>((ref) {
//   return AuthService();
// });

// final currentUserProvider = FutureProvider<UserModels?>((ref) async {
//   final authService = ref.watch(authServiceProvider);
//   return await authService.getCurrentUser();
// });
