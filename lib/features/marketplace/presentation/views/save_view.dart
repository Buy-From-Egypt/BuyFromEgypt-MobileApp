import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/app_routes.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/bottom_navigation_bar.dart'
    show CustomBottomNavigationBar, NavItem;
import 'package:buy_from_egypt/features/marketplace/presentation/data/product_model.dart';
import 'package:buy_from_egypt/features/marketplace/presentation/services/saved_products_service.dart';
import 'package:buy_from_egypt/features/marketplace/presentation/widgets/custom_app_bar_market.dart';
import 'package:buy_from_egypt/features/marketplace/presentation/widgets/order2_button.dart';
import 'package:buy_from_egypt/features/marketplace/presentation/widgets/product_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SaveView extends StatefulWidget {
  final VoidCallback? onPressed;
  const SaveView({super.key, this.onPressed});
  @override
  State<SaveView> createState() => _SaveViewState();
}

class _SaveViewState extends State<SaveView> {
  int currentIndex = 1;
  List<Product> savedProducts = [];
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
  late double width;
  late double height;

  @override
  void initState() {
    super.initState();
    print('SaveView initState called');
    _loadSavedProducts();
  }

  Future<void> _loadSavedProducts() async {
    if (!mounted) return;

    print('Loading saved products...');
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final products = await SavedProductsService.getSavedProducts();
      print('Loaded ${products.length} saved products');
      if (mounted) {
        setState(() {
          savedProducts = products;
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error loading saved products: $e');
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
    final size = MediaQuery.of(context).size;
    width = size.width;
    height = size.height;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBarMarket(title: 'Saves'),
      bottomNavigationBar: CustomBottomNavigationBar(
        items: navItems,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
      ),
      body: RefreshIndicator(
        onRefresh: _loadSavedProducts,
        child: Column(
          children: [
            buildDivider(),
            const SizedBox(height: 16),
            Expanded(child: _buildContent()),
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
            Text('Loading saved products...'),
          ],
        ),
      );
    }

    if (error != null) {
      print('Showing error: $error');
      if (error!.contains('not authenticated')) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.lock_outline, color: Colors.orange, size: 48),
              const SizedBox(height: 16),
              Text(
                'Please sign in to view saved products',
                style: TextStyle(color: Colors.orange[700], fontSize: 16),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.auth);
                },
                child: const Text('Sign In'),
              ),
            ],
          ),
        );
      }
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 48),
            const SizedBox(height: 16),
            Text(
              'Failed to load saved products',
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
              onPressed: _loadSavedProducts,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (savedProducts.isEmpty) {
      print('No saved products available');
      return SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: SizedBox(
          height: height,
          child: Column(
            children: [
              SizedBox(height: height * 0.12),
              buildEmptyOrderImage(imagePath: 'assets/images/Empty bookmark.svg'),
              SizedBox(height: height * 0.05),
              buildEmptyOrderTexts(),
              SizedBox(height: height * 0.15),
              Orders1Button(
                text: 'Explore Marketplace',
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.market);
                },
              ),
            ],
          ),
        ),
      );
    }

    print('Showing product grid with ${savedProducts.length} products');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: MarketplaceProductGrid(products: savedProducts),
    );
  }

  Widget buildDivider() {
    return Divider(
      color: AppColors.c5,
      thickness: 1,
      height: 1,
    );
  }

  Widget buildEmptyOrderImage({required String imagePath}) {
    return SvgPicture.asset(
      imagePath,
      width: width * 0.5,
      height: height * 0.25,
    );
  }

  Widget buildEmptyOrderTexts() {
    return Column(
      children: [
        Text(
          'No saved products yet!',
          style: Styles.textStyle22b,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: height * 0.03),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.06),
          child: Text(
            'Start exploring and save the products',
            style: Styles.textStyle14b,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: height * 0.01),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.12),
          child: Text(
            'you like to find them here later',
            style: Styles.textStyle14b,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
