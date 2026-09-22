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

  static const String fallbackImage =
      'https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&w=500&q=80';

  String get displayImage {
    if (images.isNotEmpty && images.first.isNotEmpty) {
      return images.first;
    }
    return fallbackImage;
  }

  String get brandOrCategory {
    if (category.name.trim().isNotEmpty) {
      return category.name.toUpperCase();
    }
    return 'MAISON OR';
  }

  String get badgeLabel {
    if (id % 2 == 0) {
      return 'LIMITED';
    }
    return 'NEW';
  }

  String get formattedPrice {
    if (price == price.roundToDouble()) {
      final intVal = price.toInt();
      final str = intVal.toString();
      final buffer = StringBuffer();
      for (int i = 0; i < str.length; i++) {
        if (i > 0 && (str.length - i) % 3 == 0) {
          buffer.write(',');
        }
        buffer.write(str[i]);
      }
      return buffer.toString();
    }
    return price.toStringAsFixed(2);
  }
}
