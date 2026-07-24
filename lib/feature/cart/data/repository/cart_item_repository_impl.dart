import 'package:flutique/core/model/either.dart';
import 'package:flutique/core/model/failure.dart';
import 'package:flutique/feature/cart/data/data_source/local/cart_local_service.dart';
import 'package:flutique/feature/cart/data/models/cart_item_model.dart';
import 'package:flutique/feature/cart/domain/entities/cart_item.dart';
import 'package:flutique/feature/cart/domain/repository/cart_repository.dart';

class CartItemRepositoryImpl implements CartRepository {
  final CartLocalService _cartLocalService;

  CartItemRepositoryImpl(this._cartLocalService);

  @override
  Future<Either<Failure, void>> addItem(CartItem item) async {
    try {
      await _cartLocalService.addItem(CartItemModel.fromEntity(item));

      return Right(null);
    } catch (_) {

      return Left(CacheFailure('Failed to add item to cart'));
    }
  }

  @override
  Future<Either<Failure, void>> clearCart() async {
    try {
      await _cartLocalService.clearCart();

      return Right(null);
    } catch (_) {

      return Left(CacheFailure('Failed to clear cart'));
    }
  }

  @override
  Future<Either<Failure, List<CartItem>>> getCartItems() async {
    try {
      final items = await _cartLocalService.getItems();
      final itemsEntity = items.map((item) => item.toEntity()).toList();

      return Right(itemsEntity);
    } catch (_) {

      return Left(CacheFailure('Failed to get cart'));
    }
  }

  @override
  Future<Either<Failure, void>> removeItem(int productId) async {
    try {
      await _cartLocalService.removeItem(productId);
      return Right(null);
    } catch (_) {

      return Left(CacheFailure('Failed to remove item'));
    }
  }

  @override
  Future<Either<Failure, void>> updateQty(int productId, int qty) async {
    try {
      await _cartLocalService.updateQty(productId, qty);

      return Right(null);
    } catch (_) {

      return Left(CacheFailure('Failed updated quantity'));
    }
  }
}
