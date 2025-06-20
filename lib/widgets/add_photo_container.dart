import 'package:flutter/material.dart';

class AddPhotoContainer extends StatelessWidget {
  final void Function() onCameraTap;
  final void Function() onGalleryTap;
  const AddPhotoContainer({
    super.key,
    required this.onCameraTap,
    required this.onGalleryTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.primary, width: 4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Icon(Icons.add_a_photo, size: 100),
          ElevatedButton.icon(
            onPressed: onCameraTap,
            icon: Icon(Icons.camera_alt),
            label: Text('Фото с камеры :'),
          ),
          SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: onGalleryTap,
            icon: Icon(Icons.photo),
            label: Text('Фото из галереи'),
          ),
        ],
      ),
    );
  }
}
