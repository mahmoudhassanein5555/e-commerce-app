import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';

class ProfileOptionsCard extends StatelessWidget {
  final VoidCallback onSignOutTap;

  const ProfileOptionsCard({
    super.key,
    required this.onSignOutTap,
  });

  Widget _buildOptionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
    bool isDestructive = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
        child: Row(
          children: [
            // Icon container
            Container(
              width: 36.r,
              height: 36.r,
              decoration: BoxDecoration(
                color: isDestructive
                    ? Colors.red.withValues(alpha: 0.08)
                    : AppColors.bannerBackground,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 20.r,
                color: isDestructive ? Colors.redAccent : AppColors.goldIcon,
              ),
            ),

            SizedBox(width: 14.w),

            // Title and Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: isDestructive
                          ? Colors.redAccent
                          : AppColors.textHeader,
                      fontSize: 14.5.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (subtitle.isNotEmpty) ...[
                    SizedBox(height: 2.h),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 11.5.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Trailing Chevron
            Icon(
              Icons.chevron_right_rounded,
              size: 20.r,
              color: AppColors.iconInactive,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Divider(
        color: AppColors.bannerBorder,
        height: 1.h,
        thickness: 1.h,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkBackground.withValues(alpha: 0.04),
            blurRadius: 16.r,
            offset: Offset(0, 4.h),
          ),
        ],
        border: Border.all(
          color: AppColors.bannerBorder,
          width: 1.r,
        ),
      ),
      child: Column(
        children: [
          // 1. Orders
          _buildOptionTile(
            icon: LineIcons.box,
            title: 'Orders',
            subtitle: '0 active',
            onTap: () {},
          ),
          _buildDivider(),

          // 2. Addresses
          _buildOptionTile(
            icon: LineIcons.mapMarker,
            title: 'Addresses',
            subtitle: '2 saved',
            onTap: () {},
          ),
          _buildDivider(),

          // 3. Payment Methods
          _buildOptionTile(
            icon: LineIcons.creditCard,
            title: 'Payment methods',
            subtitle: '•••• 4242',
            onTap: () {},
          ),
          _buildDivider(),

          // 4. Notifications
          _buildOptionTile(
            icon: LineIcons.bell,
            title: 'Notifications',
            subtitle: 'Curated only',
            onTap: () {},
          ),
          _buildDivider(),

          // 5. Sign Out
          _buildOptionTile(
            icon: LineIcons.alternateSignOut,
            title: 'Sign Out',
            subtitle: 'Log out of your account',
            isDestructive: true,
            onTap: onSignOutTap,
          ),
        ],
      ),
    );
  }
}
