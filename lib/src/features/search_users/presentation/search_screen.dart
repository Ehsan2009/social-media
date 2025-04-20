import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media/src/common_widgets/app_drawer.dart';
import 'package:social_media/src/features/search_users/presentation/user_card.dart';
import 'package:social_media/src/features/authentication/domain/app_user.dart';
import 'package:social_media/src/features/search_users/presentation/search_controller.dart';
import 'package:social_media/src/shared/current_user_provider.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  List<AppUser> users = [];
  List<AppUser> filteredUsers = [];
  final TextEditingController searchController = TextEditingController();

  void fetchAllUsers() async {
    final currentUser = await ref.read(appUserProvider.future);
    final allUsers = await ref.read(allUsersProvider.future);
    setState(() {
      users = allUsers.where((user) => user.id != currentUser.id).toList();
      filteredUsers = allUsers.where((user) => user.id != currentUser.id).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchAllUsers();

    // Listen for changes in the search field
    searchController.addListener(() {
      setState(() {
        filteredUsers =
            users
                .where(
                  (user) => user.name.toLowerCase().startsWith(
                    searchController.text.toLowerCase(),
                  ),
                )
                .toList();
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: TextField(
          controller: searchController,
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          decoration: InputDecoration(
            hintText: 'Search users...',
            helperStyle: TextStyle(color: Colors.grey[600]),
            border: InputBorder.none,
          ),
        ),
        centerTitle: true,
      ),
      body:
          searchController.text.isEmpty
              ? const Center(
                child: Text(
                  'Start searching for users!',
                  style: TextStyle(fontSize: 20),
                ),
              )
              : ListView.builder(
                itemCount: filteredUsers.length,
                itemBuilder: (context, index) {
                  return UserCard(user: filteredUsers[index]);
                },
              ),
    );
  }
}
