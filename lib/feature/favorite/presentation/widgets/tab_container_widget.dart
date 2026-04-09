import 'dart:developer';
import 'package:e_commerce_app/feature/home/domain/entites/category_response_entity.dart';
import 'package:e_commerce_app/feature/home/presentation/widgets/tab_item_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TabContainerWidget extends StatefulWidget {
  TabContainerWidget({
    super.key,
    required this.categories,
    this.onTapSelected,
  });
  Function(int categoryId)? onTapSelected;
  final List<CategoriesResponseEntity> categories;

  @override
  State<TabContainerWidget> createState() => _TabContainerWidgetState();
}

class _TabContainerWidgetState extends State<TabContainerWidget> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.categories.length,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TabBar(
              isScrollable: true,
              indicatorColor: Colors.transparent,
              dividerColor: Colors.transparent,
              tabAlignment: TabAlignment.start,
              labelPadding: EdgeInsets.zero,
              onTap: (int index) {
                log('Selected tab: ${widget.categories[index].id}');
                widget.onTapSelected?.call(widget.categories[index].id) ??
                    () {};
                setState(() {
                  currentIndex = index;
                });
              },
              tabs: List.generate(
                  widget.categories.length,
                  (index) => TabItemWidget(
                      category: widget.categories[index],
                      selected: index == currentIndex))),
        ],
      ),
    );
  }
}
