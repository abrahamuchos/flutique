import 'package:dio/dio.dart';
import 'package:flutique/feature/products/data/data_source/remote/product_api_service.dart';
import 'package:flutique/feature/products/data/repository/product_repository_impl.dart';
import 'package:flutique/feature/products/domain/repository/product_repository.dart';
import 'package:flutique/feature/products/domain/usecases/get_product_by_id.dart';
import 'package:flutique/feature/products/domain/usecases/get_products.dart';
import 'package:flutique/feature/products/presentation/bloc/product_bloc.dart';
import 'package:flutique/feature/products/presentation/bloc/product_detail_bloc/product_detail_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  //Dio
  sl.registerSingleton<Dio>(Dio());

  //Dependencies
  sl.registerSingleton<ProductApiService>(ProductApiService(sl<Dio>()));

  //Repositories
  sl.registerSingleton<ProductRepository>(ProductRepositoryImp(sl()));

  //Use Cases
  sl.registerSingleton<GetProductsUseCase>(GetProductsUseCase(productRepository: sl()));
  sl.registerSingleton<GetProductByIdUseCase>(GetProductByIdUseCase(productRepository: sl()));

  // Blocs
  sl.registerFactory<ProductBloc>(() => ProductBloc(sl()));
  sl.registerFactory<ProductDetailCubit>(() => ProductDetailCubit(sl()));


}
