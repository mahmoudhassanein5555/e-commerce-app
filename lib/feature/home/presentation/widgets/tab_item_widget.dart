import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_text_style.dart';
import 'package:e_commerce_app/feature/home/domain/entites/category_response_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      borderRadius: BorderRadius.circular(24.r),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 9.h),
        margin: EdgeInsets.only(right: 10.w),
        decoration: BoxDecoration(
          color: selected ? AppColors.darkTabSelected : AppColors.white,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(
            color: selected
                ? AppColors.darkTabSelected
                : AppColors.tabBorderUnselected,
            width: 1.2.w,
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: AppColors.darkTabSelected.withValues(alpha: 0.15),
                    blurRadius: 8.r,
                    offset: Offset(0, 3.h),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Text(
            category.name,
            style:
                selected ? AppTextStyle.tabSelected : AppTextStyle.tabUnselected,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

