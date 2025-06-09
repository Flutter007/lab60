class Item {
  final String? id;
  final String name;
  final String itemCategoryId;
  final String itemLocationId;
  final String? description;
  final String imageURL;
  final DateTime addedAt;

  Item({
    this.id,
    required this.name,
    required this.itemCategoryId,
    required this.itemLocationId,
    this.description,
    required this.imageURL,
    required this.addedAt,
  });
  Map<String?, dynamic> toJson() {
    return {
      'name': name,
      'itemCategoryId': itemCategoryId,
      'itemLocationId': itemLocationId,
      if (description != null) 'description': description,
      'imageURL': imageURL,
      'addedAt': addedAt.toUtc().toIso8601String(),
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
      addedAt: DateTime.parse(json['addedAt']),
    );
  }
}
