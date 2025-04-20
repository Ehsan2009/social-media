import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_media/src/features/account/data/account_repository.dart';
import 'package:social_media/src/features/authentication/data/auth_repository.dart';
import 'package:social_media/src/features/authentication/presentation/auth_screen.dart';

part 'auth_service.g.dart';

class AuthService {
  const AuthService(this.ref);
  final Ref ref;

  Future<void> authenticate(
    String name,
    String email,
    String profileUrl,
    String password,
    EmailPasswordSignInFormType formType,
  ) async {
    final authRepository = ref.read(authRepositoryProvider);
    final accountRepository = ref.read(accountRepositoryProvider);

    if (formType == EmailPasswordSignInFormType.signIn) {
      await authRepository.signInWithEmailAndPassword(email, password);
    } else {
      await authRepository.createUserWithEmailAndPassword(email, password);
      await accountRepository.addUserInfoToFirebase(
        name,
        email,
        profileUrl,
        authRepository.firebaseUser!.uid,
      );
    }
  }
}

@Riverpod(keepAlive: true)
AuthService authService(Ref ref) {
  return AuthService(ref);
}
