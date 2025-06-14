import 'package:buy_from_egypt/features/marketplace/presentation/data/product_model.dart';
import 'package:buy_from_egypt/features/marketplace/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';

class MarketplaceProductGrid extends StatelessWidget {
  final List<Product> products;

  const MarketplaceProductGrid({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    print('Building ProductGrid with ${products.length} products');
    if (products.isNotEmpty) {
      print('First product in grid: ${products.first.name}');
    }

    return GridView.builder(
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 18,
        crossAxisSpacing: 18,
        childAspectRatio: 0.72,
      ),
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductCard(product: product);
      },
    );
  }
}
