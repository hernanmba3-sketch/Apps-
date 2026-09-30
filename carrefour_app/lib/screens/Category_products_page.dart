import 'package:flutter/material.dart';

import '../data/products.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';

class CategoryProductsPage extends StatelessWidget {
  final String category;
  final Set<int> wishlist;
  final Function(Product) onAddToCart;
  final Function(Product) onToggleWishlist;

  const CategoryProductsPage({
    super.key,
    required this.category,
    required this.wishlist,
    required this.onAddToCart,
    required this.onToggleWishlist,
  });

  @override
  Widget build(BuildContext context) {
    final categoryProducts = products
        .where(
          (product) => product.category.toLowerCase() == category.toLowerCase(),
        )
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text(category)),
      body: categoryProducts.isEmpty
          ? const Center(child: Text('No products found in this category.'))
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: .60,
              ),
              itemCount: categoryProducts.length,
              itemBuilder: (context, index) {
                final product = categoryProducts[index];

                return ProductCard(
                  product: product,
                  isWishlisted: wishlist.contains(product.id),
                  onAddToCart: () {
                    onAddToCart(product);
                  },
                  onToggleWishlist: () {
                    onToggleWishlist(product);
                  },
                );
              },
            ),
    );
  }
}
