import 'dart:developer';
import 'package:e_commerce_app/feature/home/domain/entites/category_response_entity.dart';
import 'package:e_commerce_app/feature/home/presentation/widgets/tab_item_widget.dart';
import 'package:flutter/material.dart';

class TabContainerWidget extends StatefulWidget {
  const TabContainerWidget({
    super.key,
    required this.categories,
    this.onTapSelected,
  });

  final List<CategoriesResponseEntity> categories;
  final ValueChanged<int>? onTapSelected;

  @override
  State<TabContainerWidget> createState() => _TabContainerWidgetState();
}

class _TabContainerWidgetState extends State<TabContainerWidget> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.categories.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 42,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        itemCount: widget.categories.length,
        itemBuilder: (context, index) {
          final category = widget.categories[index];
          final isSelected = index == currentIndex;
          return GestureDetector(
            onTap: () {
              log('Selected category ID: ${category.id}');
              if (currentIndex != index) {
                setState(() {
                  currentIndex = index;
                });
                widget.onTapSelected?.call(category.id);
              }
            },
            child: TabItemWidget(
              category: category,
              selected: isSelected,
            ),
          );
        },
      ),
    );
  }
}

