import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lab60/screens/items_list_screen.dart';

class Lab60 extends ConsumerWidget {
  const Lab60({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(home: ItemsListScreen());
  }
}
