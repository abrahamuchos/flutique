import 'package:flutique/core/model/either.dart';
import 'package:flutique/core/model/failure.dart';
import 'package:flutique/core/usecases/usecase.dart';
import 'package:flutique/feature/products/domain/entities/product.dart';
import 'package:flutique/feature/products/domain/repository/product_repository.dart';

class GetProductsUseCase
    implements UseCase<Either<Failure, List<Product>>, void> {
  final ProductRepository _productRepository;

  GetProductsUseCase({required ProductRepository productRepository})
    : _productRepository = productRepository;

  @override
  Future<Either<Failure, List<Product>>> call({void params}) {
    return _productRepository.getProducts();
  }
}
