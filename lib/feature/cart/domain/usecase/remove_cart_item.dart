import 'package:flutique/core/model/either.dart';
import 'package:flutique/core/model/failure.dart';
import 'package:flutique/core/usecases/usecase.dart';
import 'package:flutique/feature/cart/domain/repository/cart_repository.dart';

class RemoveCartItemUseCase implements UseCase<Either<Failure, void>, int>{
  final CartRepository _cartRepository;

  RemoveCartItemUseCase({required CartRepository cartRepository}): _cartRepository = cartRepository;

  @override
  Future<Either<Failure, void>> call(int productId) {
    return _cartRepository.removeItem(productId);
  }
}