import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/cart_local.dart';
import '../../products/product_model.dart';
import '../cart_item_model.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartLocal local;

  CartCubit(this.local) : super(CartInitial()) {
    loadCart();
  }

  Future<void> loadCart() async {
    emit(CartLoading());
    try {
      final items = await local.load();
      emit(CartLoaded(items));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> addToCart(Product product) async {
    if (state is! CartLoaded) return;

    final current = (state as CartLoaded).items;
    final updated = [...current];

    final index = updated.indexWhere((e) => e.product.id == product.id);

    if (index == -1) {
      updated.add(CartItem(product: product, quantity: 1));
    } else {
      updated[index] =
          updated[index].copyWith(quantity: updated[index].quantity + 1);
    }

    await local.save(updated);
    emit(CartLoaded(updated));
  }

  Future<void> increase(int id) async {
    if (state is! CartLoaded) return;

    final items = [...(state as CartLoaded).items];
    final index = items.indexWhere((e) => e.product.id == id);

    if (index == -1) return;

    items[index] =
        items[index].copyWith(quantity: items[index].quantity + 1);

    await local.save(items);
    emit(CartLoaded(items));
  }

  Future<void> decrease(int id) async {
    if (state is! CartLoaded) return;

    final items = [...(state as CartLoaded).items];
    final index = items.indexWhere((e) => e.product.id == id);

    if (index == -1) return;

    if (items[index].quantity == 1) {
      items.removeAt(index);
    } else {
      items[index] =
          items[index].copyWith(quantity: items[index].quantity - 1);
    }

    await local.save(items);
    emit(CartLoaded(items));
  }

  Future<void> removeItem(int id) async {
    if (state is! CartLoaded) return;

    final items =
    (state as CartLoaded).items.where((e) => e.product.id != id).toList();

    await local.save(items);
    emit(CartLoaded(items));
  }
}
