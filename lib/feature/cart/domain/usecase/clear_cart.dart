import 'package:flutique/core/model/either.dart';
import 'package:flutique/core/model/failure.dart';
import 'package:flutique/core/usecases/no_params.dart';
import 'package:flutique/core/usecases/usecase.dart';
import 'package:flutique/feature/cart/domain/repository/cart_repository.dart';

class ClearCartUseCase implements UseCase<Either<Failure, void>, NoParams> {
  final CartRepository _cartRepository;

  ClearCartUseCase({required CartRepository cartRepository})
    : _cartRepository = cartRepository;

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return _cartRepository.clearCart();
  }
}
