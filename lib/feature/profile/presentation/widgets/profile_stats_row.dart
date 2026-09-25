import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/feature/cart/presentation/view_model/home_cubit/product_cart_cubit.dart';
import 'package:e_commerce_app/feature/cart/presentation/view_model/home_cubit/product_cart_state.dart';
import 'package:e_commerce_app/feature/favorite/presentation/view_model/home_cubit/product_favorite_cubit.dart';
import 'package:e_commerce_app/feature/favorite/presentation/view_model/home_cubit/product_favorite_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileStatsRow extends StatelessWidget {
  const ProfileStatsRow({super.key});

  Widget _buildStatCard({
    required int count,
    required String label,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(28.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.darkBackground.withValues(alpha: 0.03),
              blurRadius: 10.r,
              offset: Offset(0, 3.h),
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
            Text(
              count.toString(),
              style: TextStyle(
                color: AppColors.textHeader,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 3.h),
            Text(
              label.toUpperCase(),
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 10.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // 1. SAVED (Favorites)
        BlocBuilder<FavoriteCubit, FavoriteState>(
          builder: (context, state) {
            int favoriteCount = 0;
            if (state is FavoriteSuccess) {
              favoriteCount = state.favorites.length;
            } else {
              favoriteCount = context.read<FavoriteCubit>().favoritesList.length;
            }
            return _buildStatCard(
              count: favoriteCount,
              label: 'SAVED',
            );
          },
        ),

        SizedBox(width: 10.w),

        // 2. BAG (Cart)
        BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            final cartCount = state.items.fold<int>(
              0,
              (sum, item) => sum + item.quantity,
            );
            return _buildStatCard(
              count: cartCount,
              label: 'BAG',
            );
          },
        ),

        SizedBox(width: 10.w),

        // 3. ORDERS (Placeholder 0)
        _buildStatCard(
          count: 0,
          label: 'ORDERS',
        ),
      ],
    );
  }
}
