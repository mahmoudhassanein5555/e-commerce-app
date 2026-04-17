import 'package:e_commerce_app/core/di/service_locator.dart';
import 'package:e_commerce_app/feature/details/presentation/view/product_details_screen.dart';
import 'package:e_commerce_app/feature/home/domain/entites/category_response_entity.dart';
import 'package:e_commerce_app/feature/home/domain/entites/product_response_entity.dart';
import 'package:e_commerce_app/feature/home/presentation/view_model/home_cubit/home_cubit.dart';
import 'package:e_commerce_app/feature/home/presentation/view_model/home_cubit/home_state.dart';
import 'package:e_commerce_app/feature/home/presentation/widgets/product_item_widget.dart';
import 'package:e_commerce_app/feature/home/presentation/widgets/tab_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  Function(int categoryId)? onTapSelected;
  HomeScreen({super.key, this.onTapSelected});
  static const String routeName = 'HomeScreen';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeCubit _homeCubit;
  int categoryId = 1;
  @override
  void initState() {
    super.initState();
    _homeCubit = getIt<HomeCubit>();
    _homeCubit.intent(LoadMainData(categoryId: categoryId));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                const Text.rich(
                  TextSpan(
                    text: 'Hi !,\n',
                    style: TextStyle(
                      color: Color(0xff212121),
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                    children: [
                      TextSpan(
                        text: 'Let’s start your shopping',
                        style: TextStyle(
                          color: Color(0xff212121),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Categories",
                  style: TextStyle(
                    color: Color(0xff212121),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                BlocBuilder<HomeCubit, HomeState>(
                  bloc: _homeCubit,
                  buildWhen: (previous, current) =>
                      current is GetCategoriesSuccess,
                  builder: (context, state) {
                    if (state is GetCategoriesSuccess) {
                      return TabContainerWidget(
                          categories: state.categories,
                          onTapSelected: (id) {
                            categoryId = id;
                            _homeCubit
                                .intent(GetProducts(categoryId: categoryId));
                          });
                    } else if (state is HomeError) {
                      return const Center(
                          child: Text('Error loading categories'));
                    } else {
                      return Skeletonizer(
                        enabled: true,
                        enableSwitchAnimation: true,
                        child: SizedBox(
                          height: 50,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 10,
                            itemBuilder: (BuildContext context, int index) {
                              return TabContainerWidget(
                                  categories: List.generate(
                                6,
                                (index) => const CategoriesResponseEntity(
                                    name: "Loading"),
                              ));
                            },
                          ),
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          BlocBuilder<HomeCubit, HomeState>(
            bloc: _homeCubit,
            buildWhen: (previous, current) => current is GetProductsSuccess,
            builder: (context, state) {
              if (state is GetProductsSuccess) {
                return SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.58,
                    crossAxisSpacing: 30,
                    mainAxisSpacing: 20,
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
                );
              } else if (state is HomeError) {
                return const SliverToBoxAdapter(
                  child: Center(child: Text('Error loading products')),
                );
              } else {
                return SliverToBoxAdapter(
                  child: Skeletonizer(
                    enabled: true,
                    enableSwitchAnimation: true,
                    child: SizedBox(
                      height: 600,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.58,
                        ),
                        itemCount: 10,
                        itemBuilder: (BuildContext context, int index) {
                          return ProductItemWidget(
                            product: ProductsResponseEntity(),
                            onProductTap: () {},
                          );
                        },
                      ),
                    ),
                  ),
                );
              }
            },
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }
}
