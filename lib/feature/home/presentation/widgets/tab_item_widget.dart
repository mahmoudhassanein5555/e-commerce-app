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
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFF121212) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: selected ? const Color(0xFF121212) : const Color(0xFFE8E8E8),
          width: 1.2,
        ),
      ),
      child: Text(
        category.name,
        style: TextStyle(
          color: selected ? Colors.white : const Color(0xFF121212),
          fontSize: 14,
          fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

