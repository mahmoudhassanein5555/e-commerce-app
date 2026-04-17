import 'package:e_commerce_app/feature/home/domain/entites/category_response_entity.dart';
import 'package:flutter/material.dart';

class TabItemWidget extends StatelessWidget {
  const TabItemWidget({
    super.key,
    required this.category,
    required this.selected,
  });
  final CategoriesResponseEntity category;
  final bool selected;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: selected ? const Color(0xff212121) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xff212121),
          width: 1.5,
        ),
      ),
      child: Text(
        category.name,
        style: TextStyle(
          color: selected ? const Color(0xffFEF7FF) : const Color(0xff212121),
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
