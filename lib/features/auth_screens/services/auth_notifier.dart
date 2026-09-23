import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nyro_cryto/features/auth_screens/services/auth_service.dart';
import 'package:nyro_cryto/model/user_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'auth_notifier.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  // late final AuthService _authService;
  @override
  FutureOr<UserCredential?> build() {
   // _authService = ref.read(authServiceProvider);
    return null;
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    state = const AsyncValue.loading();
    try {
        final _authService = ref.read(authServiceProvider);
      final credential = await _authService.signUpWithEmailAndPassword(
        email: email,
        password: password,
        username: username,
      );
      state = AsyncValue.data(credential);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    state = const AsyncValue.loading();
    try {
      final _authService = ref.read(authServiceProvider);
      final credential = await _authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      state = AsyncValue.data(credential);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> signOut() async {
    state = const AsyncValue.loading();
    try {
      final _authService = ref.read(authServiceProvider);
      await _authService.signOut();
      state = const AsyncValue.data(null);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<bool> isEmailVerified() async {
    state = const AsyncValue.loading();
    try {
      final _authService = ref.read(authServiceProvider);
      final isVerfied = await _authService.isEmailVerified();
      return isVerfied;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      return false;
    }
  }

  Future<void> resendVerificationEmail() async {
    state = const AsyncValue.loading();
    try {
      final _authService = ref.read(authServiceProvider);
      await _authService.resendVerificationEmail();
      state = const AsyncValue.data(null);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  // Future<UserModels?> getCurrentUser() async {
  //   state = const AsyncValue.loading();
  //   try {
  //     final user = await getCurrentUser();
  //     // state = AsyncValue.data(user);
  //     return user;
  //   } catch (e, stackTrace) {
  //     state = AsyncValue.error(e, stackTrace);
  //     return null;
  //   }
  // }
}

// final authNotifierProvider =
//     AsyncNotifierProvider<AuthNotifier, UserCredential?>(AuthNotifier.new);
