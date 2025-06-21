import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lab60/helpers/date_format.dart';
import 'package:lab60/providers/image_upload_provider.dart';
import 'package:lab60/widgets/custom_text.dart';
import '../models/item.dart';
import 'image_container.dart';

class SingleItemInfo extends ConsumerWidget {
  final Item item;
  const SingleItemInfo({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListTile(
            title: CustomText(txt: 'Name  ⬇:'),
            subtitle: Text(item.name),
          ),
          ListTile(
            title: CustomText(txt: 'Category ⬇ :'),
            subtitle: Text(item.itemCategory!.title),
          ),
          ListTile(
            title: CustomText(txt: 'Category description ⬇:'),
            subtitle: Text(item.itemCategory!.description),
          ),
          ListTile(
            title: CustomText(txt: 'Location 📍 :'),
            subtitle: Text(item.itemLocation!.title),
          ),
          ListTile(
            title: CustomText(txt: 'Location description ⬇ :'),
            subtitle: Text(item.itemLocation!.description),
          ),
          if (item.description != null)
            ListTile(
              title: CustomText(txt: 'Description :'),
              subtitle: Text(item.description!),
            ),

          ImageContainer(
            imageDescription: 'Image of item ⬇',
            imageURL: ref
                .read(uploadImageProvider.notifier)
                .getImageUrl(item.imageURL, 'items_images'),
          ),
          ImageContainer(
            imageDescription: 'Image of category ⬇',
            imageURL: ref
                .read(uploadImageProvider.notifier)
                .getImageUrl(
                  item.itemCategory!.imageURL,
                  'items_categories_images',
                ),
          ),
          ImageContainer(
            imageDescription: 'Image of location ⬇',
            imageURL: ref
                .read(uploadImageProvider.notifier)
                .getImageUrl(
                  item.itemLocation!.imageURL,
                  'items_locations_images',
                ),
          ),
          ListTile(
            title: CustomText(txt: 'Date of registration 🕐 :'),
            subtitle: Text(dateFormat.format(item.registeredAt)),
          ),
        ],
      ),
    );
  }
}
