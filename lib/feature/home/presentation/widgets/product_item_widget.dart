import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/feature/cart/cart_cubit.dart';
import 'package:e_commerce_app/feature/favorite/domain/entites/product_favorite_entity.dart';
import 'package:e_commerce_app/feature/favorite/presentation/view_model/home_cubit/product_favorite_cubit.dart';
import 'package:e_commerce_app/feature/favorite/presentation/view_model/home_cubit/product_favorite_state.dart';
import 'package:e_commerce_app/feature/home/domain/entites/product_response_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: const Color(0xFFE4EDE7),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Studio image container with badges and favorite button
            Container(
              height: 165,
              width: double.infinity,
              decoration: BoxDecoration(
                // color: const Color(0xFFF3ECE0),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Stack(
                children: [
                  // Product image
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: CachedNetworkImage(
                        imageUrl: product.displayImage,
                        fit: BoxFit.contain,
                        placeholder: (context, url) => const Center(
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xFFC5953F),
                              ),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => const Center(
                          child: Icon(
                            Icons.broken_image_rounded,
                            color: Color(0xFF9EABA4),
                            size: 32,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Top-left Tag (NEW / LIMITED)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0D1C17),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        badge,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9.5,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                  ),

                  // Top-right Favorite Heart Button
                  Positioned(
                    top: 8,
                    right: 8,
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
                          borderRadius: BorderRadius.circular(18),
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.08),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Icon(
                                isFavorite
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_border_rounded,
                                size: 16,
                                color: isFavorite
                                    ? const Color(0xFFC5953F)
                                    : const Color(0xFF9EABA4),
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

            const SizedBox(height: 10),

            // Brand / Category Tag
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                product.brandOrCategory,
                style: const TextStyle(
                  color: Color(0xFF6B7B73),
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            const SizedBox(height: 3),

            // Product Title with Marquee
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: SizedBox(
                height: 20,
                child: product.title.trim().isEmpty
                    ? const SizedBox.shrink()
                    : Marquee(
                        text: product.title,
                        style: const TextStyle(
                          color: Color(0xFF111D19),
                          fontSize: 14.5,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.2,
                        ),
                        scrollAxis: Axis.horizontal,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        blankSpace: 20.0,
                        velocity: 20.0,
                        pauseAfterRound: const Duration(seconds: 2),
                        showFadingOnlyWhenScrolling: true,
                        fadingEdgeStartFraction: 0.1,
                        fadingEdgeEndFraction: 0.1,
                        startPadding: 0.0,
                        accelerationDuration: const Duration(milliseconds: 300),
                        accelerationCurve: Curves.linear,
                        decelerationDuration: const Duration(milliseconds: 300),
                        decelerationCurve: Curves.easeOut,
                      ),
              ),
            ),

            const SizedBox(height: 6),

            // Price & Add-To-Cart Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '\$${product.formattedPrice}',
                    style: const TextStyle(
                      color: Color(0xFF111D19),
                      fontSize: 16.5,
                      fontWeight: FontWeight.w800,
                    ),
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
                          content: Text('${product.title} added to cart'),
                          duration: const Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: const Color(0xFF0D1C17),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(18),
                    child: Container(
                      width: 34,
                      height: 34,
                      decoration: const BoxDecoration(
                        color: Color(0xFF0D1C17),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.add_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
