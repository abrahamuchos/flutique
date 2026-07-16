import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutique/core/usecases/no_params.dart';
import 'package:flutique/feature/products/domain/entities/product.dart';
import 'package:flutique/feature/products/domain/usecases/get_products.dart';
import 'package:meta/meta.dart';

part 'product_event.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductsUseCase _getProductsUseCase;

  ProductBloc(this._getProductsUseCase) : super(ProductLoading()) {
    on<ProductEvent>(onGetProducts);
  }

  Future<void> onGetProducts(
    ProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());

    final result = await _getProductsUseCase(const NoParams());

    result.fold(
      (left) {
        emit(ProductError(left.toString()));
      },
      (right) {
        emit(ProductDone(right));
      },
    );
  }
}
