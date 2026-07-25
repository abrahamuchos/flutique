import 'package:flutique/core/model/either.dart';
import 'package:flutique/core/model/failure.dart';
import 'package:flutique/feature/cart/domain/entities/cart_item.dart';

abstract class CartRepository{
  Future<Either<Failure, List<CartItem>>> getCartItems();

  Future<Either<Failure, void>> addItem(CartItem item);

  Future<Either<Failure, void>> removeItem(int productId);

  Future<Either<Failure, void>> updateQty(int productId, int qty);

  Future<Either<Failure, void>> clearCart();

}