import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search users...',
            helperStyle: TextStyle(color: Colors.grey[600]),
            border: InputBorder.none,
          ),
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Start searching for users!',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
