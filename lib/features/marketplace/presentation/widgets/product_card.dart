import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/features/marketplace/presentation/data/product_model.dart';
import 'package:buy_from_egypt/features/marketplace/presentation/views/product_info_view.dart';
import 'package:flutter/material.dart';
import 'package:buy_from_egypt/core/utils/app_routes.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    print('Building ProductCard for: ${product.name}');
    print('Product details:');
    print('- Price: ${product.price} ${product.currencyCode}');
    print('- Category: ${product.category?.name ?? 'Uncategorized'}');
    print('- Images: ${product.images.length}');

    return GestureDetector(
      onTap: () {
        print('Product card tapped: ${product.name}');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductInfoView(
              product: product,
              currentIndex: 1, // Market tab index
              onNavigationTap: (index) {
                Navigator.pushReplacementNamed(
                  context,
                  index == 0 ? AppRoutes.home : AppRoutes.market,
                );
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
                color: AppColors.newBeige,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: product.images.isNotEmpty
                    ? Image.network(
                        product.images.first,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          print('Error loading image for ${product.name}: $error');
                          return const Center(
                            child: Icon(Icons.image_not_supported, size: 40),
                          );
                        },
                      )
                    : const Center(
                        child: Icon(Icons.image_not_supported, size: 40),
                      ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            product.category?.name ?? 'Uncategorized',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 2),
          Text(
            product.name,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            '${product.price.toStringAsFixed(2)} ${product.currencyCode}',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
