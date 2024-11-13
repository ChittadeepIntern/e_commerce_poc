import 'package:e_commerce_poc/provider/categories_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/products_provider.dart';

class CategoriesDrawer extends StatelessWidget {
  const CategoriesDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Consumer<CategoriesProvider>(builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (provider.errorMessage != null) {
          return Center(child: Text(provider.errorMessage!));
        }
        if (provider.errorMessage != null) {
          return const Center(child: Text("No data found"));
        }
        return Center(
          child: ListView.builder(
              itemCount: provider.data.length,
              itemBuilder: (context, index) {
                final item = provider.data[index];
                final isSelected = provider.selectedCategory == item;

                return ListTile(
                    title: Text(
                      item,
                      style: TextStyle(
                          color: isSelected ? Colors.blue : Colors.black),
                    ),
                    onTap: () {
                      if (provider.selectedCategory == item) {
                        provider.selectCategory("");
                        Provider.of<ProductsProvider>(context, listen: false)
                            .fetchData();
                        return;
                      }
                      provider.selectCategory(item);
                      Provider.of<ProductsProvider>(context, listen: false)
                          .fetchDataByCategory(item);
                    });
              }),
        );
      }),
    );
  }
}
