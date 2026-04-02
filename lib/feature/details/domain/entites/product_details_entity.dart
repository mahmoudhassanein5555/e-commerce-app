class ProductDetailsEntity {
  final int id;
  final String title;
  final String slug;
  final int price;
  final String description;
  final CategoryEntity category;
  final List<String> images;

  const ProductDetailsEntity({
    this.id = 0,
    this.title = "",
    this.slug = "",
    this.price = 0,
    this.description = "",
    this.category = const CategoryEntity(),
    this.images = const [],
  });
}

class CategoryEntity {
  final int id;
  final String name;
  final String slug;
  final String image;

  const CategoryEntity({
    this.id = 0,
    this.name = "",
    this.slug = "",
    this.image = "",
  });
}
