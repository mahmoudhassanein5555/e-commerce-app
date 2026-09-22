import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeErrorWidget extends StatelessWidget {
  const HomeErrorWidget({
    super.key,
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64.w,
              height: 64.w,
              decoration: BoxDecoration(
                color: AppColors.errorIconBackground,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.errorIconBorder,
                  width: 1.5.w,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.refresh_rounded,
                  color: AppColors.goldIcon,
                  size: 28.sp,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              AppStrings.unableToLoadCollections,
              style: AppTextStyle.errorTitle,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 6.h),
            Text(
              message,
              style: AppTextStyle.errorSubtitle,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.darkBackground,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                  vertical: 12.h,
                ),
              ),
              child: Text(
                AppStrings.tryAgain,
                style: AppTextStyle.errorButton,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
