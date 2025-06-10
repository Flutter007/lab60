import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lab60/data/item_locations_data.dart';
import 'package:lab60/models/item_category.dart';
import 'package:lab60/models/item_location.dart';
import '../data/item_category_data.dart';

final itemsCategoriesProvider = Provider<List<ItemCategory>>((ref) {
  return itemCategories;
});

final selectedItemCategory = StateProvider<String?>((ref) => null);

final itemCategoryByIdProvider = Provider.family<ItemCategory, String>((
  ref,
  id,
) {
  final categories = ref.watch(itemsCategoriesProvider);
  return categories.firstWhere((c) => c.id == id);
});

final itemsLocationProvider = Provider<List<ItemLocation>>((ref) {
  return itemLocations;
});

final selectedItemLocation = StateProvider<String?>((ref) => null);

final itemLocationByIdProvider = Provider.family<ItemLocation, String>((
  ref,
  id,
) {
  final locations = ref.watch(itemsLocationProvider);
  return locations.firstWhere((c) => c.id == id);
});

final selectedDateProvider = StateProvider<DateTime>(
  (ref) =>
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
);
