import 'package:flutique/feature/products/domain/usecases/get_product_by_id.dart';
import 'package:flutique/feature/products/presentation/bloc/product_bloc.dart';
import 'package:flutique/feature/products/presentation/bloc/product_detail_bloc/product_detail_cubit.dart';
import 'package:flutique/feature/products/presentation/page/product_detail_page.dart';
import 'package:flutique/feature/products/presentation/page/products_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutique/injection_container.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/products',
    routes: [
      GoRoute(
        path: '/products',
        name: 'products',
        builder: (context, state) =>
            BlocProvider(
              create: (context) => sl<ProductBloc>(),
              child: const ProductsPage(),
            ),
        routes: [
          GoRoute(
              path: ':id',
              name: 'product-detail',
              builder: (context, state) {
                final productId = state.pathParameters['id'] ?? '';
                return BlocProvider(
                    create: (context) =>
                    ProductDetailCubit(sl<GetProductByIdUseCase>())..getProductById(productId),
                    child: ProductDetailPage(productId: productId),);
              }
          )
        ],


      ),
    ],
  );
}
