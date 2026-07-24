part of 'cart_cubit.dart';

sealed class CartState extends Equatable {
  const CartState();
}

final class CartLoading extends CartState {
  @override
  List<Object> get props => [];
}

final class CartLoaded extends CartState {
  final List<CartItem> items;

  const CartLoaded(this.items);

  int get totalItems => items.fold(0, (sum, item) => sum + item.qty);

  double get totalPrice => items.fold(0, (sum, item) => sum + item.subtotal);

  @override
  List<Object?> get props => [items];
}

final class CartError extends CartState {
  final String message;

  const CartError(this.message);

  @override
  List<Object?> get props => [message];
}
