import 'package:hive/hive.dart';

import '../model/cart_local_model.dart';


class CartService {
  static Box<CartItemLocal> get _cartBox => Hive.box<CartItemLocal>('cartBox');

  /// all cart items load
  static List<CartItemLocal> getCartItems() {
    return _cartBox.values.toList();
  }

  /// new item add
  static Future<void> addCartItem(CartItemLocal item) async {
    await _cartBox.add(item);
    print(_cartBox.values.toList());
  }

  /// remove with index
  static Future<void> removeCartItem(int index) async {
    await _cartBox.deleteAt(index);
  }

  /// all cart clear
  static Future<void> clearCart() async {
    await _cartBox.clear();
  }

  /// multiple item save(API)
  static Future<void> saveCartItems(List<CartItemLocal> items) async {
    await _cartBox.clear();
    for (var item in items) {
      await _cartBox.add(item);
    }
  }
}
