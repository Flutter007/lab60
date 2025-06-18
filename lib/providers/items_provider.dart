import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lab60/helpers/request.dart';
import 'package:lab60/models/item.dart';
import 'package:lab60/widgets/add_item_form/add_item_form_controllers.dart';
import 'items_locations_categories_date_providers.dart';

final baseURl =
    'https://my-db-7777-default-rtdb.europe-west1.firebasedatabase.app';
final itemListProvider = FutureProvider<List<Item>>((ref) async {
  final url = '$baseURl/items.json';
  Map<String, dynamic>? response = await request(url);
  if (response == null) {
    return [];
  }
  List<Item> items = [];
  for (var key in response.keys) {
    final item = Item.fromJson({...response[key], 'id': key});
    items.add(item);
  }

  items.sort((a, b) {
    int dateCompare = b.registeredAt.compareTo(a.registeredAt);
    if (dateCompare == 0) {
      return a.name.trim().toLowerCase().compareTo(b.name.trim().toLowerCase());
    }
    return dateCompare;
  });
  return items;
});

class CreateItemNotifier extends AsyncNotifier<void> {
  @override
  build() {}
  Future<void> createItem(AddItemFormControllers controller) async {
    final url = '$baseURl/items.json';

    final selectedDate = ref.read(selectedDateProvider);
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final item = Item(
        name: controller.nameController.text.trim(),
        itemCategory: {},
        itemLocation: {},
        imageURL: controller.imageURLController.text.trim(),
        description:
            controller.descriptionController.text.trim().isEmpty
                ? null
                : controller.descriptionController.text.trim(),
        registeredAt: selectedDate,
      );
      await request(url, method: 'POST', body: item.toJson());
    });
  }
}

final createItemProvider = AsyncNotifierProvider<CreateItemNotifier, void>(
  CreateItemNotifier.new,
);

final singleItemProvider = FutureProvider.family<Item?, String>((
  ref,
  itemId,
) async {
  final url = '$baseURl/items/$itemId.json';
  final response = await request(url);
  if (response == null) return null;
  final item = Item.fromJson({...response, 'id': itemId});
  return item;
});
