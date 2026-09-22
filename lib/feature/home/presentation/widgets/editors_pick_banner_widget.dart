import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditorsPickBannerWidget extends StatelessWidget {
  const EditorsPickBannerWidget({
    super.key,
    this.onExploreTap,
    this.imageUrl =
        'https://images.unsplash.com/photo-1592945403244-b3fbafd7f539?auto=format&fit=crop&w=400&q=80',
    this.tag = AppStrings.editorsPickTag,
    this.title = AppStrings.editorsPickTitle,
    this.description = AppStrings.editorsPickDescription,
  });

  final VoidCallback? onExploreTap;
  final String imageUrl;
  final String tag;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.bannerBackground,
        borderRadius: BorderRadius.circular(32.r),
        border: Border.all(
          color: AppColors.bannerBorder,
          width: 1.2.w,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 18.r,
            offset: Offset(0, 8.h),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left Product Arched/Rounded Thumbnail Frame
          Container(
            width: 105.w,
            height: 110.h,
            decoration: BoxDecoration(
              color: AppColors.bannerThumbnailBackground,
              borderRadius: BorderRadius.circular(26.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(26.r),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: AppColors.bannerThumbnailBackground,
                  child: Center(
                    child: SizedBox(
                      width: 22.w,
                      height: 22.w,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.goldTag,
                        ),
                      ),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: AppColors.bannerThumbnailBackground,
                  child: Center(
                    child: Icon(
                      Icons.auto_awesome_rounded,
                      color: AppColors.goldTag,
                      size: 32.sp,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 14.w),

          // Right Content Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  tag,
                  style: AppTextStyle.bannerTag,
                ),
                SizedBox(height: 5.h),
                Text(
                  title,
                  style: AppTextStyle.bannerTitle,
                ),
                SizedBox(height: 4.h),
                Text(
                  description,
                  style: AppTextStyle.bannerDescription,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 10.h),
                InkWell(
                  onTap: onExploreTap,
                  borderRadius: BorderRadius.circular(20.r),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 7.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.darkButton,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          AppStrings.explore,
                          style: AppTextStyle.bannerExplore,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          AppStrings.plusSign,
                          style: AppTextStyle.bannerExplore.copyWith(
                            fontSize: 13.5.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
