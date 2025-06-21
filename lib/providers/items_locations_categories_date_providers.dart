import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lab60/models/item_category.dart';
import 'package:lab60/models/item_location.dart';
import 'package:lab60/widgets/add_item_category_location_form/add_item_category_location_form_controllers.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supaBase = Supabase.instance.client;

final selectedItemCategory = StateProvider<String?>((ref) => null);
final selectedItemLocation = StateProvider<String?>((ref) => null);
final selectedDateProvider = StateProvider<DateTime>(
  (ref) =>
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
);

final itemCategoriesProvider = FutureProvider<List<ItemCategory>>((ref) async {
  final response = await supaBase.from('itemCategories').select();
  List<ItemCategory> itemCategories = [];
  for (var row in response) {
    final itemCategory = ItemCategory.fromJson(row);
    itemCategories.add(itemCategory);
  }
  return itemCategories;
});

final itemLocationsProvider = FutureProvider<List<ItemLocation>>((ref) async {
  final response = await supaBase.from('itemLocations').select();
  List<ItemLocation> itemLocations = [];
  for (var row in response) {
    final itemLocation = ItemLocation.fromJson(row);
    itemLocations.add(itemLocation);
  }
  return itemLocations;
});

class CreateItemCategoryLocationNotifier extends AsyncNotifier<void> {
  @override
  build() {}
  Future<void> createItemLocationCategory(
    AddItemCategoryLocationFormControllers controller,
    String fileName, {
    String classType = 'itemCategories',
  }) async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      if (classType == 'itemCategories') {
        final itemCategory = ItemCategory(
          title: controller.titleController.text.trim(),
          description: controller.descriptionController.text.trim(),
          imageURL: fileName,
        );
        await supaBase.from('itemCategories').insert(itemCategory.toJson());
      } else {
        final itemLocation = ItemLocation(
          title: controller.titleController.text.trim(),
          description: controller.descriptionController.text.trim(),
          imageURL: fileName,
        );
        await supaBase.from('itemLocations').insert(itemLocation.toJson());
      }
    });
  }
}

final createItemCategoryLocationProvider =
    AsyncNotifierProvider<CreateItemCategoryLocationNotifier, void>(
      CreateItemCategoryLocationNotifier.new,
    );
