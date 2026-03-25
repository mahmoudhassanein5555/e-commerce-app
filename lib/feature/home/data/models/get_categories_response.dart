import 'package:e_commerce_app/feature/home/domain/entites/category_response_entity.dart';

class CategoriesResponseDto {
  int? id;
  String? name;
  String? slug;
  String? image;
  String? creationAt;
  String? updatedAt;

  CategoriesResponseDto(
      {this.id,
      this.name,
      this.slug,
      this.image,
      this.creationAt,
      this.updatedAt});

  CategoriesResponseDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
    creationAt = json['creationAt'];
    updatedAt = json['updatedAt'];
  }

  CategoriesResponseEntity toEntity() => CategoriesResponseEntity(
        id: id ?? 0,
        name: name ?? "",
        slug: slug ?? "",
        image: image ?? "",
      );
}
