import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media/src/common_widgets/custom_text_field.dart';
import 'package:social_media/src/features/posts/presentation/upload_post/upload_post_controller.dart';

class UploadPostScreen extends ConsumerStatefulWidget {
  const UploadPostScreen({super.key});

  @override
  ConsumerState<UploadPostScreen> createState() => _UploadPostScreenState();
}

class _UploadPostScreenState extends ConsumerState<UploadPostScreen> {
  File? _pickedImageFile;
  final captionController = TextEditingController();

  void _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );

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
    final uploadPostState = ref.watch(uploadPostControllerProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text(
          'U P L O A D',
          style: GoogleFonts.roboto(fontSize: 18, color: Colors.grey[700]),
        ),
        centerTitle: true,
        actions: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed:
                  uploadPostState.isLoading
                      ? null
                      : () {
                        ref
                            .read(uploadPostControllerProvider.notifier)
                            .uploadPost(
                              _pickedImageFile!,
                              captionController.text,
                            );

                        captionController.clear();
                      },
              icon:
                  uploadPostState.isLoading
                      ? const CircularProgressIndicator(
                        color: Colors.blueAccent,
                      )
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
