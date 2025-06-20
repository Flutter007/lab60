import 'package:lab60/models/item_category.dart';
import 'package:lab60/models/item_location.dart';

class Item {
  final String? id;
  final String name;
  final String? itemCategoryId;
  final ItemCategory? itemCategory;
  final String? itemLocationId;
  final ItemLocation? itemLocation;
  final String? description;
  final String imageURL;
  final DateTime registeredAt;

  Item({
    this.id,
    required this.name,
    required this.itemCategoryId,
    this.itemCategory,
    required this.itemLocationId,
    this.itemLocation,
    this.description,
    required this.imageURL,
    required this.registeredAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'itemCategoryId': itemCategoryId,
      'itemLocationId': itemLocationId,
      if (description != null) 'description': description,
      'imageURL': imageURL,
      'registeredAt': registeredAt.toUtc().toIso8601String(),
    };
  }

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      name: json['name'],
      itemCategoryId: json['itemCategoryId'],

      itemLocationId: json['itemLocationId'],

      description: json.containsKey('description') ? json['description'] : null,
      imageURL: json['imageURL'],
      registeredAt: DateTime.parse(json['registeredAt']),
    );
  }
}
