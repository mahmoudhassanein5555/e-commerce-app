import 'package:e_commerce_app/feature/home/domain/entites/category_response_entity.dart';

class ProductsResponseEntity {
  int id;
  String title;
  String slug;
  num price;
  String description;
  CategoriesResponseEntity category;
  List<String> images;

  ProductsResponseEntity({
    this.id = 0,
    this.title = "",
    this.slug = "",
    this.price = 0,
    this.description = "",
    this.category = const CategoriesResponseEntity(),
    this.images = const [],
  });
}
