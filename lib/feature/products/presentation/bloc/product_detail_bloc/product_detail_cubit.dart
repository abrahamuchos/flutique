import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutique/feature/products/domain/entities/product.dart';
import 'package:flutique/feature/products/domain/usecases/get_product_by_id.dart';

part 'product_detail_state.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  final GetProductByIdUseCase _getProductByIdUseCase;

  ProductDetailCubit(this._getProductByIdUseCase)
    : super(ProductDetailLoading());

  Future<void> getProductById(String id) async {
    emit(ProductDetailLoading());

    final result = await _getProductByIdUseCase(ProductParams(id: id));

    result.fold(
      (left) {
        emit(ProductDetailError(left.toString()));
      },
      (right) {
        emit(ProductDetailLoaded(right));
      },
    );
  }
}
