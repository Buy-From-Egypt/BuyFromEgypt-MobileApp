import 'package:buy_from_egypt/features/auth/data/models.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';

class MarketplaceProductGrid extends StatelessWidget {
  final List<Product> products;

  const MarketplaceProductGrid({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
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
        return ProductCard(product: products[index]);
      },
    );
  }
}
