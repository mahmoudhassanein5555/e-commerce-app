import 'package:e_commerce_app/feature/home/domain/entites/category_response_entity.dart';
import 'package:e_commerce_app/feature/home/domain/entites/product_response_entity.dart';
import 'package:e_commerce_app/feature/home/presentation/widgets/product_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeLoadingSkeletonWidget extends StatelessWidget {
  const HomeLoadingSkeletonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final dummyProduct = ProductsResponseEntity(
      id: 1,
      title: 'Solène Chronograph',
      price: 3890,
      category: const CategoriesResponseEntity(name: 'MAISON OR'),
      images: const [ProductsResponseEntity.fallbackImage],
    );

    return Skeletonizer(
      enabled: true,
      enableSwitchAnimation: true,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.58,
            crossAxisSpacing: 14.w,
            mainAxisSpacing: 14.h,
          ),
          itemCount: 4,
          itemBuilder: (context, index) {
            return ProductItemWidget(
              product: dummyProduct,
              onProductTap: () {},
            );
          },
        ),
      ),
    );
  }
}
