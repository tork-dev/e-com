import 'package:flutter/material.dart';
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
    // check if product already exists in the box
    final existingIndex = _cartBox.values.toList().indexWhere(
      (cartItem) => cartItem.productId == item.productId,
    );

    if (existingIndex != -1) {
      // product found → update quantity
      final existingItem = _cartBox.getAt(existingIndex)!;
      final updatedItem = existingItem.copyWith(
        quantity: (existingItem.quantity ?? 0) + (item.quantity ?? 1),
      );

      await _cartBox.putAt(existingIndex, updatedItem);
    } else {
      // product not found → add as new item
      await _cartBox.add(item);
    }

    debugPrint(_cartBox.values.toList().toString());
  }

  /// remove with index
  static Future<void> removeCartItem(int index) async {
    await _cartBox.deleteAt(index);
  }

  /// remove with id
  static Future<void> removeCartItemWithId(int productId) async {
    final index = _cartBox.values.toList().indexWhere(
      (item) => item.productId == productId,
    );
    if (index != -1) {
      await _cartBox.deleteAt(index);
    }
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

  /// Force reload of cart items (useful after add/remove)
  static List<CartItemLocal> refreshCart() {
    return _cartBox.values.toList();
  }
}
