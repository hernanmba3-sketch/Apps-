import 'package:flutter/material.dart';

class StoreSelector extends StatelessWidget {
  final String selectedStore;
  final List<String> stores;
  final Function(String) onSelected;

  const StoreSelector({
    super.key,
    required this.selectedStore,
    required this.stores,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        children: [
          const Text(
            'Choose your store',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Prices and availability may vary by store.',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          ...stores.map(
            (store) => ListTile(
              onTap: () => onSelected(store),
              contentPadding: EdgeInsets.zero,
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFFFE1E3),
                child: Icon(Icons.store, color: Color(0xFFE30613)),
              ),
              title: Text(
                store,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: const Text('Open today'),
              trailing: store == selectedStore
                  ? const Icon(Icons.check_circle, color: Color(0xFFE30613))
                  : const Icon(Icons.chevron_right),
            ),
          ),
        ],
      ),
    );
  }
}
