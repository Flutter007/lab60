class Item {
  final String? id;
  final String name;
  final Map<String, dynamic> itemCategory;
  final Map<String, dynamic> itemLocation;
  final String? description;
  final String imageURL;
  final DateTime registeredAt;

  Item({
    this.id,
    required this.name,
    required this.itemCategory,
    required this.itemLocation,
    this.description,
    required this.imageURL,
    required this.registeredAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'itemCategory': itemCategory,
      'itemLocation': itemLocation,
      if (description != null) 'description': description,
      'imageURL': imageURL,
      'registeredAt': registeredAt.toUtc().toIso8601String(),
    };
  }

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      name: json['name'],
      itemCategory: json['itemCategory'],
      itemLocation: json['itemLocation'],
      description: json.containsKey('description') ? json['description'] : null,
      imageURL: json['imageURL'],
      registeredAt: DateTime.parse(json['registeredAt']),
    );
  }
}
