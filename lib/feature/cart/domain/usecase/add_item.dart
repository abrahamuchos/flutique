import 'package:flutique/core/model/either.dart';
import 'package:flutique/core/model/failure.dart';
import 'package:flutique/core/usecases/usecase.dart';
import 'package:flutique/feature/cart/domain/entities/cart_item.dart';
import 'package:flutique/feature/cart/domain/repository/cart_repository.dart';

class AddItemUseCase implements UseCase<Either<Failure, void>, CartItem> {
  final CartRepository _cartRepository;

  AddItemUseCase({required CartRepository cartRepository})
    : _cartRepository = cartRepository;

  @override
  Future<Either<Failure, void>> call(CartItem item) {
    return _cartRepository.addItem(item);
  }
}
