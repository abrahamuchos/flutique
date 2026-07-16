part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {
  const ProductEvent();
}

final class GetProduct extends ProductEvent{
  const GetProduct();

}
