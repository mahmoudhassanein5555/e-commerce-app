import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyle {
  static TextStyle get greeting => TextStyle(
        color: AppColors.white.withValues(alpha: 0.85),
        fontSize: 11.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.6,
      );

  static TextStyle get brandTitle => TextStyle(
        color: AppColors.white,
        fontSize: 34.sp,
        fontWeight: FontWeight.w700,
        fontFamily: 'serif',
        letterSpacing: -0.5,
      );

  static TextStyle get deliverToLocation => TextStyle(
        color: AppColors.white.withValues(alpha: 0.95),
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get searchHint => TextStyle(
        color: AppColors.white.withValues(alpha: 0.85),
        fontSize: 14.5.sp,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get searchShortcut => TextStyle(
        color: AppColors.white.withValues(alpha: 0.92),
        fontSize: 11.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      );

  static TextStyle get bannerTag => TextStyle(
        color: AppColors.goldTag,
        fontSize: 10.5.sp,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.8,
      );

  static TextStyle get bannerTitle => TextStyle(
        color: AppColors.textBannerTitle,
        fontSize: 16.5.sp,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.3,
      );

  static TextStyle get bannerDescription => TextStyle(
        color: AppColors.textDescription,
        fontSize: 12.sp,
        height: 1.35,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get bannerExplore => TextStyle(
        color: AppColors.white,
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get sectionTitle => TextStyle(
        color: AppColors.textHeader,
        fontSize: 22.sp,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.3,
      );

  static TextStyle get sectionSubtitle => TextStyle(
        color: AppColors.textSubtitle,
        fontSize: 12.5.sp,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get sectionAction => TextStyle(
        color: AppColors.goldAction,
        fontSize: 13.sp,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get tabSelected => TextStyle(
        color: AppColors.white,
        fontSize: 13.5.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.1,
      );

  static TextStyle get tabUnselected => TextStyle(
        color: AppColors.textTabUnselected,
        fontSize: 13.5.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: -0.1,
      );

  static TextStyle get productBadge => TextStyle(
        color: AppColors.white,
        fontSize: 9.5.sp,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.8,
      );

  static TextStyle get productCategory => TextStyle(
        color: AppColors.textSecondary,
        fontSize: 10.sp,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.2,
      );

  static TextStyle get productTitle => TextStyle(
        color: AppColors.textPrimary,
        fontSize: 14.5.sp,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.2,
      );

  static TextStyle get productPrice => TextStyle(
        color: AppColors.textPrimary,
        fontSize: 16.5.sp,
        fontWeight: FontWeight.w800,
      );

  static TextStyle get errorTitle => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      );

  static TextStyle get errorSubtitle => TextStyle(
        fontSize: 13.sp,
        color: AppColors.textSecondary,
      );

  static TextStyle get errorButton => TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 13.sp,
      );

  static TextStyle get emptyState => TextStyle(
        color: AppColors.textSecondary,
        fontSize: 14.sp,
      );
}
