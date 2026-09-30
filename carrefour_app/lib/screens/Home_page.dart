import 'package:flutter/material.dart';

import '../data/categories.dart';
import '../data/products.dart';
import '../data/stores.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import '../widgets/section_header.dart';
import '../widgets/Store_selector.dart';
import 'search_page.dart';

class HomePage extends StatelessWidget {
  final String selectedStore;
  final int cartCount;
  final Set<int> wishlist;

  final Function(String) onStoreChanged;
  final Function(Product) onAddToCart;
  final Function(Product) onToggleWishlist;
  final Function(String) onCategorySelected;
  final VoidCallback onPromotions;

  const HomePage({
    super.key,
    required this.selectedStore,
    required this.cartCount,
    required this.wishlist,
    required this.onStoreChanged,
    required this.onAddToCart,
    required this.onToggleWishlist,
    required this.onCategorySelected,
    required this.onPromotions,
  });

  @override
  Widget build(BuildContext context) {
    final promotions = products
        .where((product) => product.isPromotion)
        .toList();

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          // ----------------------------------------------------
          // HEADER
          // ----------------------------------------------------
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 8),
              child: Row(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE30613),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(Icons.shopping_cart, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome 👋',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        Text(
                          'Carrefour Mauritius',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Notifications will be available soon.',
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.notifications_none),
                  ),
                ],
              ),
            ),
          ),

          // ----------------------------------------------------
          // STORE SELECTOR
          // ----------------------------------------------------
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    showDragHandle: true,
                    builder: (_) {
                      return StoreSelector(
                        selectedStore: selectedStore,
                        stores: stores,
                        onSelected: (store) {
                          onStoreChanged(store);
                          Navigator.pop(context);
                        },
                      );
                    },
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.store, color: Color(0xFFE30613)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Shopping at',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              selectedStore,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_down),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ----------------------------------------------------
          // SEARCH
          // ----------------------------------------------------
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 18),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SearchPage(
                        wishlist: wishlist,
                        onToggleWishlist: onToggleWishlist,
                        onAddToCart: onAddToCart,
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 52,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.search, color: Colors.grey),
                      SizedBox(width: 10),
                      Text(
                        'Search products...',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ----------------------------------------------------
          // PROMOTION BANNER
          // ----------------------------------------------------
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                onTap: onPromotions,
                child: Container(
                  height: 175,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE30613),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        right: -30,
                        top: -30,
                        child: Container(
                          width: 190,
                          height: 190,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.10),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'THIS WEEK',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                            SizedBox(height: 7),
                            Text(
                              'Amazing\nPromotions',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 29,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                            Text(
                              'Tap to discover →',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ----------------------------------------------------
          // CATEGORIES
          // ----------------------------------------------------
          SliverToBoxAdapter(
            child: SectionHeader(title: 'Shop by category', onSeeAll: () {}),
          ),

          SliverToBoxAdapter(
            child: SizedBox(
              height: 108,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: Categories.length,
                itemBuilder: (_, index) {
                  final category = Categories[index];

                  return GestureDetector(
                    onTap: () {
                      onCategorySelected(category['name'] as String);
                    },
                    child: Container(
                      width: 82,
                      margin: const EdgeInsets.only(right: 14),
                      child: Column(
                        children: [
                          Container(
                            width: 62,
                            height: 62,
                            decoration: BoxDecoration(
                              color: (category['color'] as Color).withOpacity(
                                .12,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              category['icon'] as IconData,
                              color: category['color'] as Color,
                              size: 29,
                            ),
                          ),
                          const SizedBox(height: 7),
                          Text(
                            category['name'] as String,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // ----------------------------------------------------
          // DEALS
          // ----------------------------------------------------
          SliverToBoxAdapter(
            child: SectionHeader(
              title: '🔥 Deals for you',
              onSeeAll: onPromotions,
            ),
          ),

          SliverToBoxAdapter(
            child: SizedBox(
              height: 305,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: promotions.length,
                itemBuilder: (_, index) {
                  final product = promotions[index];

                  return SizedBox(
                    width: 190,
                    child: ProductCard(
                      product: product,
                      isWishlisted: wishlist.contains(product.id),
                      onAddToCart: () {
                        onAddToCart(product);
                      },
                      onToggleWishlist: () {
                        onToggleWishlist(product);
                      },
                    ),
                  );
                },
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 30)),
        ],
      ),
    );
  }
}
