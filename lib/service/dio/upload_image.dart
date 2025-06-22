import 'dart:io';
import 'package:dio/dio.dart';

Future<String?> uploadImage(File imageFile) async {
  final cloudinaryUrl = 'https://api.cloudinary.com/v1_1/dbqiad4hf/image/upload';
  final uploadPreset = 'user-class';

  final formData = FormData.fromMap({
    'file': await MultipartFile.fromFile(imageFile.path),
    'upload_preset': uploadPreset,
  });

  final dio = Dio();

  try {
    final response = await dio.post(cloudinaryUrl, data: formData);
    final imageUrl = response.data['secure_url'];
    print('Uploaded: $imageUrl');
    return imageUrl;
  } catch (e) {
    print('Upload failed: $e');
    return null;
  }
}
