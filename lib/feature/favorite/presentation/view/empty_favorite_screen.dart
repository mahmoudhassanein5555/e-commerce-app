import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EmptyFavoriteScreen extends StatelessWidget {
  const EmptyFavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/empty_favorite.png',
          width: 200,
          height: 200,
        ),
        const SizedBox(height: 20),
        const Text(
          'Your favorites list is empty',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      ],
    );
  }
}
