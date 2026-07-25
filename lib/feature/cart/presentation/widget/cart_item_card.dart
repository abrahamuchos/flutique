import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutique/feature/cart/domain/entities/cart_item.dart';
import 'package:flutique/config/theme/app_colors.dart';

class CartItemCard extends StatelessWidget {
  final CartItem item;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onRemove;

  const CartItemCard({
    super.key,
    required this.item,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width / 3.5,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          _buildImage(context, item.thumbnail ?? ''),
          _buildContent(context, item),
        ],
      ),
    );
  }

  SizedBox _buildImage(BuildContext context, String thumbnail) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 4,
      child: CachedNetworkImage(
        imageUrl: thumbnail,
        placeholder:
            (BuildContext context, String url) => Center(
              child: const CircularProgressIndicator(color: AppColors.turkey),
            ),
        errorWidget:
            (BuildContext context, String url, Object error) =>
                const Icon(Icons.no_photography_outlined, size: 30),
      ),
    );
  }

  Expanded _buildContent(BuildContext context, CartItem item) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Center Information
          SizedBox(
            width: MediaQuery.of(context).size.width / 2.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Brand: Rovero',
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ],
                ),
                // QTY Button
                Row(
                  children: [
                    _qtyButton(Icons.remove, onDecrement),
                    SizedBox(width: 4),
                    Text(item.qty.toString()),
                    SizedBox(width: 4),
                    _qtyButton(Icons.add, onIncrement),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          // Trans and price
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: onRemove,
                icon: Icon(Icons.delete_outline_outlined),
                iconSize: 20,
              ),
              Text(
                "\$${item.subtotal.toStringAsFixed(2)}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.dark,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _qtyButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(icon, size: 16, color: AppColors.primary),
      ),
    );
  }
}
