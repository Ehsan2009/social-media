import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media/models/app_user.dart';

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
              color: Colors.grey[500],
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.name),
                Text(user.email),
              ],
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                context.push(
                  '/profile_screen',
                  extra: user,
                );
              },
              icon: const Icon(Icons.arrow_forward),
            ),
          ],
        ),
      ),
    );
  }
}
