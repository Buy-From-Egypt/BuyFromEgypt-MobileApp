import 'package:buy_from_egypt/features/home/presentation/widgets/product_info_section.dart';
import 'package:flutter/material.dart';
import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:buy_from_egypt/features/auth/data/models.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/bottom_navigation_bar.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/custom_back_button.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/order_button.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/product_dot_indicator.dart';

class ProductInfoViewEx extends StatefulWidget {
  const ProductInfoViewEx({super.key, required this.product});

  final Product product;

  @override
  State<ProductInfoViewEx> createState() => _ProductInfoViewExState();
}

class _ProductInfoViewExState extends State<ProductInfoViewEx> {
  int _selectedColorIndex = 0;
  int _currentPage = 0;
  int currentIndex = 1;

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
        items: defaultNavItems,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
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
        child: CustomBackButtonF(AppColors.c5),
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
