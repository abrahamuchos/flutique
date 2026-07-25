import 'package:flutique/feature/cart/data/models/cart_item_model.dart';
import 'package:hive/hive.dart';

abstract class CartLocalService {
  Future<List<CartItemModel>> getItems();

  Future<void> addItem(CartItemModel item);

  Future<void> removeItem(int productId);

  Future<void> updateQty(int productId, int qty);

  Future<void> clearCart();
}

class CartLocalServiceImpl implements CartLocalService {
  final Box<CartItemModel> _cartBox;

  CartLocalServiceImpl(this._cartBox);

  @override
  Future<void> addItem(CartItemModel item) async {
    final existing = _cartBox.get(item.productId);

    if (existing != null) {
      await _cartBox.put(
        item.productId,
        CartItemModel(
          productId: existing.productId,
          title: existing.title,
          price: existing.price,
          qty: existing.qty + item.qty,
        ),
      );
    } else {
      await _cartBox.put(item.productId, item);
    }
  }

  @override
  Future<void> clearCart() async{
    await _cartBox.clear();
  }

  @override
  Future<List<CartItemModel>> getItems() async {
    return _cartBox.values.toList();
  }

  @override
  Future<void> removeItem(int productId) async{
    final existing = _cartBox.get(productId);
    if(existing != null){
      await _cartBox.delete(productId);
    }
  }

  @override
  Future<void> updateQty(int productId, int qty) async {
    final existing = _cartBox.get(productId);

    if (existing != null) {
      await _cartBox.put(
          productId,
          CartItemModel(
            productId: existing.productId,
            title: existing.title,
            price: existing.price,
            thumbnail: existing.thumbnail,
            qty: qty,
          )
      );
    }
  }
}
