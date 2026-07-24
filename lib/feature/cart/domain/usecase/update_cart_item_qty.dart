import 'package:equatable/equatable.dart';
import 'package:flutique/core/model/either.dart';
import 'package:flutique/core/model/failure.dart';
import 'package:flutique/core/usecases/usecase.dart';
import 'package:flutique/feature/cart/domain/repository/cart_repository.dart';

class UpdateCartItemQtyUseCase implements UseCase<Either<Failure, void>, UpdateQtyParams> {
  final CartRepository _cartRepository;

  UpdateCartItemQtyUseCase({required CartRepository cartRepository})
    : _cartRepository = cartRepository;

  @override
  Future<Either<Failure, void>> call(UpdateQtyParams params) {
    return _cartRepository.updateQty(params.productId, params.qty);
  }

}

class UpdateQtyParams extends Equatable {
  final int productId;
  final int qty;

  const UpdateQtyParams({required this.productId, required this.qty});

  @override
  List<Object?> get props => [productId, qty];
}
