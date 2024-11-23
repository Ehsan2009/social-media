import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media/components/custom_text_field.dart';
import 'package:social_media/models/post.dart';
import 'package:social_media/services/post_services.dart';
import 'package:social_media/services/user_services.dart';

class UploadPostScreen extends StatefulWidget {
  const UploadPostScreen({super.key});

  @override
  State<UploadPostScreen> createState() => _UploadPostScreenState();
}

class _UploadPostScreenState extends State<UploadPostScreen> {
  File? _pickedImageFile;
  final captionController = TextEditingController();
  var isUploading = false;

  void uploadPost() async {
    setState(() {
      isUploading = true;
    });

    final currentUser = await UserServices().currentUser();

    final postImageUrl =
        await UserServices().getUserProfileUrl(_pickedImageFile!, 'posts');

    final newPost = Post(
      userId: currentUser.id,
      profileUrl: currentUser.profileUrl,
      name: currentUser.name,
      caption: captionController.text,
      imageUrl: postImageUrl,
      likers: [],
      comments: [],
    );

    await PostServices().addPost(newPost);

    captionController.clear();

    setState(() {
      isUploading = false;
    });
  }

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
              onPressed: uploadPost,
              icon: isUploading
                  ? const CircularProgressIndicator(color: Colors.blueAccent)
                  : const Icon(Icons.upload),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // selected image
                if (_pickedImageFile != null)
                  Image.file(_pickedImageFile!, height: 300),

                const SizedBox(height: 20),

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
                CustomTextField(
                  controller: captionController,
                  hintText: 'Caption',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
