import 'package:e_commerce/features/products/cubit/product_details/product_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/product_api.dart';


class ProductDetailCubit extends Cubit<ProductDetailState> {
  final ProductApi api;

  ProductDetailCubit(this.api) : super(ProductDetailInitial());

  Future<void> load(int id) async {
    emit(ProductDetailLoading());

    try {
      final product = await api.getProductById(id);
      emit(ProductDetailLoaded(product));
    } catch (e) {
      emit(ProductDetailError(e.toString()));
    }
  }
}
