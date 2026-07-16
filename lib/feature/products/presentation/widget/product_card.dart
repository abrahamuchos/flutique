import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutique/feature/products/domain/entities/product.dart';
import 'package:flutter/material.dart';
import 'package:flutique/config/theme/app_colors.dart';
import 'package:go_router/go_router.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).goNamed(
          'product-detail',
          pathParameters: {'id': product.id.toString()},
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CachedNetworkImage(
                imageUrl: product.images!.first,
                placeholder:
                    (BuildContext context, String url) => Center(
                      child: const CircularProgressIndicator(
                        color: AppColors.turkey,
                      ),
                    ),
                errorWidget:
                    (BuildContext context, String url, Object error) =>
                        const Icon(Icons.no_photography_outlined, size: 120),
              ),
            ),
            SizedBox(height: 10),
            //Card Info
            _buildCardInfo(product),
          ],
        ),
      ),
    );
  }

  Column _buildCardInfo(Product product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.title,
          maxLines: 1,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          overflow: TextOverflow.ellipsis,
        ),
        Text(product.brand ?? 'Unknow', style: TextStyle(color: Colors.grey)),
        Text(
          "\$${product.price.toStringAsFixed(2)} USD",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ],
    );
  }
}
