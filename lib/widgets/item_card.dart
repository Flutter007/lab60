import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lab60/providers/items_locations_categories_date_providers.dart';
import '../helpers/date_format.dart';
import '../models/item.dart';
import 'custom_text.dart';

class ItemCard extends ConsumerWidget {
  final Item item;
  final void Function() onTap;
  const ItemCard({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemCategory =
        ref.watch(itemCategoryByIdProvider(item.itemCategoryId)).title;
    final itemLocation =
        ref.watch(itemLocationByIdProvider(item.itemLocationId)).title;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: InkWell(
        onTap: onTap,
        child: Card(
          elevation: 9,
          child: Column(
            children: [
              ListTile(
                title: Text('Name :'),
                subtitle: CustomText(txt: item.name),
              ),
              ListTile(
                title: Text('Category :'),
                subtitle: CustomText(txt: itemCategory),
              ),
              ListTile(
                title: Text('Located at :'),
                subtitle: CustomText(txt: itemLocation),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: CustomText(txt: dateFormat.format(item.registeredAt)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
