class Food {
  final int id;
  final String name;
  final String type;
  final bool isGlutenFree;
  final String steps;
  final String ingredients;
  final List<String> imageUrls;
  final bool isFavourite;

  Food({
    required this.id,
    required this.name,
    required this.type,
    required this.isGlutenFree,
    required this.steps,
    required this.ingredients,
    required this.imageUrls,
    required this.isFavourite,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'] ?? {};
    final foodPhotoData = attributes['foodPhoto']?['data'] as List<dynamic>? ?? [];

    // Convert dynamic list to List<String> for imageUrls
    final imageUrls = foodPhotoData
        .map((photo) => (photo['attributes']?['formats']?['thumbnail']?['url'] ?? '') as String)
        .where((url) => url.isNotEmpty)
        .toList();

    return Food(
      id: json['id'],
      name: attributes['foodName'] ?? 'Unknown',
      type: attributes['foodType'] ?? 'Unknown',
      isGlutenFree: attributes['isGlutenFree'] ?? false,
      steps: attributes['steps'] ?? 'No steps available',
      ingredients: attributes['ingredients'] ?? 'No ingredients provided',
      imageUrls: imageUrls,
      isFavourite: attributes['isFavourite'] ?? false,
    );
  }


  String get imageUrl {
    return imageUrls.isNotEmpty
        ? 'https://lecook.pirus.app${imageUrls.first}'
        : 'https://via.placeholder.com/150';
  }
}
