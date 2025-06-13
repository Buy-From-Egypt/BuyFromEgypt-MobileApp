import 'package:buy_from_egypt/features/marketplace/presentation/data/product_model.dart';
import 'package:buy_from_egypt/features/marketplace/presentation/widgets/product_dot_indicator.dart';
import 'package:buy_from_egypt/features/marketplace/presentation/widgets/product_info_section.dart';
import 'package:flutter/material.dart';
import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/bottom_navigation_bar.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/back_button.dart';

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

  final List<String> productImages = [
    'assets/images/buy from egypt logo m 1.png',
    'assets/images/buy from egypt logo m 1.png',
    'assets/images/buy from egypt logo m 1.png',
    'assets/images/buy from egypt logo m 1.png',
  ];

  final List<Color> availableColors = [
    AppColors.primary,
    AppColors.waring,
    AppColors.danger,
  ];
  final String productName = "Air Force Shoes";
  final double productPrice = 6.50;
  final String productDescription =
      "The Nike Air Force 1 is a timeless sneaker that combines classic design with modern comfort. Crafted with premium leather and ";

  final PageController _pageController = PageController();

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
              count: productImages.length,
            ),
            ProductInfoSection(
              productName: productName,
              productPrice: productPrice,
              productDescription: productDescription,
              availableColors: availableColors,
              onColorSelected: (index) {
                // Handle color selection
                print("Color selected: $index");
              },
              screenSize: screenSize,
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
    return Expanded(
      flex: 5,
      child: PageView.builder(
        controller: _pageController,
        itemCount: productImages.length,
        onPageChanged: (index) => setState(() => _currentPage = index),
        itemBuilder: (context, index) => Center(
          child: Image.asset(
            productImages[index],
            height: screenSize.height * 0.28,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}