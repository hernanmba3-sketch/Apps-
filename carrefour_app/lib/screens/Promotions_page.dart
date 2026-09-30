import 'package:flutter/material.dart';

import '../data/products.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';

class PromotionsPage extends StatelessWidget {
  final Set<int> wishlist;
  final Function(Product) onAddToCart;
  final Function(Product) onToggleWishlist;

  const PromotionsPage({
    super.key,
    required this.wishlist,
    required this.onAddToCart,
    required this.onToggleWishlist,
  });

  @override
  Widget build(BuildContext context) {
    final promotionProducts = products
        .where((product) => product.isPromotion)
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Promotions')),
      body: promotionProducts.isEmpty
          ? const Center(child: Text('No promotions available right now.'))
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: .60,
              ),
              itemCount: promotionProducts.length,
              itemBuilder: (context, index) {
                final product = promotionProducts[index];

                return ProductCard(
                  product: product,
                  isWishlisted: wishlist.contains(product.id),
                  onAddToCart: () => onAddToCart(product),
                  onToggleWishlist: () => onToggleWishlist(product),
                );
              },
            ),
    );
  }
}
