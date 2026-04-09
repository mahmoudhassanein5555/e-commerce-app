import 'package:hive/hive.dart';
//part 'product_favorite_model.g.dart';

@HiveType(typeId: 0)
class ProductFavoriteModel extends HiveObject {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String image;
  @HiveField(2)
  final String price;

  ProductFavoriteModel(
      {required this.title, required this.image, required this.price});
}
