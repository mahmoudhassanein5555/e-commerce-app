import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SectionHeaderWidget extends StatelessWidget {
  const SectionHeaderWidget({
    super.key,
    this.title = AppStrings.forYouSectionTitle,
    this.subtitle = AppStrings.forYouSectionSubtitle,
    this.actionText = AppStrings.seeAll,
    this.onSeeAllTap,
  });

  final String title;
  final String subtitle;
  final String actionText;
  final VoidCallback? onSeeAllTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyle.sectionTitle,
              ),
              SizedBox(height: 2.h),
              Text(
                subtitle,
                style: AppTextStyle.sectionSubtitle,
              ),
            ],
          ),
          if (actionText.isNotEmpty)
            InkWell(
              onTap: onSeeAllTap,
              borderRadius: BorderRadius.circular(8.r),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                child: Text(
                  actionText,
                  style: AppTextStyle.sectionAction,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
