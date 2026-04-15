class ProductFavoriteEntity {
  final String price;
  final String title;
  final String image;

  final int? productId;

  ProductFavoriteEntity({
    required this.price,
    required this.title,
    required this.image,
    this.productId,
  });
}
