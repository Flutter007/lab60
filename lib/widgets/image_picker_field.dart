import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'add_photo_container.dart';

class ImagePickerField extends ConsumerStatefulWidget {
  final StateProvider<File?> imageProvider;
  final void Function(File? photo) onPickImage;

  const ImagePickerField({
    super.key,
    required this.onPickImage,
    required this.imageProvider,
  });

  @override
  ConsumerState<ImagePickerField> createState() => _ImagePickerFieldState();
}

class _ImagePickerFieldState extends ConsumerState<ImagePickerField> {
  void openImagePicker(ImageSource source) async {
    final picker = ImagePicker();
    final photoPicker = await picker.pickImage(
      source: source,
      preferredCameraDevice: CameraDevice.front,
      maxWidth: 1024,
    );
    if (photoPicker == null) {
      return;
    }
    final photo = File(photoPicker.path);
    setState(() {
      ref.read(widget.imageProvider.notifier).state = photo;
    });
    widget.onPickImage(photo);
  }

  void clearPhoto() {
    setState(() {
      ref.read(widget.imageProvider.notifier).state = null;
    });
    widget.onPickImage(null);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ref.read(widget.imageProvider.notifier).state == null
        ? AddPhotoContainer(
          onCameraTap: () => openImagePicker(ImageSource.camera),
          onGalleryTap: () => openImagePicker(ImageSource.gallery),
        )
        : LayoutBuilder(
          builder: (ctx, constraints) {
            final width = constraints.maxWidth - 80;
            return SizedBox(
              width: width,
              height: width,
              child: Stack(
                children: [
                  Image.file(
                    ref.read(widget.imageProvider.notifier).state!,
                    width: width,
                    height: width,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                  Positioned(
                    bottom: 3,
                    right: 3,
                    child: IconButton(
                      onPressed: clearPhoto,
                      icon: Icon(Icons.clear, color: theme.colorScheme.error),
                      style: IconButton.styleFrom(
                        backgroundColor: theme.primaryColor.withValues(
                          alpha: 0.3,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
  }
}
