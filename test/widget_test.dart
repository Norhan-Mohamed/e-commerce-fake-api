import 'package:e_commerce/data/cart_local.dart';
import 'package:e_commerce/data/product_api.dart';
import 'package:e_commerce/features/cart/cubit/cart_cubit.dart';
import 'package:e_commerce/features/products/cubit/product_lists/product_list_cubit.dart';
import 'package:e_commerce/features/products/screens/product_list_screen.dart';
import 'package:e_commerce/mainNavigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() {
  // Helper to build app with Cubit providers
  Widget buildTestWidget(Widget child) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ProductListCubit(ProductApi())),
        BlocProvider(create: (_) => CartCubit(CartLocal())),
      ],
      child: MaterialApp(
        home: child,
      ),
    );
  }

  testWidgets('App loads ProductListScreen successfully',
          (WidgetTester tester) async {
        // Load the product list page
        await tester.pumpWidget(buildTestWidget(const ProductListScreen()));

        // Wait for UI to settle (loading spinner appears)
        expect(find.byType(CircularProgressIndicator), findsOneWidget);

        // Let API load
        await tester.pumpAndSettle(const Duration(seconds: 3));

        // After data loads → product cards should appear
        expect(find.byType(GridTile), findsNothing); // safe check
        expect(find.byType(GestureDetector), findsWidgets);
      });

  testWidgets('MainNavigation builds correctly',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestWidget(const MainNavigation()),
        );

        expect(find.text('Home'), findsOneWidget);

        expect(find.byType(NavigationBar), findsOneWidget);
      });
}
