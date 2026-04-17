import 'package:hive/hive.dart';

part 'product_cart_model.g.dart';

@HiveType(typeId: 1)
class ProductCartModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String image;

  @HiveField(3)
  final String price;

  @HiveField(4)
  final int quantity;

  ProductCartModel({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    required this.quantity,
  });
}
