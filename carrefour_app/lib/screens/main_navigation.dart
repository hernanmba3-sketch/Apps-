import 'package:flutter/material.dart';

import '../models/product.dart';
import '../data/stores.dart';
import 'Home_page.dart';
import 'Categories_page.dart';
import 'Wishlist_page.dart';
import 'Cart_page.dart';
import 'account_page.dart';
import 'Category_products_page.dart';
import 'Promotions_page.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int currentIndex = 0;

  String selectedStore = stores[0];

  final Map<int, int> cart = {};
  final Set<int> wishlist = {};

  final List<String> shoppingList = [];

  int get cartCount {
    return cart.values.fold(0, (sum, quantity) => sum + quantity);
  }

  void addToCart(Product product) {
    setState(() {
      cart[product.id] = (cart[product.id] ?? 0) + 1;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} added to cart'),
        backgroundColor: const Color(0xFFE30613),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void removeFromCart(Product product) {
    setState(() {
      if (!cart.containsKey(product.id)) return;

      if (cart[product.id]! > 1) {
        cart[product.id] = cart[product.id]! - 1;
      } else {
        cart.remove(product.id);
      }
    });
  }

  void deleteFromCart(Product product) {
    setState(() {
      cart.remove(product.id);
    });
  }

  void toggleWishlist(Product product) {
    setState(() {
      if (wishlist.contains(product.id)) {
        wishlist.remove(product.id);
      } else {
        wishlist.add(product.id);
      }
    });
  }

  void addToShoppingList(String item) {
    setState(() {
      shoppingList.add(item);
    });
  }

  void removeFromShoppingList(String item) {
    setState(() {
      shoppingList.remove(item);
    });
  }

  void openCategory(String category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CategoryProductsPage(
          category: category,
          wishlist: wishlist,
          onToggleWishlist: toggleWishlist,
          onAddToCart: addToCart,
        ),
      ),
    );
  }

  void openPromotions() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PromotionsPage(
          wishlist: wishlist,
          onToggleWishlist: toggleWishlist,
          onAddToCart: addToCart,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: [
          HomePage(
            selectedStore: selectedStore,
            cartCount: cartCount,
            wishlist: wishlist,
            onStoreChanged: (store) {
              setState(() {
                selectedStore = store;
              });
            },
            onAddToCart: addToCart,
            onToggleWishlist: toggleWishlist,
            onCategorySelected: openCategory,
            onPromotions: openPromotions,
          ),

          CategoriesPage(onCategorySelected: openCategory),

          WishlistPage(
            wishlist: wishlist,
            onToggleWishlist: toggleWishlist,
            onAddToCart: addToCart,
          ),

          CartPage(
            cart: cart,
            onAdd: addToCart,
            onRemove: removeFromCart,
            onDelete: deleteFromCart,
            selectedStore: selectedStore,
          ),

          const AccountPage(),
        ],
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        indicatorColor: const Color(0xFFFFE1E3),
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),

          const NavigationDestination(
            icon: Icon(Icons.grid_view_outlined),
            selectedIcon: Icon(Icons.grid_view),
            label: 'Categories',
          ),

          NavigationDestination(
            icon: Badge(
              isLabelVisible: wishlist.isNotEmpty,
              label: Text('${wishlist.length}'),
              child: const Icon(Icons.favorite_border),
            ),
            selectedIcon: const Icon(Icons.favorite),
            label: 'Wishlist',
          ),

          NavigationDestination(
            icon: Badge(
              isLabelVisible: cartCount > 0,
              label: Text('$cartCount'),
              child: const Icon(Icons.shopping_cart_outlined),
            ),
            selectedIcon: Badge(
              isLabelVisible: cartCount > 0,
              label: Text('$cartCount'),
              child: const Icon(Icons.shopping_cart),
            ),
            label: 'Cart',
          ),

          const NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
