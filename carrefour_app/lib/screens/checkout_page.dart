import 'package:flutter/material.dart';

class CheckoutPage extends StatefulWidget {
  final Map<int, int> cart;
  final String selectedStore;
  final double subtotal;
  final double deliveryFee;

  const CheckoutPage({
    super.key,
    required this.cart,
    required this.selectedStore,
    required this.subtotal,
    required this.deliveryFee,
  });

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String deliveryMethod = 'Delivery';
  String paymentMethod = 'Cash';

  final TextEditingController addressController = TextEditingController();

  @override
  void dispose() {
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final total = widget.subtotal + widget.deliveryFee;

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Where should we deliver?',
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            _OptionCard(
              title: 'Delivery',
              subtitle: 'Have your groceries delivered to you',
              icon: Icons.local_shipping_outlined,
              selected: deliveryMethod == 'Delivery',
              onTap: () {
                setState(() {
                  deliveryMethod = 'Delivery';
                });
              },
            ),

            const SizedBox(height: 10),

            _OptionCard(
              title: 'Click & Collect',
              subtitle: 'Collect your order from your selected store',
              icon: Icons.store_outlined,
              selected: deliveryMethod == 'Collection',
              onTap: () {
                setState(() {
                  deliveryMethod = 'Collection';
                });
              },
            ),

            const SizedBox(height: 22),

            if (deliveryMethod == 'Delivery') ...[
              const Text(
                'Delivery address',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              TextField(
                controller: addressController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Enter your delivery address',
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],

            // Store
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF4F4),
                borderRadius: BorderRadius.circular(15),
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
                          'Selected store',
                          style: TextStyle(fontSize: 11, color: Colors.grey),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          widget.selectedStore,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Payment method',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            _PaymentOption(
              title: 'Cash',
              subtitle: 'Pay when your order arrives',
              icon: Icons.payments_outlined,
              selected: paymentMethod == 'Cash',
              onTap: () {
                setState(() {
                  paymentMethod = 'Cash';
                });
              },
            ),

            const SizedBox(height: 10),

            _PaymentOption(
              title: 'Card',
              subtitle: 'Pay securely by card',
              icon: Icons.credit_card_outlined,
              selected: paymentMethod == 'Card',
              onTap: () {
                setState(() {
                  paymentMethod = 'Card';
                });
              },
            ),

            const SizedBox(height: 25),

            const Text(
              'Order summary',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            _SummaryLine(
              label: 'Subtotal',
              value: 'Rs ${widget.subtotal.toStringAsFixed(0)}',
            ),

            const SizedBox(height: 7),

            _SummaryLine(
              label: 'Delivery',
              value: widget.deliveryFee == 0
                  ? 'FREE'
                  : 'Rs ${widget.deliveryFee.toStringAsFixed(0)}',
            ),

            const Divider(height: 25),

            _SummaryLine(
              label: 'Total',
              value: 'Rs ${total.toStringAsFixed(0)}',
              bold: true,
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  _placeOrder(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE30613),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  'Place order',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _placeOrder(BuildContext context) {
    if (deliveryMethod == 'Delivery' && addressController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your delivery address.')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Order placed! 🎉'),
          content: const Text(
            'Your order has been received. '
            'Order tracking will be available in a future version.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text(
                'Done',
                style: TextStyle(color: Color(0xFFE30613)),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _OptionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _OptionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFFFF4F4) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? const Color(0xFFE30613) : Colors.grey.shade200,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: selected ? const Color(0xFFE30613) : Colors.grey.shade700,
              size: 28,
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            Icon(
              selected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: selected ? const Color(0xFFE30613) : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}

class _PaymentOption extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _PaymentOption({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return _OptionCard(
      title: title,
      subtitle: subtitle,
      icon: icon,
      selected: selected,
      onTap: onTap,
    );
  }
}

class _SummaryLine extends StatelessWidget {
  final String label;
  final String value;
  final bool bold;

  const _SummaryLine({
    required this.label,
    required this.value,
    this.bold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            fontSize: bold ? 18 : 14,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: bold ? 20 : 14,
            color: bold ? const Color(0xFFE30613) : Colors.black,
          ),
        ),
      ],
    );
  }
}
