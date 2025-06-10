import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lab60/providers/items_provider.dart';
import 'package:lab60/widgets/single_item_info.dart';

import '../widgets/center_event_container.dart';

class SingleItemInfoScreen extends ConsumerStatefulWidget {
  final String id;
  const SingleItemInfoScreen({super.key, required this.id});

  @override
  ConsumerState createState() => _SingleItemInfoScreenState();
}

class _SingleItemInfoScreenState extends ConsumerState<SingleItemInfoScreen> {
  @override
  Widget build(BuildContext context) {
    final itemState = ref.watch(singleItemProvider(widget.id));
    Widget body = switch (itemState) {
      AsyncData(value: final item) =>
        item == null ? Text('Loading...') : SingleItemInfo(item: item),
      AsyncError() => CenterEventContainer(
        title: 'Something went wrong',
        iconData: Icons.error,
        buttonText: 'Try again',
        onButtonPressed: () => ref.invalidate(singleItemProvider(widget.id)),
      ),
      _ => Center(child: CircularProgressIndicator()),
    };
    return Scaffold(
      appBar: AppBar(
        title:
            itemState.value == null
                ? Text('Loading ...')
                : Text(itemState.value!.name),
      ),
      body: body,
    );
  }
}
