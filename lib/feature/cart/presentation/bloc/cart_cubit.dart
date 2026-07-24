import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutique/core/usecases/no_params.dart';
import 'package:flutique/feature/cart/domain/entities/cart_item.dart';
import 'package:flutique/feature/cart/domain/usecase/add_item.dart';
import 'package:flutique/feature/cart/domain/usecase/clear_cart.dart';
import 'package:flutique/feature/cart/domain/usecase/get_items.dart';
import 'package:flutique/feature/cart/domain/usecase/remove_cart_item.dart';
import 'package:flutique/feature/cart/domain/usecase/update_cart_item_qty.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final AddItemUseCase _addItemUseCase;
  final ClearCartUseCase _clearCartUseCase;
  final GetItemsUseCase _getItemsUseCase;
  final RemoveCartItemUseCase _removeCartItemUseCase;
  final UpdateCartItemQtyUseCase _updateCartItemQtyUseCase;

  CartCubit(
    this._addItemUseCase,
    this._clearCartUseCase,
    this._getItemsUseCase,
    this._removeCartItemUseCase,
    this._updateCartItemQtyUseCase,
  ) : super(CartLoading());

  Future<void> loadCart() async {
    emit(CartLoading());
    await _refresh();
  }

  Future<void> addItem(CartItem item) async {
    final result = await _addItemUseCase(item);
    await result.fold(
      (left) async {
        emit(CartError(left.toString()));
      },
      (right) {
        _refresh();
      },
    );
  }

  Future<void> removeItem(int productId) async {
    final result = await _removeCartItemUseCase(productId);

    await result.fold(
      (left) async => emit(CartError(left.toString())),
      (_) => _refresh(),
    );
  }

  Future<void> updateQty(int productId, int qty) async {
    final result = await _updateCartItemQtyUseCase(
      UpdateQtyParams(productId: productId, qty: qty),
    );

    await result.fold(
      (left) async => emit(CartError(left.toString())),
      (_) => _refresh(),
    );
  }

  Future<void> clearCart() async {
    final result = await _clearCartUseCase(const NoParams());

    await result.fold(
      (left) async => emit(CartError(left.toString())),
      (_) => _refresh(),
    );
  }

  Future<void> _refresh() async {
    final result = await _getItemsUseCase(const NoParams());
    result.fold(
      (failure) => emit(CartError(failure.toString())),
      (items) => emit(CartLoaded(items)),
    );
  }
}
