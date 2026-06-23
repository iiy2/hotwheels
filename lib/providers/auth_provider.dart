import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../services/auth_service.dart';

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
AuthService authService(Ref ref) {
  return AuthService();
}

@Riverpod(keepAlive: true)
Stream<User?> authState(Ref ref) {
  return ref.watch(authServiceProvider).authStateChanges;
}

@riverpod
class SignIn extends _$SignIn {
  @override
  FutureOr<void> build() {}

  Future<void> withGoogle() async {
    state = const AsyncLoading();
    try {
      await ref.read(authServiceProvider).signInWithGoogle();
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

@riverpod
class SignOut extends _$SignOut {
  @override
  FutureOr<void> build() {}

  Future<void> call() async {
    state = const AsyncLoading();
    try {
      await ref.read(authServiceProvider).signOut();
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
