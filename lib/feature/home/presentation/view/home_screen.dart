import 'package:e_commerce_app/core/di/service_locator.dart';
import 'package:e_commerce_app/feature/details/presentation/view/product_details_screen.dart';
import 'package:e_commerce_app/feature/home/presentation/view_model/home_cubit/home_cubit.dart';
import 'package:e_commerce_app/feature/home/presentation/view_model/home_cubit/home_state.dart';
import 'package:e_commerce_app/feature/home/presentation/widgets/home_error_widget.dart';
import 'package:e_commerce_app/feature/home/presentation/widgets/home_floating_chat_button.dart';
import 'package:e_commerce_app/feature/home/presentation/widgets/home_header_widget.dart';
import 'package:e_commerce_app/feature/home/presentation/widgets/home_loading_skeleton_widget.dart';
import 'package:e_commerce_app/feature/home/presentation/widgets/product_item_widget.dart';
import 'package:e_commerce_app/feature/home/presentation/widgets/section_header_widget.dart';
import 'package:e_commerce_app/feature/home/presentation/widgets/tab_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.onTapSelected});

  final ValueChanged<int>? onTapSelected;
  static const String routeName = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeCubit _homeCubit;
  int _categoryId = 1;

  @override
  void initState() {
    super.initState();
    _homeCubit = getIt<HomeCubit>();
    _homeCubit.intent(LoadMainData(categoryId: _categoryId));
  }

  void _onCategorySelected(int id) {
    setState(() {
      _categoryId = id;
    });
    widget.onTapSelected?.call(id);
    _homeCubit.intent(GetProducts(categoryId: id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // 1. Stacked Header with top Search Bar and floating EditorsPickBannerWidget
              SliverToBoxAdapter(
                child: HomeHeaderWidget(
                  onNotificationTap: () {},
                  onLocationTap: () {},
                  onSearchTap: () {},
                  onExploreTap: () {},
                ),
              ),

              // Spacing on the white body section for the overlapping bottom half of the banner
              const SliverToBoxAdapter(
                child: SizedBox(height: 84),
              ),

              // 2. Categories Filter Chips Bar (sitting on white body section)
              SliverToBoxAdapter(
                child: BlocBuilder<HomeCubit, HomeState>(
                  bloc: _homeCubit,
                  buildWhen: (previous, current) =>
                      current is GetCategoriesSuccess ||
                      current is HomeLoading ||
                      current is HomeError,
                  builder: (context, state) {
                    if (state is GetCategoriesSuccess) {
                      return TabContainerWidget(
                        categories: state.categories,
                        initialCategoryId: _categoryId,
                        onTapSelected: _onCategorySelected,
                      );
                    } else if (state is HomeError) {
                      return const SizedBox.shrink();
                    } else {
                      return Skeletonizer(
                        enabled: true,
                        child: TabContainerWidget(
                          categories: const [],
                          onTapSelected: (id) {},
                        ),
                      );
                    }
                  },
                ),
              ),

              const SliverToBoxAdapter(
                child: SizedBox(height: 22),
              ),

              // "For you" Section Title
              const SliverToBoxAdapter(
                child: SectionHeaderWidget(
                  title: 'For you',
                  subtitle: 'Hand-selected · Updated daily',
                  actionText: 'See all',
                ),
              ),

              const SliverToBoxAdapter(
                child: SizedBox(height: 14),
              ),

              // Products Grid Section
              BlocBuilder<HomeCubit, HomeState>(
                bloc: _homeCubit,
                buildWhen: (previous, current) =>
                    current is GetProductsSuccess ||
                    current is HomeLoading ||
                    current is HomeError,
                builder: (context, state) {
                  if (state is GetProductsSuccess) {
                    if (state.products.isEmpty) {
                      return const SliverToBoxAdapter(
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 40),
                            child: Text(
                              'No products found in this category.',
                              style: TextStyle(
                                color: Color(0xFF6B7B73),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    return SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.58,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 14,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final product = state.products[index];
                            return ProductItemWidget(
                              product: product,
                              onProductTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ProductDetailsScreen(
                                      productId: product.id,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          childCount: state.products.length,
                        ),
                      ),
                    );
                  } else if (state is HomeError) {
                    return SliverToBoxAdapter(
                      child: HomeErrorWidget(
                        message: state.message,
                        onRetry: () {
                          _homeCubit.intent(
                            LoadMainData(categoryId: _categoryId),
                          );
                        },
                      ),
                    );
                  } else {
                    return const SliverToBoxAdapter(
                      child: HomeLoadingSkeletonWidget(),
                    );
                  }
                },
              ),

              // Bottom Scroll Padding
              const SliverToBoxAdapter(
                child: SizedBox(height: 80),
              ),
            ],
          ),

          // Floating Chat Assistant Button
          Positioned(
            bottom: 24,
            right: 16,
            child: HomeFloatingChatButton(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Maison Concierge at your service.'),
                    duration: const Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: const Color(0xFF0D1C17),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
