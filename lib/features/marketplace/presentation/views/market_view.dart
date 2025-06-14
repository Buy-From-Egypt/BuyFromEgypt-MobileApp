import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/bottom_navigation_bar.dart';
import 'package:buy_from_egypt/features/marketplace/presentation/data/product_model.dart';
import 'package:buy_from_egypt/features/marketplace/presentation/services/product_service.dart';
import 'package:buy_from_egypt/features/marketplace/presentation/widgets/custom_app_bar_market.dart';
import 'package:buy_from_egypt/features/marketplace/presentation/widgets/market_place_filter_row.dart';
import 'package:buy_from_egypt/features/marketplace/presentation/widgets/product_grid.dart';
import 'package:flutter/material.dart';

class MarketView extends StatefulWidget {
  const MarketView({super.key});

  @override
  State<MarketView> createState() => _MarketViewState();
}

class _MarketViewState extends State<MarketView> {
  int currentIndex = 1;
  List<Product> products = [];
  bool isLoading = true;
  String? error;

  final List<NavItem> navItems = [
    NavItem(
        label: 'Home',
        activeIconPath: 'assets/images/home_b.svg',
        inactiveIconPath: 'assets/images/home.svg'),
    NavItem(
        label: 'Market',
        activeIconPath: 'assets/images/market_b.svg',
        inactiveIconPath: 'assets/images/market.svg'),
    NavItem(
        label: 'Orders',
        activeIconPath: 'assets/images/orders_b.svg',
        inactiveIconPath: 'assets/images/orders.svg'),
    NavItem(
        label: 'Profile',
        activeIconPath: 'assets/images/user_b.svg',
        inactiveIconPath: 'assets/images/user.svg'),
  ];

  @override
  void initState() {
    super.initState();
    print('MarketView initState called');
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    if (!mounted) return;
    
    setState(() {
      isLoading = true;
      error = null;
    });

    print('Loading products...');
    try {
      final loadedProducts = await ProductService.getAllProducts();
      print('Products loaded successfully: ${loadedProducts.length} products');
      print('First product details: ${loadedProducts.isNotEmpty ? loadedProducts.first.name : 'No products'}');
      
      if (mounted) {
        setState(() {
          products = loadedProducts;
          isLoading = false;
          error = null;
        });
      }
    } catch (e, stackTrace) {
      print('Error loading products: $e');
      print('Stack trace: $stackTrace');
      if (mounted) {
        setState(() {
          error = e.toString();
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Building MarketView with isLoading: $isLoading, error: $error, products count: ${products.length}');
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBarMarket(title: 'Marketplace'),
      bottomNavigationBar: CustomBottomNavigationBar(
        items: navItems,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
      ),
      body: RefreshIndicator(
        onRefresh: _loadProducts,
        child: Column(
          children: [
            const MarketplaceFilterRow(),
            const SizedBox(height: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: _buildContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (isLoading) {
      print('Showing loading indicator');
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: AppColors.primary),
            SizedBox(height: 16),
            Text('Loading products...'),
          ],
        ),
      );
    }

    if (error != null) {
      print('Showing error: $error');
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 48),
            const SizedBox(height: 16),
            Text(
              'Failed to load products',
              style: TextStyle(color: Colors.red[700], fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              error!,
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadProducts,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (products.isEmpty) {
      print('No products available');
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inventory_2_outlined, size: 48, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No products available',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    print('Showing product grid with ${products.length} products');
    return MarketplaceProductGrid(products: products);
  }
}