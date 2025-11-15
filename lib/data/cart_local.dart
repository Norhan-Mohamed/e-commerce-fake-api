import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../features/cart/cart_item_model.dart';

class CartLocal {
  static const String _key = "cart_items";

  Future<void> save(List<CartItem> items) async {
    final prefs = await SharedPreferences.getInstance();
    final list = items.map((e) => e.toJson()).toList();
    prefs.setString(_key, jsonEncode(list));
  }

  Future<List<CartItem>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    if (jsonString == null) return [];
    final List decoded = jsonDecode(jsonString);
    return decoded.map((e) => CartItem.fromJson(e)).toList();
  }
}
