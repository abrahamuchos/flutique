import 'package:equatable/equatable.dart';
import 'package:flutique/feature/products/domain/entities/product.dart';

class CartItem extends Equatable {
  final int productId;
  final String title;
  final double price;
  final int qty;
  final String? thumbnail;

  const CartItem({
    required this.productId,
    required this.title,
    required this.price,
    required this.qty,
    this.thumbnail,
  });

  double get subtotal => price * qty;

  //Helper para crear un cart item al agregar un product
  factory CartItem.fromProduct(Product product, {int qty = 1}) {
    return CartItem(
      productId: product.id,
      title: product.title,
      price: product.price,
      qty: qty,
    );
  }

  CartItem copyWith({int? qty}) {
    return CartItem(
      productId: productId,
      title: title,
      price: price,
      qty: qty ?? this.qty,
    );
  }

  @override
  List<Object?> get props => [productId, title, price, qty, thumbnail];
}
