import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lab60/models/item_category.dart';
import 'package:lab60/models/item_location.dart';
import 'package:lab60/widgets/add_item_category_location_form/add_item_category_form_controllers.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final selectedItemCategory = StateProvider<String?>((ref) => null);

final itemCategoriesProvider = FutureProvider<List<ItemCategory>>((ref) async {
  final supaBase = Supabase.instance.client;
  final response = await supaBase.from('itemCategories').select();
  List<ItemCategory> itemCategories = [];
  for (var row in response) {
    final itemCategory = ItemCategory.fromJson(row);
    itemCategories.add(itemCategory);
  }
  return itemCategories;
});
final selectedItemLocation = StateProvider<String?>((ref) => null);

final itemLocationsProvider = FutureProvider<List<ItemLocation>>((ref) async {
  final supaBase = Supabase.instance.client;
  final response = await supaBase.from('itemLocations').select();
  List<ItemLocation> itemLocations = [];
  for (var row in response) {
    final itemLocation = ItemLocation.fromJson(row);
    itemLocations.add(itemLocation);
  }
  return itemLocations;
});

class CreateItemCategoryNotifier extends AsyncNotifier<void> {
  @override
  build() {}
  Future<void> createItemCategory(
    AddItemCategoryLocationFormControllers controller,
  ) async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final supaBase = Supabase.instance.client;
      final itemCategory = ItemCategory(
        title: controller.titleController.text.trim(),
        description: controller.descriptionController.text.trim(),
        imageURL: controller.imageURLController.text.trim(),
      );
      await supaBase.from('itemCategories').insert(itemCategory.toJson());
    });
  }
}

final categoryByIdProvider = FutureProvider.family<ItemCategory?, String>((
  ref,
  categoryId,
) async {
  final itemCategories = await ref.watch(itemCategoriesProvider.future);
  return itemCategories.firstWhere((c) => c.id == categoryId);
});

final locationByIdProvider = FutureProvider.family<ItemLocation?, String>((
  ref,
  locationId,
) async {
  final itemLocations = await ref.watch(itemLocationsProvider.future);
  return itemLocations.firstWhere((c) => c.id == locationId);
});
final createItemCategoryProvider =
    AsyncNotifierProvider<CreateItemCategoryNotifier, void>(
      CreateItemCategoryNotifier.new,
    );

final selectedDateProvider = StateProvider<DateTime>(
  (ref) =>
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
);

class CreateItemLocationNotifier extends AsyncNotifier<void> {
  @override
  build() {}
  Future<void> createItemLocation(
    AddItemCategoryLocationFormControllers controller,
  ) async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final supaBase = Supabase.instance.client;
      final itemLocation = ItemLocation(
        title: controller.titleController.text.trim(),
        description: controller.descriptionController.text.trim(),
        imageURL: controller.imageURLController.text.trim(),
      );
      await supaBase.from('itemLocations').insert(itemLocation.toJson());
    });
  }
}

final createItemLocationProvider =
    AsyncNotifierProvider<CreateItemLocationNotifier, void>(
      CreateItemLocationNotifier.new,
    );
