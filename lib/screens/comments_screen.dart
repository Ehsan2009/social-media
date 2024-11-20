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
            widget.post.comments.isEmpty
                ? const Center(
                    child: Text('There is no comment for this post!'),
                  )
                : Expanded(
                  child: ListView.builder(
                    itemCount: widget.post.comments.length,
                    itemBuilder: (ctx, index) {
                      return Text(
                        widget.post.comments[index],
                        style: const TextStyle(color: Colors.black),
                      );
                    },
                  ),
                ),
            const Spacer(),
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
                    final postServices = PostServices();
                    await postServices.addComment(
                        widget.post.id, commentController.text);

                    commentController.clear();
                    print(widget.post.comments);
                  },
                  shape: const CircleBorder(),
                  elevation: 0,
                  backgroundColor: Colors.lightGreen,
                  child: const Icon(Icons.arrow_upward_rounded),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
