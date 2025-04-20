import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_media/src/features/authentication/domain/app_user.dart';

part 'users_repository.g.dart';

class UsersRepository {
  UsersRepository(this._firestore);
  final FirebaseFirestore _firestore;

    Future<List<AppUser>> allUsers() async {
    List<AppUser> users = [];

    final response = await _firestore.collection('users').get();

    for (var doc in response.docs) {
      print('this is doc: $doc');
      print('this is docData: ${doc.data()}');
      users.add(
        AppUser.fromMap(doc.data()),
      );
    }

    return users;
  }
}

@Riverpod(keepAlive: true)  
UsersRepository usersRepository(Ref ref) {
  return UsersRepository(FirebaseFirestore.instance);
}