import 'package:flutique/feature/cart/domain/entities/cart_item.dart';
import 'package:hive/hive.dart';

part 'cart_item_model.g.dart';

@HiveType(typeId: 0)
class CartItemModel {
  @HiveField(0)
  final int productId;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final double price;

  @HiveField(3)
  final int qty;

  @HiveField(4)
  final String? thumbnail;

  CartItemModel({
    required this.productId,
    required this.title,
    required this.price,
    required this.qty,
    this.thumbnail,
  });

  factory CartItemModel.fromEntity(CartItem item) {
    return CartItemModel(
      productId: item.productId,
      title: item.title,
      price: item.price,
      thumbnail: item.thumbnail,
      qty: item.qty,
    );
  }

  CartItem toEntity() {
    return CartItem(productId: productId,
        title: title,
        price: price,
        thumbnail: thumbnail,
        qty: qty,
    );
  }
}
