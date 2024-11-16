import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:io';

class UploadImage {
  Future<String> getUserProfileUrl(File imageFile, String bucket) async {
    final supabase = Supabase.instance.client;
    final fileName =
        'image_${DateTime.now().millisecondsSinceEpoch}.jpg';

    await supabase.storage.from(bucket).upload(fileName, imageFile);

    final imageUrl = supabase.storage.from(bucket).getPublicUrl(fileName);

    return imageUrl;
  }
}