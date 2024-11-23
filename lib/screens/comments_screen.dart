import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media/components/custom_text_field.dart';
import 'package:social_media/models/post.dart';
import 'package:social_media/services/post_services.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final commentController = TextEditingController();
  var isLoading = false;

  @override
  void dispose() {
    super.dispose();
    commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(widget.post.userId)
                    .snapshots(),
                builder: (ctx, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: Text('There is no comment for this post!'),
                    );
                  }

                  final userDoc = snapshot.data!;
                  final posts =
                      List<Map<String, dynamic>>.from(userDoc['posts']);

                  final post = posts.firstWhere(
                      (post) => post['postId'] == widget.post.postId);

                  final postModel = Post.fromMap(post);

                  return ListView.builder(
                    itemCount: postModel.comments.length,
                    itemBuilder: (ctx, index) {
                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              postModel.comments[index],
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 20,
                              ),
                            ),
                            const Divider()
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: commentController,
                    hintText: 'Write your comment',
                    borderSideColor: Colors.green,
                  ),
                ),
                const SizedBox(width: 16),
                FloatingActionButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    final postServices = PostServices();
                    await postServices.addComment(
                      widget.post.postId,
                      widget.post.userId,
                      commentController.text,
                    );

                    commentController.clear();

                    setState(() {
                      isLoading = false;
                    });
                  },
                  shape: const CircleBorder(),
                  elevation: 0,
                  backgroundColor: Colors.lightGreen,
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Icon(Icons.arrow_upward_rounded),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
