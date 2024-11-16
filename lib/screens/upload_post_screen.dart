import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media/models/post.dart';
import 'package:social_media/services/current_user.dart';
import 'package:social_media/services/post_services.dart';
import 'package:social_media/services/upload_image.dart';

class UploadPostScreen extends StatefulWidget {
  const UploadPostScreen({super.key});

  @override
  State<UploadPostScreen> createState() => _UploadPostScreenState();
}

class _UploadPostScreenState extends State<UploadPostScreen> {
  File? _pickedImageFile;
  final captionController = TextEditingController();

  void _pickImage() async {
    final pickedImage = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 100);

    if (pickedImage == null) {
      return;
    }

    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });
  }

  @override
  void dispose() {
    super.dispose();
    captionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text(
          'U P L O A D',
          style: GoogleFonts.roboto(
            fontSize: 18,
            color: Colors.grey[700],
          ),
        ),
        centerTitle: true,
        actions: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () async {
                final currentUser = await CurrentUser().currentUser();

                final postImageUrl = await UploadImage()
                    .getUserProfileUrl(_pickedImageFile!, 'posts');

                final newPost = Post(
                  profileUrl: currentUser.profileUrl,
                  name: currentUser.name,
                  caption: captionController.text,
                  imageUrl: postImageUrl,
                  likesCount: 0,
                  commentsCount: 0,
                  comments: [],
                );

                await PostServices().addPost(newPost);

                captionController.clear();
              },
              icon: const Icon(Icons.upload),
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // selected image
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey,
                foregroundImage: _pickedImageFile != null
                    ? FileImage(_pickedImageFile!)
                    : null,
                child: const Icon(Icons.camera_alt),
              ),

              // upload button
              MaterialButton(
                onPressed: _pickImage,
                color: Colors.blue,
                child: const Text(
                  'Pick Image',
                  style: TextStyle(color: Colors.black),
                ),
              ),

              const SizedBox(height: 30),

              // caption TextFormField
              TextField(
                controller: captionController,
                decoration: InputDecoration(
                  hintText: 'Caption',
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  filled: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
