import 'package:e_commerce_app/feature/home/data/models/get_categories_response.dart';
import 'package:e_commerce_app/feature/home/domain/entites/category_response_entity.dart';
import 'package:e_commerce_app/feature/home/domain/entites/product_response_entity.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class ProductsResponseDto {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? title;
  String? slug;
  @HiveField(2)
  int? price;
  String? description;
  CategoriesResponseDto? category;
  @HiveField(3)
  List<String>? images;
  String? creationAt;
  String? updatedAt;

  ProductsResponseDto(
      {this.id,
      this.title,
      this.slug,
      this.price,
      this.description,
      this.category,
      this.images,
      this.creationAt,
      this.updatedAt});

  ProductsResponseDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    price = json['price'];
    description = json['description'];
    category = json['category'] != null
        ? CategoriesResponseDto.fromJson(json['category'])
        : null;
    images = json['images'].cast<String>();
    creationAt = json['creationAt'];
    updatedAt = json['updatedAt'];
  }

  ProductsResponseEntity toEntity() => ProductsResponseEntity(
        id: id ?? 0,
        title: title ?? "",
        slug: slug ?? "",
        price: price ?? 0,
        description: description ?? "",
        category: category?.toEntity() ?? const CategoriesResponseEntity(),
        images: images ?? [],
      );
}
