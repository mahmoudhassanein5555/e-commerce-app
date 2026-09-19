class SearchEntity {
  final int id;
  final String title;
  final String brand;
  final num price;
  final String image;
  final List<String> images;
  final String description;
  final String slug;
  final String category;
  final bool isFavorite;

  SearchEntity({
    this.id = 0,
    this.title = "",
    this.brand = "",
    this.price = 0,
    this.image = "",
    this.images = const [],
    this.description = "",
    this.slug = "",
    this.category = "",
    this.isFavorite = false,
  });
}

