import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/app_theme.dart';
import 'data/product_api.dart';
import 'data/cart_local.dart';
import 'features/products/cubit/product_details/product_details_cubit.dart';
import 'features/cart/cubit/cart_cubit.dart';
import 'features/products/cubit/product_lists/product_list_cubit.dart';
import 'features/products/screens/product_list_screen.dart';
import 'mainNavigation.dart';

void main() {
  runApp(const MiniShopApp());
}

class MiniShopApp extends StatelessWidget {
  const MiniShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    final api = ProductApi();
    final local = CartLocal();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ProductListCubit(api)),
        BlocProvider(create: (_) => ProductDetailCubit(api)),
        BlocProvider(create: (_) => CartCubit(local)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mini Shop',
        theme: AppTheme.light,
        home: const MainNavigation(),

      ),
    );
  }
}
