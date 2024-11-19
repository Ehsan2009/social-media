import 'package:flutter/material.dart';
import 'package:social_media/components/user_card.dart';
import 'package:social_media/models/app_user.dart';
import 'package:social_media/services/user_services.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<AppUser> users = [];
  List<AppUser> filteredUsers = [];
  final TextEditingController searchController = TextEditingController();

  void fetchAllUsers() async {
    final userServices = UserServices();
    final allUsers = await userServices.allUsers();
    setState(() {
      users = allUsers;
      filteredUsers = allUsers; // Initially show all users
    });
  }

  @override
  void initState() {
    super.initState();
    fetchAllUsers();

    // Listen for changes in the search field
    searchController.addListener(() {
      setState(() {
        filteredUsers = users
            .where((user) => user.name
                .toLowerCase()
                .contains(searchController.text.toLowerCase()))
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
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: TextField(
          controller: searchController,
          style: const TextStyle(
            color: Colors.black,
          ),
          decoration: InputDecoration(
            hintText: 'Search users...',
            helperStyle: TextStyle(color: Colors.grey[600]),
            border: InputBorder.none,
          ),
        ),
        centerTitle: true,
      ),
      body: searchController.text.isEmpty
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
