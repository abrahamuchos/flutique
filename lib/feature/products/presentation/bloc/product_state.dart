part of 'product_bloc.dart';

@immutable
sealed class ProductState extends Equatable{
  final List<Product> ? products;
  final String ? error;

  const ProductState({this.products, this.error});

  @override
  List<Object?> get props => [products, error];
}

final class ProductLoading extends ProductState {
  const ProductLoading();
}

final class ProductDone extends ProductState{
  const ProductDone(List<Product> products) : super(products: products);
}

final class ProductError extends ProductState{
  const ProductError(String error): super(error: error);
}