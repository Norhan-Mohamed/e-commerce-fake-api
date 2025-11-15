import 'package:dio/dio.dart';
import '../features/products/product_model.dart';


class ProductApi {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://fakestoreapi.com",
      connectTimeout: const Duration(seconds: 12),
      receiveTimeout: const Duration(seconds: 12),
    ),
  );

  Future<List<Product>> getProducts() async {
    final response = await _dio.get('/products');
    final List list = response.data;
    return list.map((e) => Product.fromJson(e)).toList();
  }

  Future<Product> getProductById(int id) async {
    final response = await _dio.get('/products/$id');
    return Product.fromJson(response.data);
  }

}
