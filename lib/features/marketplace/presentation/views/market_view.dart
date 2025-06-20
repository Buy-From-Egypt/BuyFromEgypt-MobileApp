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
  int currentPage = 1;
  int totalPages = 1;
  bool hasNextPage = false;
  bool hasPreviousPage = false;
  static const int itemsPerPage = 10;

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

  Future<void> _loadProducts({int page = 1}) async {
    if (!mounted) return;
    
    setState(() {
      isLoading = true;
      error = null;
    });

    print('Loading products for page $page...');
    try {
      final response = await ProductService.getAllProducts(
        page: page,
        limit: itemsPerPage,
      );
      print('Products loaded successfully: ${response.data.length} products');
      
      if (mounted) {
        setState(() {
          products = response.data;
          currentPage = response.currentPage;
          totalPages = response.totalPages;
          hasNextPage = response.hasNextPage;
          hasPreviousPage = response.hasPreviousPage;
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

  void _onFilterApplied(List<Product> filteredProducts) {
    print('_MarketViewState - _onFilterApplied called with ${filteredProducts.length} products');
    setState(() {
      products = filteredProducts;
      // Reset pagination when filters are applied
      currentPage = 1;
      totalPages = 1;
      hasNextPage = false;
      hasPreviousPage = false;
    });
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
        onRefresh: () => _loadProducts(page: currentPage),
        child: Column(
          children: [
            MarketplaceFilterRow(onFilterApplied: _onFilterApplied),
            const SizedBox(height: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: _buildContent(),
              ),
            ),
            if (!isLoading && error == null && products.isNotEmpty)
              _buildPaginationControls(),
          ],
        ),
      ),
    );
  }

  Widget _buildPaginationControls() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: hasPreviousPage ? () => _loadProducts(page: currentPage - 1) : null,
            icon: const Icon(Icons.chevron_left),
            color: hasPreviousPage ? AppColors.primary : Colors.grey,
          ),
          Text(
            'Page $currentPage of $totalPages',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          IconButton(
            onPressed: hasNextPage ? () => _loadProducts(page: currentPage + 1) : null,
            icon: const Icon(Icons.chevron_right),
            color: hasNextPage ? AppColors.primary : Colors.grey,
          ),
        ],
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
              onPressed: () => _loadProducts(page: currentPage),
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