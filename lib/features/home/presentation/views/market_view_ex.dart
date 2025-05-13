import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:buy_from_egypt/core/utils/svg_icon.dart';
import 'package:buy_from_egypt/features/auth/data/models.dart';
import 'package:buy_from_egypt/features/home/presentation/views/order1_view_ex.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/bottom_navigation_bar.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/custom_app_bar_market.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/market_filter_row.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/product_grid.dart';
import 'package:flutter/material.dart';

class MarketViewEx extends StatefulWidget {
  @override
  State<MarketViewEx> createState() => _MarketViewExState();
}

class _MarketViewExState extends State<MarketViewEx> {
  int currentIndex = 1;

  final List<Product> products = List.generate(
    8,
    (index) => Product(
      brand: 'Nike',
      name: 'Air Force Shoes',
      price: 6.50,
      image: 'assets/images/samsun.png', // Replace with your actual asset path
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBarMarket(title: 'Marketplace'),
      body: Column(
        children: [
          const MarketplaceFilterRow(), // Includes full-width divider
          const SizedBox(height: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: MarketplaceProductGrid(products: products),
            ),
          ),
        ],
      ),
    );
  }
}
