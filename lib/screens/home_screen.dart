import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_media/components/post_tile.dart';
import 'package:social_media/components/shimmer_post_tile.dart';
import 'package:social_media/models/app_user.dart';
import 'package:social_media/models/post.dart';
import 'package:social_media/services/user_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AppUser? currentUser;

  void fetchCurrentUser() async {
    currentUser = await UserServices().currentUser();
  }

  @override
  void initState() {
    super.initState();
    fetchCurrentUser();
  }

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
                Icons.person,
                size: 120,
                color: Colors.grey[600],
              ),
              const SizedBox(height: 40),

              // home
              ListTile(
                onTap: () {
                  context.pop();
                },
                title: const Text('H O M E'),
                leading: Icon(
                  Icons.home,
                  color: Colors.grey[600],
                ),
              ),

              // profile
              ListTile(
                onTap: () {
                  context.push('/profile_screen', extra: currentUser);
                },
                title: const Text('P R O F I L E'),
                leading: Icon(
                  Icons.person,
                  color: Colors.grey[600],
                ),
              ),

              // search
              ListTile(
                onTap: () {
                  context.push('/search_screen');
                },
                title: const Text('S E A R C H'),
                leading: Icon(
                  Icons.search,
                  color: Colors.grey[600],
                ),
              ),

              // settings
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

              // log out
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
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('posts').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Shimmer.fromColors(
                baseColor: Colors.grey.shade400,
                highlightColor: const Color.fromRGBO(255, 255, 255, 1),
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (ctx, index) {
                    return const ShimmerPostTile();
                  },
                ),
              );
            }

            if (!snapshot.hasData) {
              return Center(
                child: Text('There is not post here, try adding some!'),
              );
            }

            final posts = snapshot.data!.docs
                .map((doc) => Post.fromMap(doc.data()))
                .toList();

            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (ctx, index) {
                return PostTile(
                  post: posts[index],
                );
              },
            );
          }),
    );
  }
}
