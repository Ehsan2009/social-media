import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_media/src/features/authentication/domain/app_user.dart';
import 'package:social_media/src/features/search_users/data/users_repository.dart';

part 'search_controller.g.dart';

@riverpod  
Future<List<AppUser>> allUsers(Ref ref) async {
  final usersRepository = ref.read(usersRepositoryProvider);
  return await usersRepository.allUsers();
}