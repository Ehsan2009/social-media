import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_media/src/features/account/data/account_repository.dart';
import 'package:social_media/src/shared/current_user_provider.dart';

part 'account_service.g.dart';

class AccountService {
  const AccountService(this.ref);
  final Ref ref;

  Future<void> follow(String profileOwnerId, String visitorId) async {
    final accountRepository = ref.read(accountRepositoryProvider);
    final currentUser = ref.watch(firebaseUserProvider);
    await accountRepository.follow(profileOwnerId, visitorId, currentUser!.uid);
  }

  Future<void> unFollow(String profileOwnerId, String visitorId) async {
    final accountRepository = ref.read(accountRepositoryProvider);
    final currentUser = ref.watch(firebaseUserProvider);
    await accountRepository.unFollow(profileOwnerId, visitorId, currentUser!.uid);
  }
}

@riverpod  
AccountService accountService(Ref ref) {
  return AccountService(ref);
}