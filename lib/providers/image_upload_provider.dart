import 'dart:async';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ImageUploadProvider extends AsyncNotifier<void> {
  @override
  build() {}
  Future<void> uploadImage(File image, String fileName, String table) async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final supaBase = Supabase.instance.client;
      await supaBase.storage.from('images/$table').update(fileName, image);
    });
  }

  String getImageUrl(String fileName, String table) {
    final supaBase = Supabase.instance.client;
    final url = supaBase.storage.from(table).getPublicUrl(fileName);
    return url;
  }
}

final uploadImageProvider = AsyncNotifierProvider<ImageUploadProvider, void>(
  ImageUploadProvider.new,
);
