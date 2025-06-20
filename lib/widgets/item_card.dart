import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lab60/providers/items_locations_categories_date_providers.dart';
import 'package:lab60/widgets/center_indicator.dart';
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
        ref.watch(categoryByIdProvider(item.itemCategoryId!)).value;
    final itemLocation =
        ref.watch(locationByIdProvider(item.itemLocationId!)).value;
    Widget body =
        itemCategory == null || itemLocation == null
            ? CenterIndicator()
            : Padding(
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
                        subtitle: CustomText(txt: itemCategory.title),
                      ),
                      ListTile(
                        title: Text('Located at :'),
                        subtitle: CustomText(txt: itemLocation.title),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: CustomText(
                          txt: dateFormat.format(item.registeredAt),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
    return body;
  }
}
