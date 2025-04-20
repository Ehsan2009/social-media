import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media/src/features/authentication/presentation/auth_controller.dart';
import 'package:social_media/src/routing/app_router.dart';
import 'package:social_media/src/shared/selected_screen_controller.dart';

enum DrawerScreens { posts, account, search, settings }

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedScreen = ref.watch(selectedScreenControllerProvider);
    final authController = ref.watch(authControllerProvider.notifier);

    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 70,
          bottom: 30,
          right: 20,
          left: 20,
        ),
        child: Column(
          children: [
            Icon(Icons.person, size: 120, color: Colors.grey[600]),
            const SizedBox(height: 40),

            // home
            ListTile(
              onTap: () {
                ref
                    .read(selectedScreenControllerProvider.notifier)
                    .toggleSelectedScreen(DrawerScreens.posts);
                context.goNamed(AppRoute.posts.name);
              },
              title: const Text('P O S T S'),
              leading: Icon(
                Icons.home,
                color:
                    selectedScreen == DrawerScreens.posts
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey[600],
              ),
            ),

            // profile
            ListTile(
              onTap: () {
                ref
                    .read(selectedScreenControllerProvider.notifier)
                    .toggleSelectedScreen(DrawerScreens.account);
                context.goNamed(AppRoute.account.name);
              },
              title: const Text('A C C O U N T'),
              leading: Icon(
                Icons.person,
                color:
                    selectedScreen == DrawerScreens.account
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey[600],
              ),
            ),

            // search
            ListTile(
              onTap: () {
                ref
                    .read(selectedScreenControllerProvider.notifier)
                    .toggleSelectedScreen(DrawerScreens.search);
                context.goNamed(AppRoute.search.name);
              },
              title: const Text('S E A R C H'),
              leading: Icon(
                Icons.search,
                color:
                    selectedScreen == DrawerScreens.search
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey[600],
              ),
            ),

            // settings
            ListTile(
              onTap: () {
                ref
                    .read(selectedScreenControllerProvider.notifier)
                    .toggleSelectedScreen(DrawerScreens.settings);
                context.goNamed(AppRoute.settings.name);
              },
              title: const Text('S E T T I N G S'),
              leading: Icon(
                Icons.settings,
                color:
                    selectedScreen == DrawerScreens.settings
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey[600],
              ),
            ),
            const Spacer(),

            // log out
            ListTile(
              onTap: () {
                authController.signOut();
              },
              title: const Text('L O G O U T'),
              leading: Icon(Icons.logout, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
