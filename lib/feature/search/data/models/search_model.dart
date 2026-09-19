import 'package:e_commerce_app/feature/search/domain/entities/search_entity.dart';
import 'package:flutter/foundation.dart';

class SearchModel extends SearchEntity {
  SearchModel({
    super.id,
    super.title,
    super.brand,
    super.price,
    super.image,
    super.images,
    super.description,
    super.slug,
    super.category,
    super.isFavorite,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    final rawCategory = json['category'];
    String categoryName = '';
    if (rawCategory is Map) {
      categoryName = rawCategory['name']?.toString() ?? '';
    } else if (rawCategory is String) {
      categoryName = rawCategory;
    }

    final rawImages = json['images'];
    List<String> imagesList = const [];
    if (rawImages is List) {
      imagesList = rawImages
          .map((e) => e.toString())
          .where((e) => e.isNotEmpty)
          .toList();
    }

    final rawImage = json['image'];
    String imageStr = '';
    if (rawImage is String && rawImage.isNotEmpty) {
      imageStr = rawImage;
    } else if (imagesList.isNotEmpty) {
      imageStr = imagesList.first;
    }

    debugPrint('SEARCH IMAGE URL: $imageStr');

    return SearchModel(
      id: json['id'] is int
          ? json['id'] as int
          : (int.tryParse(json['id']?.toString() ?? '') ?? 0),
      title: json['title']?.toString() ?? '',
      brand: json['brand']?.toString() ?? '',
      price: json['price'] is num
          ? json['price'] as num
          : (num.tryParse(json['price']?.toString() ?? '') ?? 0),
      image: imageStr,
      images: imagesList,
      description: json['description']?.toString() ?? '',
      slug: json['slug'] ?? '',
      category: categoryName,
      isFavorite:
          json['isFavorite'] is bool ? json['isFavorite'] as bool : false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'brand': brand,
      'price': price,
      'image': image,
      'images': images,
      'description': description,
      'slug': slug,
      'category': category,
      'isFavorite': isFavorite,
    };
  }
}
