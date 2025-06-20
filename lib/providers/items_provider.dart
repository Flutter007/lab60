import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lab60/models/item.dart';
import 'package:lab60/widgets/add_item_form/add_item_form_controllers.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/item_category.dart';
import '../models/item_location.dart';
import 'items_locations_categories_date_providers.dart';

final itemListProvider = FutureProvider<List<Item>>((ref) async {
  final supaBase = Supabase.instance.client;
  final response = await supaBase.from('items').select();
  final categories = await supaBase.from('itemCategories').select();
  final locations = await supaBase.from('itemLocations').select();

  List<Item> items = [];
  for (var row in response) {
    final itemCategory = ItemCategory.fromJson(
      categories.firstWhere((c) => c['id'] == row['itemCategoryId']),
    );
    final itemLocation = ItemLocation.fromJson(
      locations.firstWhere((c) => c['id'] == row['itemLocationId']),
    );
    final item = Item.fromJson(row, itemCategory, itemLocation);
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
  Future<void> createItem(
    AddItemFormControllers controller,
    String fileName,
  ) async {
    final selectedDate = ref.read(selectedDateProvider);
    final selectedCategory = ref.read(selectedItemCategory);
    final selectedLocation = ref.read(selectedItemLocation);

    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final item = Item(
        name: controller.nameController.text.trim(),
        itemCategoryId: selectedCategory!,
        itemLocationId: selectedLocation!,
        imageURL: fileName,
        description:
            controller.descriptionController.text.trim().isEmpty
                ? null
                : controller.descriptionController.text.trim(),
        registeredAt: selectedDate,
      );
      final supaBase = Supabase.instance.client;
      await supaBase.from('items').insert(item.toJson());
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
  final supaBase = Supabase.instance.client;
  final response =
      await supaBase.from('items').select().eq('id', itemId).single();
  final category =
      await supaBase
          .from('itemCategories')
          .select()
          .eq('id', response['itemCategoryId'])
          .single();
  final location =
      await supaBase
          .from('itemLocations')
          .select()
          .eq('id', response['itemLocationId'])
          .single();
  final itemCategory = ItemCategory.fromJson(category);
  final itemLocation = ItemLocation.fromJson(location);

  return Item.fromJson(response, itemCategory, itemLocation);
});
