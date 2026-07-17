part of 'product_detail_cubit.dart';

sealed class ProductDetailState extends Equatable {
  const ProductDetailState();
}

final class ProductDetailLoading extends ProductDetailState {
  @override
  List<Object?> get props => [];
}

final class ProductDetailLoaded extends ProductDetailState{
  final Product product;

  const ProductDetailLoaded(this.product);

  @override
  List<Object?> get props => [product];
}

final class ProductDetailError extends ProductDetailState{
  final String message;

  const ProductDetailError(this.message);

  @override
  List<Object?> get props => [message];

}


