class Category {
  final int id;
  final String name;
  final bool isFavorite;

  Category({
    required this.id,
    required this.name,
    required this.isFavorite,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['attributes']?['categoryName'] ?? 'Unknown',
      isFavorite: json['attributes']?['isFavourite'] ?? false,
    );
  }
}
