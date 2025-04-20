import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media/src/features/authentication/domain/app_user.dart';
import 'package:social_media/src/routing/app_router.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    super.key,
    required this.user,
  });

  final AppUser user;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardTheme.color,
      elevation: 10,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            Icon(
              Icons.person,
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.name, style: TextStyle(color: Theme.of(context).colorScheme.secondary,),),
                Text(user.email, style: TextStyle(color: Theme.of(context).colorScheme.secondary,),),
              ],
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                context.pushNamed(
                  AppRoute.otherUserAccount.name,
                  extra: user.id,
                );
              },
              icon: Icon(Icons.arrow_forward, color: Theme.of(context).colorScheme.secondary,),
            ),
          ],
        ),
      ),
    );
  }
}
