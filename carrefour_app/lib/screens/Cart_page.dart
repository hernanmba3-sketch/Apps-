import 'package:flutter/material.dart';

import '../data/products.dart';
import '../models/product.dart';
import 'checkout_page.dart';

class CartPage extends StatelessWidget {
  final Map<int, int> cart;
  final Function(Product) onAdd;
  final Function(Product) onRemove;
  final Function(Product) onDelete;
  final String selectedStore;

  const CartPage({
    super.key,
    required this.cart,
    required this.onAdd,
    required this.onRemove,
    required this.onDelete,
    required this.selectedStore,
  });

  @override
  Widget build(BuildContext context) {
    final cartProducts = products
        .where((product) => cart.containsKey(product.id))
        .toList();

    double subtotal = 0;

    for (final product in cartProducts) {
      final quantity = cart[product.id] ?? 0;
      subtotal += product.price * quantity;
    }

    final deliveryFee = subtotal >= 1500 || subtotal == 0 ? 0 : 100;
    final total = subtotal + deliveryFee;

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
                  child: Text(
                    'My Cart',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),
                if (cartProducts.isNotEmpty)
                  Text(
                    '${cart.values.fold(0, (sum, value) => sum + value)} items',
                    style: const TextStyle(color: Colors.grey),
                  ),
              ],
            ),
          ),

          // --------------------------------------------------
          // EMPTY CART
          // --------------------------------------------------
          if (cartProducts.isEmpty)
            const Expanded(child: _EmptyCart())
          else
            Expanded(
              child: Column(
                children: [
                  // ------------------------------------------------
                  // STORE
                  // ------------------------------------------------
                  Container(
                    margin: const EdgeInsets.fromLTRB(16, 4, 16, 8),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF4F4),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.store, color: Color(0xFFE30613)),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Collection / delivery store',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                selectedStore,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 20,
                        ),
                      ],
                    ),
                  ),

                  // ------------------------------------------------
                  // PRODUCTS
                  // ------------------------------------------------
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                      itemCount: cartProducts.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final product = cartProducts[index];
                        final quantity = cart[product.id] ?? 1;

                        return _CartItem(
                          product: product,
                          quantity: quantity,
                          onAdd: () => onAdd(product),
                          onRemove: () => onRemove(product),
                          onDelete: () => onDelete(product),
                        );
                      },
                    ),
                  ),

                  // ------------------------------------------------
                  // SUMMARY
                  // ------------------------------------------------
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.08),
                          blurRadius: 12,
                          offset: const Offset(0, -3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _SummaryRow(
                          label: 'Subtotal',
                          value: 'Rs ${subtotal.toStringAsFixed(0)}',
                        ),
                        const SizedBox(height: 8),
                        _SummaryRow(
                          label: 'Delivery',
                          value: deliveryFee == 0
                              ? 'FREE'
                              : 'Rs ${deliveryFee.toStringAsFixed(0)}',
                          valueColor: deliveryFee == 0
                              ? Colors.green
                              : Colors.black,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Divider(),
                        ),
                        _SummaryRow(
                          label: 'Total',
                          value: 'Rs ${total.toStringAsFixed(0)}',
                          isTotal: true,
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => CheckoutPage(
                                    cart: cart,
                                    selectedStore: selectedStore,
                                    subtotal: subtotal,
                                    deliveryFee: deliveryFee.toDouble(),
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFE30613),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: const Text(
                              'Proceed to checkout',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _CartItem extends StatelessWidget {
  final Product product;
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final VoidCallback onDelete;

  const _CartItem({
    required this.product,
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          // Product image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              product.image,
              width: 82,
              height: 82,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) {
                return Container(
                  width: 82,
                  height: 82,
                  color: Colors.grey.shade100,
                  child: const Icon(Icons.image_outlined, color: Colors.grey),
                );
              },
            ),
          ),

          const SizedBox(width: 12),

          // Product details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                Text(
                  'Rs ${product.price.toStringAsFixed(0)}',
                  style: const TextStyle(
                    color: Color(0xFFE30613),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 9),

                // Quantity controls
                Row(
                  children: [
                    _QuantityButton(icon: Icons.remove, onPressed: onRemove),
                    SizedBox(
                      width: 34,
                      child: Text(
                        '$quantity',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    _QuantityButton(icon: Icons.add, onPressed: onAdd),
                  ],
                ),
              ],
            ),
          ),

          IconButton(
            onPressed: onDelete,
            icon: const Icon(Icons.delete_outline, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _QuantityButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      height: 30,
      child: Material(
        color: const Color(0xFFF4F4F4),
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(8),
          child: Icon(icon, size: 17),
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;
  final Color? valueColor;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.isTotal = false,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 18 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 20 : 14,
            fontWeight: FontWeight.bold,
            color:
                valueColor ??
                (isTotal ? const Color(0xFFE30613) : Colors.black),
          ),
        ),
      ],
    );
  }
}

class _EmptyCart extends StatelessWidget {
  const _EmptyCart();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 105,
              height: 105,
              decoration: const BoxDecoration(
                color: Color(0xFFFFE1E3),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.shopping_cart_outlined,
                size: 52,
                color: Color(0xFFE30613),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Your cart is empty',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Add some products and they will appear here.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }
}
