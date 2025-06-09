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
  final colors = ref.watch(itemsCategoriesProvider);
  return colors.firstWhere((c) => c.id == id);
});

final itemsLocationProvider = Provider<List<ItemLocation>>((ref) {
  return itemLocations;
});

final selectedItemLocation = StateProvider<String?>((ref) => null);

final itemLocationByIdProvider = Provider.family<ItemLocation, String>((
  ref,
  id,
) {
  final colors = ref.watch(itemsLocationProvider);
  return colors.firstWhere((c) => c.id == id);
});
