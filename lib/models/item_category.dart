class ItemCategory {
  final String? id;
  final String title;
  final String description;
  final String imageURL;

  ItemCategory({
    this.id,
    required this.title,
    required this.description,
    required this.imageURL,
  });
  Map<String, dynamic> toJson() {
    return {'title': title, 'description': description, 'imageURL': imageURL};
  }

  factory ItemCategory.fromJson(Map<String, dynamic> json) {
    return ItemCategory(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageURL: json['imageURL'],
    );
  }
}
