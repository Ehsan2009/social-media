import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media/components/post_tile.dart';
import 'package:social_media/data/dummy_posts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: Drawer(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 70, bottom: 30, right: 20, left: 20),
          child: Column(
            children: [
              Icon(
                Icons.lock_open_outlined,
                size: 120,
                color: Colors.grey[600],
              ),
              // Image.asset(
              //   'assets/images/chat.png',
              //   width: 120,
              //   color: Colors.grey[600],
              // ),
              const SizedBox(height: 40),
              ListTile(
                title: const Text('H O M E'),
                leading: Icon(
                  Icons.home,
                  color: Colors.grey[600],
                ),
              ),
              ListTile(
                onTap: () {
                  context.push('/settings_screen');
                },
                title: const Text('S E T T I N G S'),
                leading: Icon(
                  Icons.settings,
                  color: Colors.grey[600],
                ),
              ),
              const Spacer(),
              ListTile(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  context.go('/');
                },
                title: const Text('L O G O U T'),
                leading: Icon(
                  Icons.logout,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: const Text(
          'HOME',
          style: TextStyle(letterSpacing: 4),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              context.push('/upload_post_screen');
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: dummyPosts.length,
        itemBuilder: (ctx, index) {
          return PostTile(
            post: dummyPosts[index],
          );
        },
      ),
    );
  }
}
