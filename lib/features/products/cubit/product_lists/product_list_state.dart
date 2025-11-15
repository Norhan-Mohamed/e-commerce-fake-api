import '../../product_model.dart';

abstract class ProductListState {}

class ProductListInitial extends ProductListState {}

class ProductListLoading extends ProductListState {}

class ProductListLoaded extends ProductListState {
  final List<Product> products;
  final List<Product> filtered;

  ProductListLoaded(this.products, this.filtered);
}

class ProductListEmpty extends ProductListState {}

class ProductListError extends ProductListState {
  final String message;
  ProductListError(this.message);
}
