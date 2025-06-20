class ItemLocation {
  final String? id;
  final String title;
  final String description;
  final String imageURL;

  ItemLocation({
    this.id,
    required this.title,
    required this.description,
    required this.imageURL,
  });

  Map<String, dynamic> toJson() {
    return {'title': title, 'description': description, 'imageURL': imageURL};
  }

  factory ItemLocation.fromJson(Map<String, dynamic> json) {
    return ItemLocation(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageURL: json['imageURL'],
    );
  }
}
