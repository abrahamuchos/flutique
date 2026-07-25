import 'package:flutique/core/model/either.dart';
import 'package:flutique/core/model/failure.dart';
import 'package:flutique/core/usecases/no_params.dart';
import 'package:flutique/core/usecases/usecase.dart';
import 'package:flutique/feature/cart/domain/entities/cart_item.dart';
import 'package:flutique/feature/cart/domain/repository/cart_repository.dart';

class GetItemsUseCase
    implements UseCase<Either<Failure, List<CartItem>>, NoParams> {
  final CartRepository _cartRepository;

  GetItemsUseCase({required CartRepository cartRepository})
    : _cartRepository = cartRepository;

  @override
  Future<Either<Failure, List<CartItem>>> call(NoParams params) {
    return _cartRepository.getCartItems();
  }
}
