import 'package:equatable/equatable.dart';
import 'package:flutique/core/model/either.dart';
import 'package:flutique/core/model/failure.dart';
import 'package:flutique/core/usecases/usecase.dart';
import 'package:flutique/feature/products/domain/entities/product.dart';
import 'package:flutique/feature/products/domain/repository/product_repository.dart';

class GetProductByIdUseCase
    implements UseCase<Either<Failure, Product>, ProductParams> {
  final ProductRepository _productRepository;

  GetProductByIdUseCase({required ProductRepository productRepository})
      : _productRepository = productRepository;

  @override
  Future<Either<Failure, Product>> call(ProductParams params) {
    return _productRepository.getProduct(params.id);
  }
}

class ProductParams extends Equatable {
  final String id;

  const ProductParams({required this.id});

  @override
  List<Object> get props => [id];
}