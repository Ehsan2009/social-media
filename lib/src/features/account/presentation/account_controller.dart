import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_media/src/features/account/application/account_service.dart';

part 'account_controller.g.dart';

@Riverpod(keepAlive: true)
class AccountController extends _$AccountController {
  @override
  FutureOr<void> build() {
    // nothing to do
  }

  Future<void> followUser(String profileOwnerId, String visitorId) async {
    final accountService = ref.read(accountServiceProvider);

    state = AsyncLoading();

    state = await AsyncValue.guard(() async {
      return accountService.follow(profileOwnerId, visitorId);
    });
  }

  Future<void> unFollowUser(String profileOwnerId, String visitorId) async {
    final accountService = ref.read(accountServiceProvider);

    state = AsyncLoading();

    state = await AsyncValue.guard(() async {
      return accountService.unFollow(profileOwnerId, visitorId);
    });
  }
}
