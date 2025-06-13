import 'package:buy_from_egypt/features/marketplace/presentation/data/product_model.dart';
import 'package:buy_from_egypt/features/marketplace/presentation/views/product_info_view.dart';
import 'package:flutter/material.dart';
import 'package:buy_from_egypt/core/utils/app_routes.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductInfoView(
              product: product,
              currentIndex: 1, // Market tab index
              onNavigationTap: (index) {
                Navigator.pushReplacementNamed(context, index == 0 ? AppRoutes.home : AppRoutes.market);
              },
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(
                  product.image,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(product.brand,
              style: TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 2),
          Text(product.name,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          const SizedBox(height: 2),
          Text('${product.price.toStringAsFixed(2)} \$',
              style: TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }
}