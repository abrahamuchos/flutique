import 'package:dio/dio.dart';
import 'package:flutique/feature/products/data/models/product_model.dart';
import 'package:retrofit/retrofit.dart';

part 'product_api_service.g.dart';

@RestApi(baseUrl: 'https://dummyjson.com')
abstract class ProductApiService{
  factory ProductApiService(Dio dio, {String baseUrl}) = _ProductApiService;

  @GET('/products')
  Future<HttpResponse<List<ProductModel>>> getProducts();
}