import 'dart:io';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/feature/profile/domain/entities/user_profile_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileHeaderCard extends StatelessWidget {
  final UserProfileEntity? userProfile;
  final VoidCallback? onEditTap;
  final VoidCallback? onPhotoTap;

  const ProfileHeaderCard({
    super.key,
    this.userProfile,
    this.onEditTap,
    this.onPhotoTap,
  });

  String _getInitials(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return '';
    final parts = trimmed.split(RegExp(r'\s+'));
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    } else if (parts[0].isNotEmpty) {
      return parts[0].substring(0, parts[0].length >= 2 ? 2 : 1).toUpperCase();
    }
    return '';
  }

  ImageProvider? _getImageProvider(String? avatar) {
    if (avatar == null || avatar.trim().isEmpty) return null;
    final trimmed = avatar.trim();
    if (trimmed.startsWith('http://') || trimmed.startsWith('https://')) {
      return NetworkImage(trimmed);
    }
    final file = File(trimmed);
    if (file.existsSync()) {
      return FileImage(file);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final name = userProfile?.name ?? '';
    final email = userProfile?.email ?? '';
    final avatar = userProfile?.avatar ?? '';
    final initials = _getInitials(name);
    final imageProvider = _getImageProvider(avatar);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 28.h, horizontal: 20.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkBackground.withValues(alpha: 0.04),
            blurRadius: 18.r,
            offset: Offset(0, 4.h),
          ),
        ],
        border: Border.all(
          color: AppColors.bannerBorder,
          width: 1.r,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1. Avatar circle ONLY (taps open photo viewer, NO camera badge)
          GestureDetector(
            onTap: onPhotoTap,
            child: Container(
              width: 80.r,
              height: 80.r,
              padding: EdgeInsets.all(3.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.goldAccent.withValues(alpha: 0.35),
                  width: 1.5.r,
                ),
              ),
              child: CircleAvatar(
                radius: 37.r,
                backgroundColor: AppColors.bannerBackground,
                backgroundImage: imageProvider,
                child: imageProvider == null
                    ? Text(
                        initials,
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryGoldStart,
                          letterSpacing: 0.5,
                        ),
                      )
                    : null,
              ),
            ),
          ),

          SizedBox(height: 16.h),

          // 2. User Name mathematically centered horizontally with pencil button independently positioned right next to it
          LayoutBuilder(
            builder: (context, constraints) {
              final displayName = name.isNotEmpty ? name : 'User';
              final nameStyle = TextStyle(
                color: AppColors.textHeader,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.2,
              );

              // Measure text width to place the pencil icon right beside it
              final textPainter = TextPainter(
                text: TextSpan(text: displayName, style: nameStyle),
                textDirection: TextDirection.ltr,
                maxLines: 1,
              )..layout(maxWidth: constraints.maxWidth - 40.w);

              final textWidth = textPainter.width;
              final centerX = constraints.maxWidth / 2;
              final pencilLeft = (centerX + (textWidth / 2) + 4.w)
                  .clamp(0.0, constraints.maxWidth - 24.w);

              return SizedBox(
                height: 26.h,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Perfectly centered name (zero influence from pencil icon)
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Text(
                          displayName,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: nameStyle,
                        ),
                      ),
                    ),

                    // Pencil icon positioned right beside the name with a tight, consistent gap
                    Positioned(
                      left: pencilLeft,
                      child: GestureDetector(
                        onTap: onEditTap,
                        child: Icon(
                          Icons.edit_outlined,
                          size: 17.r,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          // 3. User Email centered under the name with ellipsis truncation
          if (email.isNotEmpty) ...[
            SizedBox(height: 4.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                email,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
