import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutique/core/model/either.dart';
import 'package:flutique/core/model/failure.dart';
import 'package:flutique/feature/products/data/data_source/remote/product_api_service.dart';
import 'package:flutique/feature/products/domain/entities/product.dart';
import 'package:flutique/feature/products/domain/repository/product_repository.dart';

class ProductRepositoryImp implements ProductRepository {
  final ProductApiService _productApiService;

  ProductRepositoryImp(this._productApiService);

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      final httpResponse = await _productApiService.getProducts();

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return Right(httpResponse.data);
      } else {
        return Left(ServerFailure('Failed to load products'));
      }

    } on DioException catch (err) {
      return Left(ServerFailure('Failed to load products'));
    }
  }

  @override
  Future<Either<Failure, Product>> getProduct(String id) async {
      try{
        final httpResponse = await _productApiService.getProduct(id);

        if (httpResponse.response.statusCode == HttpStatus.ok) {
          return Right(httpResponse.data);
        } else {
          return Left(ServerFailure('Failed to load product'));
        }

      }on DioException catch(err){
        return Left(ServerFailure('Failed to load product'));
      }
  }
}
