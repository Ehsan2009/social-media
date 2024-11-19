import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({
    super.key,
    required this.onPickImage,
    required this.source,
    required this.boxRadius,
  });

  final void Function(File pickedImage) onPickImage;
  final ImageSource source;
  final double boxRadius;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImageFile;

  void _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: widget.source,
      imageQuality: 100
    );

    if (pickedImage == null) {
      return;
    }

    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });

    widget.onPickImage(_pickedImageFile!);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: CircleAvatar(
        radius: widget.boxRadius,
        backgroundColor: Colors.grey,
        foregroundImage:
            _pickedImageFile != null ? FileImage(_pickedImageFile!) : null,
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}