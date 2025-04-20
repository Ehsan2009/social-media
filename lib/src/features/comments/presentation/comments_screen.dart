import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media/src/common_widgets/custom_text_field.dart';
import 'package:social_media/src/features/comments/presentation/comments_controller.dart';
import 'package:social_media/src/features/posts/data/posts_repository.dart';
import 'package:social_media/src/features/posts/domain/post.dart';

class CommentsScreen extends ConsumerStatefulWidget {
  const CommentsScreen({super.key, required this.post});

  final Post post;

  @override
  ConsumerState<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends ConsumerState<CommentsScreen> {
  final commentController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final commentState = ref.watch(commentsControllerProvider);
    
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
              child: Consumer(
                builder: (context, ref, child) {
                  final postAsync = ref.watch(
                    userPostProvider(widget.post.userId, widget.post.postId),
                  );
                  return postAsync.when(
                    data: (post) {
                      if (post.comments.isEmpty) {
                        return const Center(
                          child: Text('There is no comment for this post!'),
                        );
                      }

                      return ListView.builder(
                        itemCount: post.comments.length,
                        itemBuilder: (ctx, index) {
                          return Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  post.comments[index],
                                  style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: 20,
                                  ),
                                ),
                                const Divider(),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    error: (error, _) => Text(error.toString()),
                    loading: () => CircularProgressIndicator(),
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
            
                    ref
                        .read(commentsControllerProvider.notifier)
                        .addCommentToPost(
                          widget.post.postId,
                          widget.post.userId,
                          commentController.text,
                        );

                    commentController.clear();
                  },
                  shape: const CircleBorder(),
                  elevation: 0,
                  backgroundColor: Colors.lightGreen,
                  child:
                      commentState.isLoading
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
