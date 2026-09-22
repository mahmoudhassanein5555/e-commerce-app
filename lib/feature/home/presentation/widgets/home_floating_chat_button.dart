import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeFloatingChatButton extends StatelessWidget {
  const HomeFloatingChatButton({
    super.key,
    this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(28.r),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 50.w,
            height: 50.w,
            decoration: BoxDecoration(
              color: AppColors.darkTabSelected,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 12.r,
                  offset: Offset(0, 4.h),
                ),
              ],
            ),
            child: Center(
              child: Icon(
                Icons.chat_bubble_outline_rounded,
                color: AppColors.white,
                size: 22.sp,
              ),
            ),
          ),
          Positioned(
            top: 2.h,
            right: 2.w,
            child: Container(
              width: 10.w,
              height: 10.w,
              decoration: BoxDecoration(
                color: AppColors.goldAccent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.white,
                  width: 1.5.w,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
