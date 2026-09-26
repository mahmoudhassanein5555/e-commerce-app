// import 'package:e_commerce_app/core/di/service_locator.dart';
import 'package:e_commerce_app/core/routes/routes_names.dart';
import 'package:e_commerce_app/feature/details/presentation/view/product_details_screen.dart';
import 'package:e_commerce_app/feature/search/presentation/view_model/search_cubit.dart';
import 'package:e_commerce_app/feature/search/presentation/view_model/search_state.dart';
import 'package:e_commerce_app/feature/search/presentation/widgets/search_bar_widget.dart';
import 'package:e_commerce_app/feature/search/presentation/widgets/search_product_card_widget.dart';
import 'package:e_commerce_app/feature/search/presentation/widgets/trending_tags_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = 'SearchScreen';

  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // Removed _searchCubit manual initialization
  late final TextEditingController _searchController;

  static const List<Color> _thumbnailColors = [
    Color(0xFFDCEAD9), // Soft mint green
    Color(0xFFF7E7D9), // Soft peach / nude
    Color(0xFFDCEBE6), // Soft icy teal
    Color(0xFFF3EEDC), // Soft warm beige
  ];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    context.read<SearchCubit>().search('');
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Color _getThumbnailColor(int index) {
    return _thumbnailColors[index % _thumbnailColors.length];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE6F4E7),
              Color(0xFFF4F8F4),
              Color(0xFFF9F5E6),
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Top Right Decorative Ambient Glow
            Positioned(
              top: -50,
              right: -50,
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFFF8E7C5).withValues(alpha: 0.65),
                      const Color(0xFFD8EBD8).withValues(alpha: 0.4),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            SafeArea(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 12.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Top Bar: Back Button, Search Field & Options
                            SearchBarWidget(
                              controller: _searchController,
                              onChanged: (query) => context.read<SearchCubit>().search(query),
                            ),
                            const SizedBox(height: 22),

                            // TRENDING Section
                            TrendingTagsWidget(
                              onTagTap: (tag) {
                                _searchController.text = tag;
                                context.read<SearchCubit>().search(tag);
                              },
                            ),
                            const SizedBox(height: 24),

                            // BROWSE Section Header
                            const Text(
                              'BROWSE',
                              style: TextStyle(
                                color: Color(0xFF869788),
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.5,
                              ),
                            ),
                            const SizedBox(height: 14),

                            // Dynamic Search Results / Browse Products
                            BlocBuilder<SearchCubit, SearchState>(
                              builder: (context, state) {
                                final double availableHeight =
                                    (constraints.maxHeight - 320)
                                        .clamp(180.0, 1000.0);

                                if (state is SearchLoading) {
                                  return SizedBox(
                                    height: availableHeight,
                                    child: const Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.5,
                                        color: Color(0xFF6B7E6F),
                                      ),
                                    ),
                                  );
                                } else if (state is SearchSuccess) {
                                  if (state.products.isEmpty) {
                                    return SizedBox(
                                      height: availableHeight,
                                      child: const Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.search_off_rounded,
                                              size: 48,
                                              color: Color(0xFF869788),
                                            ),
                                            SizedBox(height: 12),
                                            Text(
                                              'No products found',
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF2B382D),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }

                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: state.products.length,
                                    itemBuilder: (context, index) {
                                      final product = state.products[index];
                                      final String? imageUrl =
                                          product.image.isNotEmpty
                                              ? product.image
                                              : (product.images.isNotEmpty
                                                  ? product.images.first
                                                  : null);

                                      return SearchProductCardWidget(
                                        brand: product.brand,
                                        title: product.title,
                                        price: '\$${product.price}',
                                        imageUrl: imageUrl,
                                        isFavorite: product.isFavorite,
                                        thumbnailBgColor:
                                            _getThumbnailColor(index),
                                        onTap: () {
                                            if (product.id > 0) {
                                              context.pushNamed(
                                                Routes.productDetails,
                                                pathParameters: {'id': product.id.toString()},
                                              );
                                            }
                                        },
                                      );
                                    },
                                  );
                                } else if (state is SearchError) {
                                  return SizedBox(
                                    height: availableHeight,
                                    child: Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.error_outline_rounded,
                                            size: 40,
                                            color: Colors.redAccent,
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            state.message,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              color: Color(0xFF2B382D),
                                              fontSize: 14,
                                            ),
                                          ),
                                          const SizedBox(height: 12),
                                          TextButton(
                                            onPressed: () => context.read<SearchCubit>()
                                                .search(_searchController.text),
                                            child: const Text(
                                              'Retry',
                                              style: TextStyle(
                                                color: Color(0xFF6B7E6F),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }

                                return const SizedBox.shrink();
                              },
                            ),

                            // Spacing at bottom to avoid floating nav bar overlap
                            const SizedBox(height: 110),
                          ],
                        ),
                      );
                    },
                  ),

                  // Floating Chat Action Button
                  // Positioned(
                  //   right: 20,
                  //   bottom: 85,
                  //   child: Container(
                  //     width: 46,
                  //     height: 46,
                  //     decoration: BoxDecoration(
                  //       color: const Color(0xFF1C251D),
                  //       shape: BoxShape.circle,
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: Colors.black.withValues(alpha: 0.15),
                  //           blurRadius: 10,
                  //           offset: const Offset(0, 4),
                  //         ),
                  //       ],
                  //     ),
                  //     child: Stack(
                  //       alignment: Alignment.center,
                  //       children: [
                  //         const Icon(
                  //           Icons.chat_bubble_rounded,
                  //           color: Colors.white,
                  //           size: 20,
                  //         ),
                  //         Positioned(
                  //           top: 10,
                  //           right: 10,
                  //           child: Container(
                  //             width: 6,
                  //             height: 6,
                  //             decoration: const BoxDecoration(
                  //               color: Color(0xFFC59B27),
                  //               shape: BoxShape.circle,
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
