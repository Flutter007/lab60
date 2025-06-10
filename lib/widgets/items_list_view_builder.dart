import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/item.dart';
import '../providers/items_provider.dart';
import '../screens/single_item_info_screen.dart';
import 'custom_text.dart';
import 'item_card.dart';

class ItemsListViewBuilder extends ConsumerWidget {
  final List<Item> items;
  const ItemsListViewBuilder({super.key, required this.items});

  void goToSinglePostScreen(
    BuildContext context,
    WidgetRef ref,
    String itemID,
  ) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => SingleItemInfoScreen(id: itemID)),
    );
    if (result == true) {
      ref.invalidate(itemListProvider);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder:
                  (ctx, i) => ItemCard(
                    item: items[i],
                    onTap:
                        () => goToSinglePostScreen(context, ref, items[i].id!),
                  ),
            ),
          ),
          CustomText(txt: 'Total items: ${items.length}'),
        ],
      ),
    );
  }
}
