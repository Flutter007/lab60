import 'dart:async';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supaBase = Supabase.instance.client;

final selectedCategoryImage = StateProvider<File?>((ref) => null);
final selectedLocationImage = StateProvider<File?>((ref) => null);
final selectedItemImage = StateProvider<File?>((ref) => null);

class ImageUploadProvider extends AsyncNotifier<void> {
  @override
  build() {}
  Future<void> uploadImage(File image, String fileName, String folder) async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await supaBase.storage.from('images/$folder').update(fileName, image);
    });
  }

  String getImageUrl(String fileName, String folder) {
    final url = supaBase.storage.from('images/$folder').getPublicUrl(fileName);
    return url;
  }
}

final uploadImageProvider = AsyncNotifierProvider<ImageUploadProvider, void>(
  ImageUploadProvider.new,
);
