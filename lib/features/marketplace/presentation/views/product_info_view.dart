import 'package:buy_from_egypt/features/marketplace/presentation/data/product_model.dart';
import 'package:buy_from_egypt/features/marketplace/presentation/widgets/product_dot_indicator.dart';
import 'package:buy_from_egypt/features/marketplace/presentation/widgets/product_info_section.dart';
import 'package:flutter/material.dart';
import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/app_routes.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/bottom_navigation_bar.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/back_button.dart';
import 'package:buy_from_egypt/features/marketplace/presentation/services/saved_products_service.dart';

class ProductInfoView extends StatefulWidget {
  const ProductInfoView({
    super.key, 
    required this.product,
    required this.currentIndex,
    required this.onNavigationTap,
  });

  final Product product;
  final int currentIndex;
  final Function(int) onNavigationTap;

  @override
  State<ProductInfoView> createState() => _ProductInfoViewState();
}

class _ProductInfoViewState extends State<ProductInfoView> {
  int _selectedColorIndex = 0;
  int _currentPage = 0;
  bool _isDescriptionExpanded = false;
  bool _isSaved = false;
  bool _isLoading = false;

  final List<Color> availableColors = [
    AppColors.primary,
    AppColors.waring,
    AppColors.danger,
  ];

  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _checkSavedStatus();
  }

  Future<void> _checkSavedStatus() async {
    try {
      final isSaved = await SavedProductsService.isProductSaved(widget.product.productId);
      if (mounted) {
        setState(() {
          _isSaved = isSaved;
        });
      }
    } catch (e) {
      print('Error checking saved status: $e');
      if (e.toString().contains('not authenticated')) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Please sign in to save products'),
              action: SnackBarAction(
                label: 'Sign In',
                onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.auth);
                },
              ),
            ),
          );
        }
      }
    }
  }

  void _onSavedProductsUpdated() {
    _checkSavedStatus();
    // Refresh the saved products list if we're in the saves tab
    if (widget.currentIndex == 2) {
      Navigator.pushReplacementNamed(context, AppRoutes.save);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: CustomBottomNavigationBar(
        items: [
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
        ],
        currentIndex: widget.currentIndex,
        onTap: widget.onNavigationTap,
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(screenSize),
            _buildCarousel(screenSize),
            ProductDotIndicator(
              currentIndex: _currentPage,
              count: widget.product.images.isNotEmpty ? widget.product.images.length : 1,
            ),
            ProductInfoSection(
              productName: widget.product.name,
              productPrice: widget.product.price,
              productDescription: widget.product.description,
              availableColors: availableColors,
              onColorSelected: (index) {
                setState(() {
                  _selectedColorIndex = index;
                });
              },
              screenSize: screenSize,
              currencyCode: widget.product.currencyCode,
              selectedColorIndex: _selectedColorIndex,
              isDescriptionExpanded: _isDescriptionExpanded,
              onReadMoreTap: () {
                setState(() {
                  _isDescriptionExpanded = !_isDescriptionExpanded;
                });
              },
              productId: widget.product.productId,
              onSavedProductsUpdated: _onSavedProductsUpdated,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(Size screenSize) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenSize.width * 0.03,
        vertical: screenSize.height * 0.015,
      ),
      child: const Align(
        alignment: Alignment.centerLeft,
        child: CustomBackButton(),
      ),
    );
  }

  Widget _buildCarousel(Size screenSize) {
    if (widget.product.images.isEmpty) {
      return Expanded(
        flex: 5,
        child: Center(
          child: Icon(
            Icons.image_not_supported,
            size: screenSize.height * 0.2,
            color: Colors.grey,
          ),
        ),
      );
    }

    return Expanded(
      flex: 5,
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.product.images.length,
        onPageChanged: (index) => setState(() => _currentPage = index),
        itemBuilder: (context, index) => Center(
          child: Image.network(
            widget.product.images[index],
            height: screenSize.height * 0.28,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return const Center(
                child: Icon(Icons.image_not_supported, size: 40),
              );
            },
          ),
        ),
      ),
    );
  }
}