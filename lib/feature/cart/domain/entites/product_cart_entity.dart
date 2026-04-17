class ProductCartEntity {
  final int id;
  final String title;
  final String image;
  final String price;
  final int quantity;

  const ProductCartEntity({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    required this.quantity,
  });

  ProductCartEntity copyWith({
    int? id,
    String? title,
    String? image,
    String? price,
    int? quantity,
  }) {
    return ProductCartEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }
}
