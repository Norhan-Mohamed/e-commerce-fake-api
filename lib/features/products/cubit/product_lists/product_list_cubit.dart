import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/product_api.dart';
import '../../product_model.dart';
import 'product_list_state.dart';

class ProductListCubit extends Cubit<ProductListState> {
  final ProductApi api;

  ProductListCubit(this.api) : super(ProductListInitial());

  Future<void> loadProducts() async {
    emit(ProductListLoading());

    try {
      final List<Product> products = await api.getProducts();

      if (products.isEmpty) {
        emit(ProductListEmpty());
        return;
      }

      emit(ProductListLoaded(products, products));
    } catch (e) {
      emit(ProductListError(e.toString()));
    }
  }

  void search(String text) {
    if (state is! ProductListLoaded) return;

    final current = state as ProductListLoaded;

    if (text.isEmpty) {
      emit(ProductListLoaded(current.products, current.products));
      return;
    }

    final filtered = current.products
        .where((p) => p.title.toLowerCase().contains(text.toLowerCase()))
        .toList();

    if (filtered.isEmpty) {
      emit(ProductListEmpty());
      return;
    }

    emit(ProductListLoaded(current.products, filtered));
  }
}
