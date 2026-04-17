import 'package:e_commerce_app/feature/cart/presentation/view/empty_cart_screen.dart';
import 'package:e_commerce_app/feature/cart/presentation/view/non_empty_cart_screen.dart';
import 'package:e_commerce_app/feature/cart/presentation/view_model/home_cubit/product_cart_cubit.dart';
import 'package:e_commerce_app/feature/cart/presentation/view_model/home_cubit/product_cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "My Cart",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            return const EmptyCartScreen();
          }
          return const NonEmptyCartScreen();
        },
      ),
    );
  }
}
