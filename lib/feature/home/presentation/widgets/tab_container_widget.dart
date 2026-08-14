import 'package:e_commerce_app/feature/home/domain/entites/category_response_entity.dart';
import 'package:e_commerce_app/feature/home/presentation/widgets/tab_item_widget.dart';
import 'package:flutter/material.dart';

class TabContainerWidget extends StatefulWidget {
  const TabContainerWidget({
    super.key,
    required this.categories,
    this.onTapSelected,
    this.initialCategoryId,
  });

  final List<CategoriesResponseEntity> categories;
  final ValueChanged<int>? onTapSelected;
  final int? initialCategoryId;

  @override
  State<TabContainerWidget> createState() => _TabContainerWidgetState();
}

class _TabContainerWidgetState extends State<TabContainerWidget> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _syncSelectedIndex();
  }

  @override
  void didUpdateWidget(covariant TabContainerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialCategoryId != widget.initialCategoryId ||
        oldWidget.categories != widget.categories) {
      _syncSelectedIndex();
    }
  }

  void _syncSelectedIndex() {
    if (widget.initialCategoryId != null && widget.categories.isNotEmpty) {
      final index = widget.categories.indexWhere(
        (cat) => cat.id == widget.initialCategoryId,
      );
      if (index != -1) {
        _selectedIndex = index;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.categories.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 42,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: widget.categories.length,
        itemBuilder: (context, index) {
          final category = widget.categories[index];
          final isSelected = index == _selectedIndex;

          return TabItemWidget(
            category: category,
            selected: isSelected,
            onTap: () {
              if (_selectedIndex != index) {
                setState(() {
                  _selectedIndex = index;
                });
                widget.onTapSelected?.call(category.id);
              }
            },
          );
        },
      ),
    );
  }
}
