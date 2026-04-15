import 'package:e_commerce_app/feature/favorite/domain/entites/product_favorite_entity.dart';
import 'package:e_commerce_app/feature/favorite/presentation/view_model/home_cubit/product_favorite_cubit.dart';
import 'package:e_commerce_app/feature/favorite/presentation/view_model/home_cubit/product_favorite_state.dart';
import 'package:e_commerce_app/feature/home/domain/entites/product_response_entity.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marquee/marquee.dart';

class ProductItemWidget extends StatefulWidget {
  const ProductItemWidget({
    super.key,
    required this.product,
    required this.onProductTap,
  });
  final ProductsResponseEntity product;
  final VoidCallback onProductTap;
  static const String imageTest =
      'https://picperf.io/https://laravelnews.s3.amazonaws.com/featured-images/dummy.png';
  @override
  State<ProductItemWidget> createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends State<ProductItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: widget.onProductTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: widget.product.images.isNotEmpty == true
                          ? widget.product.images[0]
                          : ProductItemWidget.imageTest,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      width: double.infinity,
                      height: 180,
                      fit: BoxFit.fill,
                    ),
                    BlocBuilder<FavoriteCubit, FavoriteState>(
                      builder: (context, state) {
                        final isFavorite = context
                            .read<FavoriteCubit>()
                            .favoritesList
                            .any((e) => e.title == widget.product.title);
                        return Positioned(
                          top: 3,
                          right: 5,
                          child: IconButton(
                            onPressed: () {
                              final imageUrl = widget.product.images.isNotEmpty
                                  ? widget.product.images[0]
                                  : ProductItemWidget.imageTest;
                              context.read<FavoriteCubit>().toggleFavorite(
                                    ProductFavoriteEntity(
                                      title: widget.product.title,
                                      price: widget.product.price.toString(),
                                      image: imageUrl,
                                      productId: widget.product.id,
                                    ),
                                  );
                            },
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border_outlined,
                              size: 30,
                              color: isFavorite
                                  ? const Color.fromARGB(255, 171, 18, 7)
                                  : const Color.fromARGB(255, 62, 61, 61),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 20,
                child: (widget.product.title.trim().isEmpty)
                    ? Text(
                        widget.product.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      )
                    : Marquee(
                        text: widget.product.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        scrollAxis: Axis.horizontal,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        blankSpace: 20.0,
                        velocity: 50,
                        pauseAfterRound: const Duration(seconds: 1),
                        showFadingOnlyWhenScrolling: true,
                        fadingEdgeStartFraction: 0.1,
                        fadingEdgeEndFraction: 0.1,
                        startPadding: 10.0,
                        accelerationDuration: const Duration(milliseconds: 300),
                        accelerationCurve: Curves.linear,
                        decelerationDuration: const Duration(milliseconds: 300),
                        decelerationCurve: Curves.easeOut,
                      ),
              ),
              Text.rich(TextSpan(
                  text: "₤ ",
                  style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffD4AF37)),
                  children: [
                    TextSpan(
                        text: widget.product.price.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 2, 2, 2),
                        ))
                  ])),
            ],
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
