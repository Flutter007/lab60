import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lab60/helpers/date_format.dart';
import 'package:lab60/widgets/custom_text.dart';

import '../models/item.dart';

class SingleItemInfo extends ConsumerWidget {
  final Item item;
  const SingleItemInfo({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemCategory = item.itemCategory;
    final itemLocation = item.itemLocation;

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
            subtitle: Text(itemCategory['title']!),
          ),
          ListTile(
            title: CustomText(txt: 'Category description ⬇:'),
            subtitle: Text(itemCategory['description']!),
          ),
          ListTile(
            title: CustomText(txt: 'Location 📍 :'),
            subtitle: Text(itemLocation['title']!),
          ),
          ListTile(
            title: CustomText(txt: 'Location description ⬇ :'),
            subtitle: Text(itemLocation['description']!),
          ),
          if (item.description != null)
            ListTile(
              title: CustomText(txt: 'Description :'),
              subtitle: Text(item.description!),
            ),
          CustomText(txt: 'Image of item ⬇'),
          Container(
            width: 200,
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              image: DecorationImage(
                image: NetworkImage(item.imageURL),
                fit: BoxFit.fill,
              ),
            ),
            margin: EdgeInsets.all(20),
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
