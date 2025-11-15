import 'package:e_commerce/features/products/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cart/cubit/cart_cubit.dart';
import '../../cart/screens/cart_screen.dart';
import '../cubit/product_lists/product_list_cubit.dart';
import '../cubit/product_lists/product_list_state.dart';
import '../widgets/product_card.dart';


class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductListCubit>().loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shoppe"),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartScreen()),
              );
            },
          ),
        ],
      ),

      body: Column(
        children: [
          // SEARCH BAR
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Search products…",
              ),
              onChanged: (value) {
                context.read<ProductListCubit>().search(value);
              },
            ),
          ),

          Expanded(
            child: BlocBuilder<ProductListCubit, ProductListState>(
              builder: (context, state) {
                if (state is ProductListLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is ProductListError) {
                  return Center(child: Text(state.message));
                }

                if (state is ProductListEmpty) {
                  return const Center(child: Text("No products found"));
                }

                if (state is ProductListLoaded) {
                  final items = state.filtered;

                  return GridView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: items.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.85,


                    ),
                    itemBuilder: (context, index) {
                      final product = items[index];

                      return ProductCard(
                        product: product,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProductDetailScreen(id: product.id),
                            ),
                          );
                        },
                        onAdd: () {
                          context.read<CartCubit>().addToCart(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Added to cart"),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                      );
                    },
                  );
                }

                return const SizedBox.shrink(); // For initial state
              },
            ),
          ),
        ],
      ),
    );
  }
}
