import 'package:flutique/core/model/either.dart';
import 'package:flutique/core/model/failure.dart';
import 'package:flutique/feature/products/domain/entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts();

  Future<Either<Failure, Product>> getProduct(String id);
}
