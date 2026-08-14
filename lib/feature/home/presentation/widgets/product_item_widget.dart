import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/utils/app_text_style.dart';
import 'package:e_commerce_app/feature/cart/presentation/view_model/home_cubit/product_cart_cubit.dart';
import 'package:e_commerce_app/feature/favorite/domain/entites/product_favorite_entity.dart';
import 'package:e_commerce_app/feature/favorite/presentation/view_model/home_cubit/product_favorite_cubit.dart';
import 'package:e_commerce_app/feature/favorite/presentation/view_model/home_cubit/product_favorite_state.dart';
import 'package:e_commerce_app/feature/home/domain/entites/product_response_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marquee/marquee.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({
    super.key,
    required this.product,
    required this.onProductTap,
    this.badgeText,
  });

  final ProductsResponseEntity product;
  final VoidCallback onProductTap;
  final String? badgeText;

  @override
  Widget build(BuildContext context) {
    final badge = badgeText ?? product.badgeLabel;

    return InkWell(
      onTap: onProductTap,
      borderRadius: BorderRadius.circular(24.r),
      child: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(
            color: AppColors.cardBorder,
            width: 1.2.w,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10.r,
              offset: Offset(0, 4.h),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Studio image container with badges and favorite button
            Container(
              height: 165.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.r),
              ),
              child: Stack(
                children: [
                  // Product image
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18.r),
                      child: CachedNetworkImage(
                        imageUrl: product.displayImage,
                        fit: BoxFit.contain,
                        placeholder: (context, url) => Center(
                          child: SizedBox(
                            width: 24.w,
                            height: 24.w,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.goldAccent,
                              ),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Center(
                          child: Icon(
                            Icons.broken_image_rounded,
                            color: AppColors.iconInactive,
                            size: 32.sp,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Top-left Tag (NEW / LIMITED)
                  Positioned(
                    top: 8.h,
                    left: 8.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.darkBackground,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text(
                        badge,
                        style: AppTextStyle.productBadge,
                      ),
                    ),
                  ),

                  // Top-right Favorite Heart Button
                  Positioned(
                    top: 8.h,
                    right: 8.w,
                    child: BlocBuilder<FavoriteCubit, FavoriteState>(
                      builder: (context, state) {
                        final favCubit = context.read<FavoriteCubit>();
                        final isFavorite = favCubit.favoritesList.any(
                          (e) =>
                              e.productId == product.id ||
                              e.title == product.title,
                        );

                        return InkWell(
                          onTap: () {
                            favCubit.toggleFavorite(
                              ProductFavoriteEntity(
                                title: product.title,
                                price: product.price.toString(),
                                image: product.displayImage,
                                productId: product.id,
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(18.r),
                          child: Container(
                            width: 32.w,
                            height: 32.w,
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.08),
                                  blurRadius: 6.r,
                                  offset: Offset(0, 2.h),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Icon(
                                isFavorite
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_border_rounded,
                                size: 16.sp,
                                color: isFavorite
                                    ? AppColors.goldAccent
                                    : AppColors.iconInactive,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10.h),

            // Brand / Category Tag
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Text(
                product.brandOrCategory,
                style: AppTextStyle.productCategory,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            SizedBox(height: 3.h),

            // Product Title with Marquee
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: SizedBox(
                height: 20.h,
                child: product.title.trim().isEmpty
                    ? const SizedBox.shrink()
                    : Marquee(
                        text: product.title,
                        style: AppTextStyle.productTitle,
                        scrollAxis: Axis.horizontal,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        blankSpace: 20.0.w,
                        velocity: 20.0,
                        pauseAfterRound: const Duration(seconds: 2),
                        showFadingOnlyWhenScrolling: true,
                        fadingEdgeStartFraction: 0.1,
                        fadingEdgeEndFraction: 0.1,
                        startPadding: 0.0,
                        accelerationDuration: const Duration(milliseconds: 300),
                        accelerationCurve: Curves.linear,
                        decelerationDuration:
                            const Duration(milliseconds: 300),
                        decelerationCurve: Curves.easeOut,
                      ),
              ),
            ),

            SizedBox(height: 6.h),

            // Price & Add-To-Cart Row
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '\$${product.formattedPrice}',
                    style: AppTextStyle.productPrice,
                  ),
                  InkWell(
                    onTap: () {
                      context.read<CartCubit>().addProductLine(
                            productId: product.id,
                            title: product.title,
                            imageUrl: product.displayImage,
                            price: product.price.toString(),
                          );
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              '${product.title} ${AppStrings.addedToCartSuffix}'),
                          duration: const Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          backgroundColor: AppColors.darkBackground,
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(18.r),
                    child: Container(
                      width: 34.w,
                      height: 34.w,
                      decoration: const BoxDecoration(
                        color: AppColors.darkBackground,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.add_rounded,
                          color: AppColors.white,
                          size: 20.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 4.h),
          ],
        ),
      ),
    );
  }
}
