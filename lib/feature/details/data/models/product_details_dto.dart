import 'package:e_commerce_app/feature/details/domain/entites/product_details_entity.dart';

class ProductDetailsDto {
  int? id;
  String? title;
  String? slug;
  int? price;
  String? description;
  CategoryDto? category;
  List<String>? images;

  ProductDetailsDto({
    this.id,
    this.title,
    this.slug,
    this.price,
    this.description,
    this.category,
    this.images,
  });

  ProductDetailsDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    price = json['price'];
    description = json['description'];
    category = json['category'] != null
        ? new CategoryDto.fromJson(json['category'])
        : null;
    images = json['images'].cast<String>();
  }
  // to Entity
  ProductDetailsEntity toEntity() => ProductDetailsEntity(
        id: id ?? 0,
        title: title ?? "",
        slug: slug ?? "",
        price: price ?? 0,
        description: description ?? "",
        category: category?.toEntity() ?? const CategoryEntity(),
        images: images ?? [],
      );
}

class CategoryDto {
  int? id;
  String? name;
  String? slug;
  String? image;

  CategoryDto({
    this.id,
    this.name,
    this.slug,
    this.image,
  });

  CategoryDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
  }
  // to Entity
  CategoryEntity toEntity() => CategoryEntity(
        id: id ?? 0,
        name: name ?? "",
        slug: slug ?? "",
        image: image ?? "",
      );
}
