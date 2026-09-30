import 'package:flutter/material.dart';

import '../data/products.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';

class WishlistPage extends StatelessWidget {
  final Set<int> wishlist;
  final Function(Product) onAddToCart;
  final Function(Product) onToggleWishlist;

  const WishlistPage({
    super.key,
    required this.wishlist,
    required this.onAddToCart,
    required this.onToggleWishlist,
  });

  @override
  Widget build(BuildContext context) {
    final wishlistProducts = products
        .where((product) => wishlist.contains(product.id))
        .toList();

    return SafeArea(
      child: Column(
        children: [
          // --------------------------------------------------
          // HEADER
          // --------------------------------------------------
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
            child: Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Wishlist',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Products you want to keep an eye on.',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                if (wishlistProducts.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFE1E3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${wishlistProducts.length}',
                      style: const TextStyle(
                        color: Color(0xFFE30613),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // --------------------------------------------------
          // CONTENT
          // --------------------------------------------------
          Expanded(
            child: wishlistProducts.isEmpty
                ? const _EmptyWishlist()
                : GridView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 30),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: .60,
                        ),
                    itemCount: wishlistProducts.length,
                    itemBuilder: (context, index) {
                      final product = wishlistProducts[index];

                      return ProductCard(
                        product: product,
                        isWishlisted: true,
                        onAddToCart: () {
                          onAddToCart(product);
                        },
                        onToggleWishlist: () {
                          onToggleWishlist(product);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _EmptyWishlist extends StatelessWidget {
  const _EmptyWishlist();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: Color(0xFFFFE1E3),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.favorite_border,
                size: 50,
                color: Color(0xFFE30613),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Your wishlist is empty',
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Tap the heart on a product to save it here.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }
}
