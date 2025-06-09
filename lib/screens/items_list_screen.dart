import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lab60/screens/add_item_screen.dart';

import '../providers/items_provider.dart';
import '../widgets/center_container.dart';
import '../widgets/center_indicator.dart';

class ItemsListScreen extends ConsumerStatefulWidget {
  const ItemsListScreen({super.key});

  @override
  ConsumerState createState() => _ItemsListScreenState();
}

class _ItemsListScreenState extends ConsumerState<ItemsListScreen> {
  void goToAddScreen() async {
    await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (ctx) => AddItemScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final itemState = ref.watch(itemListProvider);
    Widget body = switch (itemState) {
      AsyncData(value: final item) =>
        item.isEmpty
            ? CenterContainer(
              title: 'No items',
              iconData: Icons.list,
              buttonText: 'Add item',
              onButtonPressed: goToAddScreen,
            )
            : Center(child: Text('Something is Here')),
      AsyncError() => CenterContainer(
        title: 'Something went wrong',
        iconData: Icons.error,
        buttonText: 'Try again',
        onButtonPressed: () => ref.invalidate(itemListProvider),
      ),
      _ => CenterIndicator(),
    };
    return Scaffold(
      appBar: AppBar(
        title: Text('Office Items Checker'),
        actions: [
          IconButton(
            onPressed: goToAddScreen,
            icon: Icon(Icons.add_circle_outline_sharp),
          ),
        ],
      ),
      body: body,
    );
  }
}
