import 'package:e_commerce_app/feature/home/domain/entites/product_response_entity.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:marquee/marquee.dart';

class ProductItemWidget extends StatefulWidget {
  const ProductItemWidget({super.key, required this.product});
  final ProductsResponseEntity product;
  static const String imageTest =
      'https://picperf.io/https://laravelnews.s3.amazonaws.com/featured-images/dummy.png';
  @override
  State<ProductItemWidget> createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends State<ProductItemWidget> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Column(
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
                errorWidget: (context, url, error) => const Icon(Icons.error),
                width: double.infinity,
                height: 180,
                fit: BoxFit.fill,
              ),
              Positioned(
                  top: 3,
                  right: 5,
                  child: IconButton(
                      onPressed: () {
                        isFavorite = !isFavorite;
                        setState(() {});
                      },
                      icon: Icon(
                        isFavorite == true
                            ? Icons.favorite_outlined
                            : Icons.favorite_border_outlined,
                        size: 30,
                        color: isFavorite == true
                            ? const Color.fromARGB(255, 171, 18, 7)
                            : const Color.fromARGB(255, 62, 61, 61),
                      ))),
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
            ]))
      ],
    );
  }
}
