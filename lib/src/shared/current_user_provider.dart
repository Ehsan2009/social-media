import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_media/src/features/account/data/account_repository.dart';
import 'package:social_media/src/features/authentication/data/auth_repository.dart';
import 'package:social_media/src/features/authentication/domain/app_user.dart';

part 'current_user_provider.g.dart';

@Riverpod(keepAlive: true)
Future<AppUser> appUser(Ref ref) async {
  final user = ref.read(authRepositoryProvider).firebaseUser;
  return await ref.read(accountRepositoryProvider).currentAppUser(user!.uid);
}

@Riverpod(keepAlive: true)
User? firebaseUser(Ref ref) {
  final authRepository = ref.read(authRepositoryProvider);
  return authRepository.firebaseUser;
}
