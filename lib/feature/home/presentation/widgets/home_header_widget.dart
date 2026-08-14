import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/utils/app_text_style.dart';
import 'package:e_commerce_app/feature/home/presentation/widgets/editors_pick_banner_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({
    super.key,
    this.onNotificationTap,
    this.onLocationTap,
    this.onSearchTap,
    this.onExploreTap,
  });

  final VoidCallback? onNotificationTap;
  final VoidCallback? onLocationTap;
  final VoidCallback? onSearchTap;
  final VoidCallback? onExploreTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        // 1. Golden Header Container with gradient background
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.primaryGoldStart,
                AppColors.primaryGoldMiddle1,
                AppColors.primaryGoldMiddle2,
                AppColors.primaryGoldEnd,
              ],
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(32.r),
              bottomRight: Radius.circular(32.r),
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 80.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Greeting & Notification Bell Row
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.goodMorning,
                              style: AppTextStyle.greeting,
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              AppStrings.brandName,
                              style: AppTextStyle.brandTitle,
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: onNotificationTap,
                          borderRadius: BorderRadius.circular(24.r),
                          child: Container(
                            width: 44.w,
                            height: 44.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.white.withValues(alpha: 0.22),
                              border: Border.all(
                                color: AppColors.white.withValues(alpha: 0.35),
                                width: 1.2.w,
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.notifications_none_rounded,
                                color: AppColors.white,
                                size: 22.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 14.h),

                  // Deliver to Location Pill
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: InkWell(
                      onTap: onLocationTap,
                      borderRadius: BorderRadius.circular(20.r),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.16),
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            color: AppColors.white.withValues(alpha: 0.15),
                            width: 0.8.w,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: AppColors.white.withValues(alpha: 0.95),
                              size: 14.sp,
                            ),
                            SizedBox(width: 5.w),
                            Text(
                              AppStrings.deliverToLocation,
                              style: AppTextStyle.deliverToLocation,
                            ),
                            SizedBox(width: 4.w),
                            Icon(
                              Icons.chevron_right_rounded,
                              color: AppColors.white.withValues(alpha: 0.75),
                              size: 16.sp,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Search Bar inside Header above the Banner
                  InkWell(
                    onTap: onSearchTap,
                    borderRadius: BorderRadius.circular(28.r),
                    child: Container(
                      height: 50.h,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      decoration: BoxDecoration(
                        color: AppColors.white.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(28.r),
                        border: Border.all(
                          color: AppColors.white.withValues(alpha: 0.42),
                          width: 1.2.w,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search_rounded,
                            color: AppColors.white.withValues(alpha: 0.88),
                            size: 22.sp,
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Text(
                              AppStrings.searchHint,
                              style: AppTextStyle.searchHint,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 3.5.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.white.withValues(alpha: 0.24),
                              borderRadius: BorderRadius.circular(6.r),
                              border: Border.all(
                                color: AppColors.white.withValues(alpha: 0.38),
                                width: 0.8.w,
                              ),
                            ),
                            child: Text(
                              AppStrings.searchShortcut,
                              style: AppTextStyle.searchShortcut,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // 2. Overlapping EditorsPickBannerWidget
        Positioned(
          bottom: -80.h,
          left: 16.w,
          right: 16.w,
          child: EditorsPickBannerWidget(
            onExploreTap: onExploreTap,
          ),
        ),
      ],
    );
  }
}
