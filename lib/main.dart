import 'package:flutter/material.dart';

void main() => runApp(const TrendyApp());

class TrendyApp extends StatelessWidget {
  const TrendyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Mr Trendy Mens & Kids Wear',
    theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
    home: const StoreHome(),
  );
}

class StoreHome extends StatefulWidget {
  const StoreHome({super.key});
  @override
  State<StoreHome> createState() => _StoreHomeState();
}

class _StoreHomeState extends State<StoreHome> {
  final products = const [
    ('Men', 'Casual Shirt', 899),
    ('Men', 'Denim Jeans', 1299),
    ('Men', 'Cotton T-Shirt', 499),
    ('Kids', 'Kids Party Shirt', 699),
    ('Kids', 'Kids Jeans', 799),
    ('Kids', 'Kids T-Shirt', 399),
  ];
  final Map<int, int> cart = {};
  String category = 'All';

  @override
  Widget build(BuildContext context) {
    final visible = products.asMap().entries.where(
      (entry) => category == 'All' || entry.value.$1 == category,
    ).toList();
    final count = cart.values.fold<int>(0, (a, b) => a + b);
    return Scaffold(
      appBar: AppBar(
        title: const Text('MR TRENDY'),
        actions: [
          IconButton(
            icon: Badge(
              label: Text('$count'),
              child: const Icon(Icons.shopping_bag_outlined),
            ),
            onPressed: () => _showCart(context),
          ),
        ],
      ),
      body: Column(children: [
        const Padding(
          padding: EdgeInsets.all(12),
          child: Text('DEMO ONLY — Sample products and prices. No real orders or payments.'),
        ),
        Wrap(spacing: 8, children: [
          for (final option in ['All', 'Men', 'Kids'])
            ChoiceChip(
              label: Text(option),
              selected: category == option,
              onSelected: (_) => setState(() => category = option),
            ),
        ]),
        Expanded(
          child: ListView.builder(
            itemCount: visible.length,
            itemBuilder: (context, index) {
              final entry = visible[index];
              final product = entry.value;
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.checkroom, size: 36),
                  title: Text(product.$2),
                  subtitle: Text('${product.$1} • ₹${product.$3} • Sample'),
                  trailing: IconButton(
                    icon: const Icon(Icons.add_shopping_cart),
                    onPressed: () => setState(
                      () => cart[entry.key] = (cart[entry.key] ?? 0) + 1,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ]),
    );
  }

  void _showCart(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) {
        final total = cart.entries.fold<int>(
          0, (sum, entry) => sum + products[entry.key].$3 * entry.value,
        );
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              const Text('Shopping Bag', style: TextStyle(fontSize: 22)),
              for (final entry in cart.entries)
                ListTile(
                  title: Text(products[entry.key].$2),
                  trailing: Text('x${entry.value}'),
                ),
              Text('Sample total: ₹$total'),
              const SizedBox(height: 12),
              const Text('Checkout unavailable in this prototype.'),
            ]),
          ),
        );
      },
    );
  }
}
