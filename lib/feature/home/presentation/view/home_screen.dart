import 'package:e_commerce_app/core/di/service_locator.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/utils/app_text_style.dart';
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
import 'package:go_router/go_router.dart';
import 'package:e_commerce_app/core/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.onTapSelected});

  final ValueChanged<int>? onTapSelected;
  static const String routeName = AppStrings.homeScreenRoute;

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
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // 1. Stacked Header with top Search Bar and floating EditorsPickBannerWidget
              SliverToBoxAdapter(
                child: HomeHeaderWidget(
                  onNotificationTap: () {},
                  onLocationTap: () {},
                  onSearchTap: () {
                    context.push(Routes.search);
                  },
                  onExploreTap: () {},
                ),
              ),

              // Spacing on the white body section for the overlapping bottom half of the banner
              SliverToBoxAdapter(
                child: SizedBox(height: 84.h),
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

              SliverToBoxAdapter(
                child: SizedBox(height: 22.h),
              ),

              // "For you" Section Title
              const SliverToBoxAdapter(
                child: SectionHeaderWidget(),
              ),

              SliverToBoxAdapter(
                child: SizedBox(height: 14.h),
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
                      return SliverToBoxAdapter(
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 40.h),
                            child: Text(
                              AppStrings.noProductsFound,
                              style: AppTextStyle.emptyState,
                            ),
                          ),
                        ),
                      );
                    }
                    return SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      sliver: SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.58,
                          crossAxisSpacing: 14.w,
                          mainAxisSpacing: 14.h,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final product = state.products[index];
                            return ProductItemWidget(
                              product: product,
                              onProductTap: () {
                                context.pushNamed(
                                  Routes.productDetails,
                                  pathParameters: {'id': product.id.toString()},
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
              SliverToBoxAdapter(
                child: SizedBox(height: 80.h),
              ),
            ],
          ),

          // Floating Chat Assistant Button
          Positioned(
            bottom: 24.h,
            right: 16.w,
            child: HomeFloatingChatButton(
              onTap: () {
                context.pushNamed(Routes.chat);
              },
            ),
          ),
        ],
      ),
    );
  }
}
