import 'package:dio/dio.dart';
import 'package:flutique/feature/cart/data/data_source/local/cart_local_service.dart';
import 'package:flutique/feature/cart/data/models/cart_item_model.dart';
import 'package:flutique/feature/cart/data/repository/cart_item_repository_impl.dart';
import 'package:flutique/feature/cart/domain/repository/cart_repository.dart';
import 'package:flutique/feature/cart/domain/usecase/add_item.dart';
import 'package:flutique/feature/cart/domain/usecase/clear_cart.dart';
import 'package:flutique/feature/cart/domain/usecase/get_items.dart';
import 'package:flutique/feature/cart/domain/usecase/remove_cart_item.dart';
import 'package:flutique/feature/cart/domain/usecase/update_cart_item_qty.dart';
import 'package:flutique/feature/cart/presentation/bloc/cart_cubit.dart';
import 'package:flutique/feature/products/data/data_source/remote/product_api_service.dart';
import 'package:flutique/feature/products/data/repository/product_repository_impl.dart';
import 'package:flutique/feature/products/domain/repository/product_repository.dart';
import 'package:flutique/feature/products/domain/usecases/get_product_by_id.dart';
import 'package:flutique/feature/products/domain/usecases/get_products.dart';
import 'package:flutique/feature/products/presentation/bloc/product_bloc.dart';
import 'package:flutique/feature/products/presentation/bloc/product_detail_bloc/product_detail_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  //Dio
  sl.registerSingleton<Dio>(Dio());

  //Dependencies
  sl.registerSingleton<ProductApiService>(ProductApiService(sl<Dio>()));

  //Hive
  await Hive.initFlutter();
  Hive.registerAdapter(CartItemModelAdapter());
  final cartBox = await Hive.openBox<CartItemModel>('cartBox');
  sl.registerSingleton<Box<CartItemModel>>(cartBox);

  //Local Data Sources
  sl.registerSingleton<CartLocalService>(CartLocalServiceImpl(sl()));

  //Repositories
  sl.registerSingleton<ProductRepository>(ProductRepositoryImp(sl()));
  sl.registerSingleton<CartRepository>(CartItemRepositoryImpl(sl()));

  //Use Cases
  sl.registerSingleton<GetProductsUseCase>(
    GetProductsUseCase(productRepository: sl()),
  );
  sl.registerSingleton<GetProductByIdUseCase>(
    GetProductByIdUseCase(productRepository: sl()),
  );
  sl.registerSingleton<AddItemUseCase>(AddItemUseCase(cartRepository: sl()));
  sl.registerSingleton<ClearCartUseCase>(
    ClearCartUseCase(cartRepository: sl()),
  );
  sl.registerSingleton<GetItemsUseCase>(GetItemsUseCase(cartRepository: sl()));
  sl.registerSingleton<RemoveCartItemUseCase>(
    RemoveCartItemUseCase(cartRepository: sl()),
  );
  sl.registerSingleton<UpdateCartItemQtyUseCase>(
    UpdateCartItemQtyUseCase(cartRepository: sl()),
  );

  // Blocs
  sl.registerFactory<ProductBloc>(() => ProductBloc(sl()));
  sl.registerFactory<ProductDetailCubit>(() => ProductDetailCubit(sl()));

  //CartCubit se usa una sola instancia para toda la app
  // registerLazySingleton + ..loadCart() hace que el carrito se cargue de Hive
  // en cuanto se pide la instancia por primera vez
  sl.registerLazySingleton<CartCubit>(
    () => CartCubit(sl(), sl(), sl(), sl(), sl())..loadCart(),
  );
}
