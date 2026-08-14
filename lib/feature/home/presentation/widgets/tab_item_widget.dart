import 'package:e_commerce_app/feature/home/domain/entites/category_response_entity.dart';
import 'package:flutter/material.dart';

class TabItemWidget extends StatelessWidget {
  const TabItemWidget({
    super.key,
    required this.category,
    required this.selected,
    this.onTap,
  });

  final CategoriesResponseEntity category;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF0E1F1A) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: selected ? const Color(0xFF0E1F1A) : const Color(0xFFE5E7EB),
            width: 1.2,
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: const Color(0xFF0E1F1A).withValues(alpha: 0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Text(
            category.name,
            style: TextStyle(
              color: selected ? Colors.white : const Color(0xFF374151),
              fontSize: 13.5,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
              letterSpacing: -0.1,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
