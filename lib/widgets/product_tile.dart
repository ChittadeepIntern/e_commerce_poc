
import 'package:flutter/material.dart';

import '../models/product_model.dart';
import '../screens/product_screen.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({
    super.key,
    required this.item,
  });

  final ProductModel item;

  @override
  Widget build(BuildContext context) {
    return ListTile(onTap: ()=>Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductScreen(item),
      ),
    ),leading: ClipRRect(
        borderRadius:
            BorderRadius.circular(8.0), // Adjust the radius as needed
        child: Image.network(
          item.image!,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
          item.title!), // Assuming the data has a 'title' field
      subtitle: Text(item.description!
          ),
      // Assuming the data has a 'description' field
    );
  }
}
