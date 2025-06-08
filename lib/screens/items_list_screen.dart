import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lab60/screens/add_item_screen.dart';

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
      body: Placeholder(),
    );
  }
}
