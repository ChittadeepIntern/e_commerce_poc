import 'package:e_commerce_poc/provider/categories_provider.dart';
import 'package:e_commerce_poc/widgets/categories_drawer.dart';
import 'package:e_commerce_poc/widgets/product_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/products_provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<ProductsProvider>(context, listen: false);
    final productsProvider = Provider.of<CategoriesProvider>(context, listen: false);
    // Fetch data when the screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dataProvider.fetchData();
      productsProvider.fetchData();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('E-Kart'),
      ),
        drawer: const CategoriesDrawer(),
      body: Consumer<ProductsProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.errorMessage != null) {
            return Center(child: Text(provider.errorMessage!));
          }

          if (provider.data.isEmpty) {
            return const Center(child: Text('No data found.'));
          }

          return ListView.builder(
            itemCount: provider.data.length,
            itemBuilder: (context, index) {
              final item = provider.data[index];
              return ProductTile(item: item);
            },
          );
        },
      ),
    );
  }
}
