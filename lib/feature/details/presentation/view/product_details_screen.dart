import 'package:dots_indicator/dots_indicator.dart';
import 'package:e_commerce_app/core/di/service_locator.dart';
import 'package:e_commerce_app/feature/details/presentation/view_model/home_cubit/product_details_cubit.dart';
import 'package:e_commerce_app/feature/details/presentation/view_model/home_cubit/product_details_state.dart';
import 'package:e_commerce_app/feature/cart/presentation/view_model/home_cubit/product_cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId});
  final int productId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late final ProductDetailsCubit _productDetailsCubit;
  @override
  void initState() {
    super.initState();
    _productDetailsCubit = getIt<ProductDetailsCubit>();
    _productDetailsCubit.intent(GetProductDetails(productId: widget.productId));
  }

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  final state = _productDetailsCubit.state;
                  if (state is GetProductsDetailsSuccess) {
                    context.read<CartCubit>().addProductLine(
                      productId: state.productDetails.id,
                      title: state.productDetails.title,
                      imageUrl: state.productDetails.images.isNotEmpty
                          ? state.productDetails.images[0]
                          : CartCubit.fallbackImageUrl,
                      price: state.productDetails.price.toString(),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff212121)),
                child: const Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  child: Text(
                    "Add to cart",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                )),
          ),
        ),
        appBar: AppBar(
          title: const Text('Product Details'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
            bloc: _productDetailsCubit,
            builder: (context, state) {
              if (state is GetProductsDetailsSuccess) {
                final images = state.productDetails.images;
                return SingleChildScrollView(
                  child: Column(children: [
                    if (images.isNotEmpty) ...[
                      SizedBox(
                          height: 331,
                          width: double.infinity,
                          child: Card(
                            elevation: 10,
                            child: PageView.builder(
                              itemCount: images.length,
                              onPageChanged: (value) {
                                setState(() {
                                  currentIndex = value;
                                });
                              },
                              itemBuilder: (context, index) =>
                                  Image.network(images[index]),
                            ),
                          )),
                      const SizedBox(height: 10),
                      DotsIndicator(
                        dotsCount: images.length,
                        position: currentIndex.toDouble(),
                        decorator: DotsDecorator(
                          activeColor: Colors.teal,
                          size: const Size.square(9.0),
                          activeSize: const Size(18.0, 9.0),
                          activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            state.productDetails.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "EGP ${state.productDetails.price}",
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      state.productDetails.description,
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                  ]),
                );
              } else if (state is ProductDetailsError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline,
                          color: Colors.red, size: 60),
                      const SizedBox(height: 16),
                      Text(
                        state.message, 
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          _productDetailsCubit
                              .intent(GetProductDetails(productId: widget.productId));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal),
                        child: const Text("Try Again",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                );
              } else {
                return Skeletonizer(
                    enabled: true,
                    enableSwitchAnimation: true,
                    child: SingleChildScrollView(
                      child: Column(children: [
                        SizedBox(
                            height: 331,
                            width: double.infinity,
                            child: Card(
                              elevation: 10,
                              child: PageView.builder(
                                  itemCount: 3,
                                  onPageChanged: (value) {
                                    setState(() {
                                      currentIndex = value;
                                    });
                                  },
                                  itemBuilder: (context, index) {
                                    return Container();
                                  }),
                            )),
                        const SizedBox(height: 10),
                        DotsIndicator(
                          dotsCount: 3,
                          position: currentIndex.toDouble(),
                          decorator: DotsDecorator(
                            activeColor: Colors.teal,
                            size: const Size.square(9.0),
                            activeSize: const Size(18.0, 9.0),
                            activeShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Row(
                          children: [
                            Text(
                              "T_shirt",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Text(
                              "EGP 100",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Elevate your casual wardrobe with our Classic Red Pullover Hoodie. Crafted with a soft cotton blend for ultimate comfort, this vibrant red hoodie features a kangaroo pocket, adjustable drawstring hood, and ribbed cuffs for a snug fit. The timeless design ensures easy pairing with jeans or joggers for a relaxed yet stylish look, making it a versatile addition to your everyday attire",
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(
                          height: 80,
                        ),
                      ]),
                    ));
              }
            },
          ),
        ));
  }
}

